import 'package:flutter/material.dart';

import '../../../../../core/widgets/enable_biometrics_dialog.dart';

class BiometricLoginViewModel {
  void showBiometricDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => EnableBiometricsDialog(),
  );
}
