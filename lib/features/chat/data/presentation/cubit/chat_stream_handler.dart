import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:lara_ai/features/chat/domain/repositories/i_chat_repository.dart';

class ChatStreamHandler {
  final IChatRepositoryCustom repository;

  ChatStreamHandler(this.repository);

  /// Processa a mensagem completa (stream + fallback + throttle)
  Future<void> processMessage(
    String text, {
    required Function(String chunk)
    onChunkReceived, // chamado a cada pedaço (throttled)
    required Function(String fullResponse) onComplete,
    required Function(String error) onError,
  }) async {
    String fullResponse = '';
    DateTime? lastEmit;
    StreamSubscription<String>? sub;
    Timer? fallbackTimer;
    bool firstChunkArrived = false;
    final streamDone = Completer<void>();

    try {
      final stream = repository.sendMessage(text);
      final sendStart = DateTime.now();

      // Fallback
      fallbackTimer = Timer(
        const Duration(seconds: 3, milliseconds: 500),
        () async {
          if (!firstChunkArrived) {
            if (kDebugMode) {
              debugPrint(
                '[StreamHandler] FALLBACK após ${DateTime.now().difference(sendStart).inMilliseconds}ms',
              );
            }
            await _handleFallback(text, sub, streamDone, onComplete, onError);
          }
        },
      );

      bool isFirstChunk = true;

      sub = stream.listen(
        (chunk) {
          if (!firstChunkArrived) {
            firstChunkArrived = true;
            fallbackTimer?.cancel();
          }

          if (isFirstChunk) {
            _logTimeToFirstChunk(sendStart);
            isFirstChunk = false;
          }

          fullResponse += chunk;

          // Throttle de 60ms
          if (lastEmit == null ||
              DateTime.now().difference(lastEmit!) >
                  const Duration(milliseconds: 60)) {
            lastEmit = DateTime.now();
            onChunkReceived(fullResponse);
          }
        },
        onError: (e, s) {
          if (kDebugMode) debugPrint('stream error: $e\n$s');
          onError(e.toString());
          if (!streamDone.isCompleted) streamDone.complete();
        },
        onDone: () async {
          fallbackTimer?.cancel();
          // persist final AI message
          try {
            await repository.persistAiMessage(fullResponse);
          } catch (e) {
            if (kDebugMode) debugPrint('[StreamHandler] persist error: $e');
          }
          if (!streamDone.isCompleted) streamDone.complete();
          onComplete(fullResponse);
        },
        cancelOnError: true,
      );

      await streamDone.future;
    } catch (e) {
      onError(e.toString());
    } finally {
      fallbackTimer?.cancel();
      await sub?.cancel();
    }
  }

  Future<void> _handleFallback(
    String text,
    StreamSubscription? sub,
    Completer<void> streamDone,
    Function(String) onComplete,
    Function(String) onError,
  ) async {
    try {
      await sub?.cancel();
      final finalText = await repository.sendMessageOnce(text);
      // persist final
      try {
        await repository.persistAiMessage(finalText);
      } catch (e) {
        if (kDebugMode) {
          debugPrint('[StreamHandler] persist fallback error: $e');
        }
      }
      onComplete(finalText);
    } catch (e) {
      if (kDebugMode) debugPrint('[StreamHandler] fallback error: $e');
      onError(e.toString());
    } finally {
      if (!streamDone.isCompleted) streamDone.complete();
    }
  }

  void _logTimeToFirstChunk(DateTime sendStart) {
    if (kDebugMode) {
      final elapsed = DateTime.now().difference(sendStart);
      debugPrint(
        '[StreamHandler] time to first chunk: ${elapsed.inMilliseconds} ms',
      );
    }
  }
}
