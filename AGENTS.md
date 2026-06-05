# Workflow Trigger PR

When the user says "deploy the workflow trigger" or "make a workflow trigger PR", follow these steps:

## Steps

1. **Create a new branch** from `main`:
   ```
   git checkout -b trigger-workflow-readme
   ```

2. **Update `README.md`** — replace the `<!-- Trigger workflow -->` HTML comment with GitHub Actions deployment status badges:
   ```
   [![Deploy Jaspr](https://github.com/0xPr0F3ss0r/Personal-Portfolio/actions/workflows/deploy.yml/badge.svg)](https://github.com/0xPr0F3ss0r/Personal-Portfolio/actions/workflows/deploy.yml)
   [![Firebase Hosting PR Preview](https://github.com/0xPr0F3ss0r/Personal-Portfolio/actions/workflows/firebase-hosting-pull-request.yml/badge.svg)](https://github.com/0xPr0F3ss0r/Personal-Portfolio/actions/workflows/firebase-hosting-pull-request.yml)
   ```

3. **Update `.github/workflows/deploy.yml`** — add `workflow_dispatch:` trigger alongside the existing push trigger.

4. **Stage, commit, and push:**
   ```
   git add README.md .github/workflows/deploy.yml
   git commit -m "Add deployment status badges and manual workflow trigger"
   git push -u origin trigger-workflow-readme
   ```

5. **Create a PR** on GitHub at:
   https://github.com/0xPr0F3ss0r/Personal-Portfolio/pull/new/trigger-workflow-readme

6. The PR creation will automatically trigger the **Firebase Hosting PR Preview** workflow (`.github/workflows/firebase-hosting-pull-request.yml`).
