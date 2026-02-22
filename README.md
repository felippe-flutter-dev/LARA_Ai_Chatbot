# LARA AI - Sua Assistente Inteligente e Bem-Humorada 🚀

[![LARA AI CI/CD](https://github.com/Valtinho/lara_ai/actions/workflows/ci.yml/badge.svg)](https://github.com/Valtinho/lara_ai/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

LARA é uma Prova de Conceito (POC) de alto nível desenvolvida em Flutter, integrando Inteligência Artificial real (Google Gemini) com uma arquitetura robusta, escalável e resiliente. O projeto foi desenhado para demonstrar excelência técnica em engenharia de software mobile e experiência do usuário.

[NISERI IMAGEM [Banner ou Mockup do App] AQUI]

---

## 🎨 Design & Prototipagem (Figma)
Todo o desenvolvimento foi precedido por um estudo rigoroso de interface e experiência do usuário no Figma, garantindo fidelidade visual e uma jornada fluida.
- **Link do Protótipo:** [Acesse aqui no Figma](https://www.figma.com/design/ZY6hmmJcxiJ2Tt9YqJembk/Sem-t%C3%ADtulo?node-id=0-1&t=hiYuSkCtsmeLRykM-1)

---

## 🏛️ Arquitetura e Engenharia de Software
Este projeto não é apenas um chat; é um modelo de aplicação de padrões de projeto modernos:

- **Clean Architecture:** Divisão clara entre Dados (Data), Negócio (Domain) e Interface (Presentation).
- **MVVM (Model-View-ViewModel):** Toda a lógica das Views é delegada para ViewModels, utilizando o padrão `stateObserver` para manter widgets puramente declarativos.
- **Gerenciamento de Estado:** Utilização de **BLoC/Cubit** para fluxos de dados reativos e previsíveis.
- **Injeção de Dependências:** Controle total via **Flutter Modular**.
- **Princípios SOLID:** Código focado em manutenibilidade e baixo acoplamento.
- **Internacionalização (i18n):** Suporte nativo completo para **Português (BR)** e **Inglês (EN)** via arquivos `.arb`.

---

## ✨ Funcionalidades em Destaque

### 🤖 IA Real com Personalidade
A LARA utiliza a API do **Google Gemini** com efeito de **Streaming**. 
- **Troca de Personalidade:** Alterne entre os modos *Normal*, *Conciso* ou *Sarcástico* em tempo real.
- **Suporte a Markdown:** Respostas ricas com tabelas, blocos de código, negrito e listas.
- **Ajustes Técnicos:** Controle de temperatura e limite de resposta via UI.

[NISERI IMAGEM [Configurações da LARA] AQUI]

### 🔒 Segurança e Privacidade de Elite
- **Autenticação Multi-Fator (MFA):** Proteção via biometria nativa (FaceID/Digital) na entrada e após o login.
- **Isolamento de Dados:** Histórico vinculado ao UUID do Firebase, garantindo privacidade total.

[NISERI IMAGEM [Fluxo de Biometria] AQUI]

### 🛠️ Resiliência e UX
- **Tratamento de Erros:** Mapeamento de erros técnicos para mensagens humanas e acolhedoras.
- **Retry Inteligente:** Em caso de falha, o texto do usuário volta automaticamente para o campo de edição.

[NISERI IMAGEM [Fluxo de Erro e Retry] AQUI]

---

## 🚀 Automação e Qualidade (Double Shield)

1. **Pipeline Local (`.push.bat`):** Script de automação customizado que realiza a limpeza do projeto, análise de linter e executa todos os testes unitários/widget localmente. **Garante que nenhum erro seja enviado para o repositório.**
2. **GitHub Actions (CI/CD):** Workflow remoto que valida novamente o build e testes em ambiente de integração contínua.

---

## 📦 Como Rodar o Projeto

### 1. Requisitos
- Flutter SDK (Channel Stable)
- Chave de API do Gemini ([Obtenha aqui](https://aistudio.google.com/))
- Firebase configurado (Google e E-mail/Senha ativos)

### 2. Instalação
```bash
git clone https://github.com/Valtinho/lara_ai.git
cd lara_ai
flutter pub get
```

### 3. Configuração
Crie um arquivo `.env` na raiz:
```env
API_KEY=SUA_CHAVE_AQUI
```
Adicione o `google-services.json` em `android/app/`.

---

## 🧪 Testes Automatizados

### Unitários e Widget
```bash
flutter test
```

### ⚠️ Teste de Integração (E2E)
Para rodar os testes de integração, execute:
```bash
flutter test integration_test/app_test.dart
```
**NOTA IMPORTANTE:** Como o teste interage com recursos de segurança do sistema, **você deve estar com o celular em mãos**. Será necessário interagir manualmente quando o popup do Google Login aparecer para selecionar a conta e validar o sensor biométrico (Digital/FaceID) quando solicitado. O script aguardará essas ações para prosseguir.

---

## 👨‍💻 Desenvolvedor
**Felippe Pinheiro**  
Especialista em Desenvolvimento Mobile Flutter.

- [LinkedIn](https://www.linkedin.com/in/felippe-pinheiro-dev-flutter/)
- [GitHub](https://github.com/Valtinho)

---
Licença **MIT**.
