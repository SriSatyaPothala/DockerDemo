# Jenkins CI/CD Pipeline with Webhook, Backup, and Email Notification

This project sets up a Jenkins pipeline that:

- Is triggered automatically by a Git webhook.
- Runs a Jenkins backup shell script.
- Sends an email notification with the script file attached, regardless of build success or failure.

---
## 🛠️ Setup Steps

1. **Launch an EC2 Instance** and install Jenkins.
2. **Install the "Generic Webhook Trigger" plugin** from Jenkins Plugin Manager.
3. **Configure Email Notifications**:
   - Go to `Manage Jenkins` → `Configure System`
   - Set up the **Extended E-mail Notification** section with your SMTP (e.g., Gmail).
4. **Create a Jenkins Pipeline File (`Jenkinsfile`)** and push it to your GitHub repository.
5. **Create a Pipeline Job in Jenkins**:
   - Select **"Pipeline script from SCM"** as the definition.
   - Configure Git repository and branch.
   - Enable **Generic Webhook Trigger** under "Build Triggers".
   - Use a **secret text token** stored in **Jenkins Credentials** (global scope).
6. **Get the Webhook URL** from the pipeline job (e.g.,  
   `http://<jenkins-url>/generic-webhook-trigger/invoke?token=<your-token>`) and:
   - Go to **GitHub → Repo → Settings → Webhooks**
   - Add the Jenkins URL
   - Set the trigger to **"Just the push event"**

---

## 📜 Pipeline Functionality

- The `Jenkinsfile` contains a simple pipeline:
  - **Stage 1 – Checkout & Display**:
    - Jenkins checks out the GitHub repository
    - It navigates to the `jenkins/` directory and runs:
      ```bash
      cat jenkins_backup.sh
      ```
    - The script contents are printed to the Jenkins console output.
  - **Post Step – Email Notification**:
    - After the stages finish (success or failure), Jenkins sends an email.
    - The email includes:
      - Job name, build number, result, and duration
      - A link to the Jenkins build
      - The `jenkins_backup.sh` file as an **email attachment**


## ⚙️ Jenkins Setup

### 1. Pipeline Configuration
- **Type**: Pipeline using "Pipeline script from SCM"
- **Repository**: https://github.com/SriSatyaPothala/DockerDemo.git
- **Triggers**: Webhook

### 2. Webhook Configuration
Set the webhook in your Git provider (GitHub):

- **GitHub**:  
  `http://<your-jenkins-host>/github-webhook/token=`
Make sure your Jenkins server is reachable by your Git server.

## 📜 Jenkinsfile Contents
-  https://github.com/SriSatyaPothala/DockerDemo/jenkinsfile

📧 Email Notification
Sent after every build (success, failure, unstable, etc.).

Includes:
- Build result and metadata

- Direct link to Jenkins build

- The jenkins_backup.sh file as an attachment

✅ Prerequisites
- Jenkins server set up and running

- Email SMTP configured in Jenkins

- Email Extension Plugin installed

- Proper webhook configured in your Git repo

Note: All the output screenshots are inside the folder output_screenshots.