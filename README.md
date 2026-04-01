# LARA AI - Assistente Inteligente com Personalidade Adaptável 🚀

[![LARA AI CI/CD](https://github.com/felippe-flutter-dev/LARA_Ai_Chatbot/actions/workflows/ci.yml/badge.svg)](https://github.com/Valtinho/lara_ai/actions/workflows/ci.yml)
[![Latest Release](https://img.shields.io/github/v/release/felippe-flutter-dev/LARA_Ai_Chatbot?label=Download%20APK&logo=android&color=brightgreen)](https://github.com/felippe-flutter-dev/LARA_Ai_Chatbot/releases/latest)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

LARA é uma Prova de Conceito (POC) de alto nível desenvolvida em Flutter, que integra a API do Google Gemini a uma arquitetura mobile robusta e escalável. O projeto foi construído para demonstrar como a IA pode ser personalizada para contextos específicos de negócio, utilizando como **estudo de caso** a persona da Multiplier Educação.

<img src=https://github.com/user-attachments/assets/7933e79d-c102-4723-be96-04a176ff0b06 width="800"/>

---

## 🚀 Engenharia de Qualidade e DevOps (CI/CD)
O projeto implementa um fluxo de **entrega contínua e proteção de código** rigoroso, garantindo que apenas versões estáveis cheguem à produção.

### 🛡️ Pipeline Local (`.push.bat`)
Para evitar falhas no repositório remoto e garantir a integridade do `main`, foi desenvolvido um script de automação local. Antes de cada commit, o script executa:
1. **Auto-fix & Formatação:** Correção automática de problemas simples e padronização.
2. **Análise Estática (Linter):** Verificação rigorosa de regras de código.
3. **Testes Unitários:** Execução obrigatória de todos os testes.
4. **Git Flow Automatizado:** Se aprovado, o script solicita a mensagem de commit e realiza o `push` para a branch atual.

### ⚙️ GitHub Actions & Fastlane (Double Shield)
A infraestrutura de CI/CD automatiza o ciclo de vida desde o desenvolvimento até o release:
* **Validação de Branches:** Controle de nomenclatura (ex: `dev/LARA-XXX_feat`) para manter a organização do projeto.
* **Merge Automático:** Pull Requests em `dev` são validados e integrados automaticamente em `staging` e, por fim, em `main`.
* **Deploy com Fastlane:** Ao atingir a branch `main`, o **Fastlane** assume a automação do build Android, gerando o APK de release com versionamento dinâmico.
* **GitHub Releases:** O binário final (.apk) é automaticamente publicado no GitHub Releases via CI.

---

## 🎨 Design & Prototipagem (Figma)
Todo o desenvolvimento foi precedido por um estudo rigoroso de interface e experiência do usuário no Figma, garantindo fidelidade visual e uma jornada fluida.
- **Link do Protótipo:** [Acesse aqui no Figma](https://www.figma.com/design/ZY6hmmJcxiJ2Tt9YqJembk/Sem-t%C3%ADtulo?node-id=0-1&t=hiYuSkCtsmeLRykM-1)

---

## 🎯 O Conceito
A proposta deste projeto é ir além do "chat genérico". A LARA demonstra o uso de **Engenharia de Prompt** avançada para criar uma assistente com nicho definido (Educação Executiva e Investimentos) e personalidades trocáveis em tempo real.

### 🎭 Engine de Personalidades
O sistema utiliza um injetor dinâmico de prompts que permite ao usuário alternar entre três comportamentos:
* **Normal:** Uma assistente leve, bem-humorada e inteligente.
* **Conciso:** Foco em pragmatismo, entregando respostas curtas e diretas ao ponto.
* **Sarcástico:** Uma persona ácida e irônica, que utiliza o sarcasmo como ferramenta de provocação intelectual.

---

## 🏛️ Arquitetura e Engenharia de Software
Este projeto não é apenas um chat; é um modelo de aplicação de padrões de projeto modernos:

- **Clean Architecture:** Divisão clara entre Dados (Data), Negócio (Domain) e Interface (Presentation).
- **MVVM (Model-View-ViewModel):** Toda a lógica das Views é delegada para ViewModels, utilizando o padrão `stateObserver` para manter widgets puramente declarativos.
- **Gerenciamento de Estado:** Utilização de **BLoC/Cubit** para fluxos de dados reativos e previsíveis.
- **Injeção de Dependências:** Controle total via **Flutter Modular**.
- **Princípios SOLID:** Código focado em manutenibilidade e baixo acoplamento.
- **Internacionalização (i18n):** Suporte nativo completo para **Português (BR)** e **Inglês (EN)** via arquivos `.arb`.

### 📊Diagrama da arquitetura
<img width="700" alt="Untitled diagram-2026-02-22-235540" src="https://github.com/user-attachments/assets/2da46e91-f891-402c-a915-8a297a68ece9" />

---

## ✨ Funcionalidades em Destaque

### 🤖 IA Real com Personalidade & Visual Rico
A LARA utiliza a API do **Google Gemini** com efeito de **Streaming** e renderização visual avançada.
- **Troca de Personalidade:** Alterne entre os modos *Normal*, *Conciso* ou *Sarcástico* em tempo real.
- **Renderização Markdown Completa:** A LARA não envia apenas texto plano. Ela é capaz de gerar e formatar:
  - 📊 **Tabelas** organizadas;
  - 💻 **Blocos de código** com syntax highlighting (dart, python, js, etc.);
  - 📝 **Listas, citações e negrito** para facilitar a leitura.
- **Ajustes Técnicos:** Controle de temperatura e limite de tokens via UI.

<img src=https://github.com/user-attachments/assets/d04ca9d9-b95c-4bc0-9c5b-2c44a2df6761 width="200"/>
<img src=https://github.com/user-attachments/assets/79fb05f2-bc04-4fa9-9bcc-f124824a5822 width="200"/>

### 📊 Diagrama de funcionamento da IA
<img width="700" alt="Untitled diagram-2026-02-22-235706" src="https://github.com/user-attachments/assets/76f9a759-87bd-4eef-9412-11f026eb4f8f" />

---

### 💾 Persistência de Dados e Isolamento (Local Database)
A experiência da LARA é contínua, rápida e segura, utilizando persistência local robusta.

**Histórico Persistente** (SQLite): As conversas são salvas localmente utilizando o plugin sqflite. Isso garante que o histórico seja preservado mesmo após o fechamento do app e permite acesso instantâneo às mensagens anteriores, independente de conexão com a internet.

**Isolamento de Dados**: As mensagens são indexadas e vinculadas ao perfil do usuário autenticado. O banco de dados local garante que a experiência seja personalizada e os dados fiquem armazenados de forma segura no dispositivo, respeitando a privacidade e a integridade das informações do usuário.

### 📊 Diagrama da tabela de dados.
<img width="200" alt="Untitled diagram-2026-02-22-235821" src="https://github.com/user-attachments/assets/2fd9ffcb-552f-468e-85b6-554221630f0f" />

---

### 🔒 Segurança e Privacidade de Elite
- **Autenticação Multi-Fator (MFA):** Proteção via biometria nativa (FaceID/Digital) na entrada e após o login.
- **Isolamento de Dados:** Histórico vinculado ao UUID do Firebase, garantindo privacidade total.

<img src=https://github.com/user-attachments/assets/7ded403f-4b2b-4140-9282-6f620c3740e5 width="200"/>
<img src=https://github.com/user-attachments/assets/34297d0e-d2f1-4145-bd26-d0bb6128851c width="200"/>

### 🛠️ Resiliência e UX
- **Tratamento de Erros:** Mapeamento de erros técnicos para mensagens humanas e acolhedoras.
- **Retry Inteligente:** Em caso de falha, o texto do usuário volta automaticamente para o campo de edição.

---

## 🚀 Automação e Qualidade (Double Shield)

1. **Pipeline Local (`.push.bat`):** Script de automação customizado que realiza a limpeza do projeto, análise de linter e executa todos os testes unitários/widget localmente. **Garante que nenhum erro seja enviado para o repositório.**
2. **GitHub Actions (CI/CD):** Workflow remoto que valida novamente o build e testes em ambiente de integração contínua.

---

## 🌑 Modo noturno
<img width="150" alt="Screenshot_20260221_205338" src="https://github.com/user-attachments/assets/f90ef5e8-89f3-450b-b110-e2722d48f0cb" />
<img width="150" alt="Screenshot_20260221_205521" src="https://github.com/user-attachments/assets/39fbd130-769d-41cc-966f-f44c5e968e90" />
<img width="150" alt="Screenshot_20260221_205531" src="https://github.com/user-attachments/assets/05ab3906-3087-4fed-a4e2-5554448f8a53" />
<img width="150" alt="Screenshot_20260221_205820" src="https://github.com/user-attachments/assets/b4556a7b-f743-42cd-bea8-95afd5b3a50c" />
<img width="150" alt="Screenshot_20260221_205834" src="https://github.com/user-attachments/assets/6d0247f6-2358-4ee1-ba3c-851fd717df81" />

---

## ☀️ Modo Claro
<img width="150" alt="Screenshot_20260221_205447" src="https://github.com/user-attachments/assets/c39a5abb-5b3a-4b9c-bbe6-925d7f15507a" />
<img width="150" alt="Screenshot_20260221_205512" src="https://github.com/user-attachments/assets/26ecc668-8e29-4b80-9bf4-aa2adbc23aa2" />
<img width="150" alt="Screenshot_20260221_205542" src="https://github.com/user-attachments/assets/3ff4d8b1-215b-48b9-98b8-ad166259aee2" />
<img width="150" alt="Screenshot_20260221_205807" src="https://github.com/user-attachments/assets/c3ecacb4-4427-4ddf-90db-73145c1f18fd" />
<img width="150" alt="Screenshot_20260221_205850" src="https://github.com/user-attachments/assets/8a559fa6-f7f5-47d2-9dc2-91eb3413256e" />

---

## 📦 Como Rodar o Projeto

### 1. Requisitos
- Flutter SDK (Channel Stable)
- Chave de API do Gemini ([Obtenha aqui](https://aistudio.google.com/))
- Firebase configurado (Google e E-mail/Senha ativos)

### 2. Instalação
```bash
git clone https://github.com/felippe-flutter-dev/LARA_Ai_Chatbot.git
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
