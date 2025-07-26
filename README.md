# 🛠️ Portainer GitOps Stack

[![Lint](https://github.com/kpeacocke/gitops-portainer-stack/actions/workflows/lint.yml/badge.svg)](https://github.com/kpeacocke/gitops-portainer-stack/actions/workflows/lint.yml)
[![Validate](https://github.com/kpeacocke/gitops-portainer-stack/actions/workflows/validate.yml/badge.svg)](https://github.com/kpeacocke/gitops-portainer-stack/actions/workflows/validate.yml)

This repository contains a secure, maintainable Docker Compose stack to deploy [Portainer](https://www.portainer.io/) Server and Agent using GitOps best practices.

Designed for self-hosted environments like Synology NAS, this setup enables full host management via the Portainer Agent while maintaining security and clean version control.

---

## 🚀 Features

- ✅ Portainer Server + Agent in one stack
- 🔒 Secure `.env` handling (never commit secrets)
- 🔁 GitOps-ready: used via Portainer Git stack sync
- 🧱 Modular folder structure for growth
- 🧪 Justfile for CLI tasks
- 🔐 Branch protection and enforced pre-commit linting

---

## 🧰 Project Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/YOUR_USERNAME/portainer-deploy.git
   cd portainer-deploy
   ```

2. **Set up the local environment:**

   - Install [`direnv`](https://direnv.net) and [`just`](https://github.com/casey/just)
   - Allow env loading:

     ```bash
     direnv allow
     ```

   - Create local config:

     ```bash
     cp stack/.env.sample stack/.env
     ```

3. **Deploy the stack:**

   ```bash
   just deploy
   ```

4. **Install and use pre-commit hooks:**

   ```bash
   pip install pre-commit
   pre-commit install
   pre-commit run --all-files
   ```

---

## 🔄 GitOps Flow

All changes must go through a Pull Request.

```text
feature/* → Pull Request → main
```

🚫 Direct commits to `main` are disabled by branch protection rules.

---

## 🧪 Validate & Deploy Locally

```bash
just validate   # Validate the stack
just deploy     # Deploy stack
just down       # Tear down
```

---

## 📋 File Layout

```text
portainer-deploy/
├── stack/                      # Compose files and env templates
├── .github/                    # Workflows and CODEOWNERS
├── docs/                       # Optional docs
├── Justfile                    # CLI task runner
├── .pre-commit-config.yaml     # Hooks
├── .tool-versions              # Tool pinning
├── .envrc                      # direnv integration
```

---

## 📄 License

This project is licensed under the [MIT License](./LICENSE).

---

## 🛡️ Security

Please review [SECURITY.md](./SECURITY.md) and report concerns to [krpeacocke@gmail.com](mailto:krpeacocke@gmail.com)

---
