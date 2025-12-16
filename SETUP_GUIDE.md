# Social Media Automation with n8n - Setup Guide

## Overview
This project provides a complete n8n workflow for automated daily social media content creation and posting. The agent works daily as a full content creator, generating engaging posts and distributing them across multiple platforms.

## Features

### 🤖 Automated Content Creation
- **AI-Powered Generation**: Uses OpenAI's GPT to create original, engaging content
- **Daily Schedule**: Automatically runs every day at 9:00 AM (configurable)
- **Multi-Platform Support**: Posts to Twitter, LinkedIn, and more
- **Content Logging**: Tracks all posts in Google Sheets
- **Backup System**: Saves post history to Dropbox
- **Notifications**: Sends success alerts via Slack

### 📅 Daily Automation
The workflow is triggered daily by a cron schedule (`0 9 * * *` = 9:00 AM daily) and performs:
1. Content generation with AI
2. Formatting and optimization
3. Multi-platform posting
4. Logging and backup
5. Success notification

## Installation

### Prerequisites
- Docker and Docker Compose (recommended) OR Node.js 18+
- n8n account or self-hosted instance
- API credentials for each platform you want to use

### Method 1: Docker (Recommended)

1. **Install Docker**
   ```bash
   # Follow instructions at: https://docs.docker.com/get-docker/
   ```

2. **Create docker-compose.yml**
   ```bash
   curl -o docker-compose.yml https://raw.githubusercontent.com/n8n-io/n8n/master/docker/compose/withPostgres/docker-compose.yml
   ```

3. **Start n8n**
   ```bash
   docker-compose up -d
   ```

4. **Access n8n**
   - Open browser to: http://localhost:5678
   - Complete initial setup

### Method 2: NPM Installation

1. **Install n8n globally**
   ```bash
   npm install -g n8n
   ```

2. **Start n8n**
   ```bash
   n8n start
   ```

3. **Access n8n**
   - Open browser to: http://localhost:5678

## Configuration

### Step 1: Set Up Environment Variables

1. **Copy the example environment file**
   ```bash
   cp .env.example .env
   ```

2. **Edit .env with your credentials**
   - Add your API keys for each service
   - Configure timezone and schedule preferences
   - Enable/disable features as needed

### Step 2: Configure API Credentials in n8n

#### OpenAI (Content Generation)
1. Go to: https://platform.openai.com/api-keys
2. Create new API key
3. In n8n, add OpenAI credentials:
   - Settings > Credentials > Add Credential > OpenAI
   - Paste your API key

#### Twitter
1. Go to: https://developer.twitter.com/en/portal/dashboard
2. Create app and get credentials
3. In n8n, add Twitter OAuth1 credentials:
   - Settings > Credentials > Add Credential > Twitter OAuth1 API
   - Fill in API Key, API Secret, Access Token, Access Secret

#### LinkedIn
1. Go to: https://www.linkedin.com/developers/apps
2. Create app and configure OAuth
3. In n8n, add LinkedIn OAuth2 credentials:
   - Settings > Credentials > Add Credential > LinkedIn OAuth2 API
   - Complete OAuth flow

#### Google Sheets (Optional - for logging)
1. Create Google Cloud project
2. Enable Google Sheets API
3. Create service account and download JSON key
4. In n8n, add Google Sheets credentials:
   - Settings > Credentials > Add Credential > Google Sheets OAuth2 API
   - Upload service account JSON

#### Dropbox (Optional - for backup)
1. Go to: https://www.dropbox.com/developers/apps
2. Create app and get access token
3. In n8n, add Dropbox credentials:
   - Settings > Credentials > Add Credential > Dropbox OAuth2 API
   - Enter access token

#### Slack (Optional - for notifications)
1. Create Slack app: https://api.slack.com/apps
2. Enable Incoming Webhooks
3. In n8n, add Slack credentials:
   - Settings > Credentials > Add Credential > Slack API
   - Enter webhook URL

### Step 3: Import Workflow

1. **Open n8n dashboard**
2. **Click "Import from File"**
3. **Select** `social-media-automation-workflow.json`
4. **Configure each node's credentials**:
   - Click on each node
   - Select the appropriate credential
   - Test connection
5. **Activate workflow**
   - Toggle "Active" switch in top-right

## Usage

### Manual Testing
1. Open the workflow in n8n
2. Click "Execute Workflow" button
3. Watch execution in real-time
4. Check results on your social media platforms

### Automated Daily Execution
Once activated, the workflow will:
- Run automatically every day at 9:00 AM (your timezone)
- Generate fresh content using AI
- Post to configured platforms
- Log results to Google Sheets
- Send notification to Slack

### Customization

#### Change Schedule Time
Edit the Schedule Trigger node:
```javascript
// Default: 9:00 AM daily
"0 9 * * *"

// Examples:
"0 12 * * *"  // Noon daily
"0 9 * * 1-5" // 9 AM weekdays only
"0 9,15 * * *" // 9 AM and 3 PM daily
```

#### Customize Content Style
Edit the AI Content Generator node's prompt:
```
You are a creative social media content creator...
[Modify prompt to match your brand voice]
```

#### Add More Platforms
1. Add new node (e.g., Facebook, Instagram)
2. Connect from "Format Content" node
3. Configure platform credentials
4. Test and activate

#### Modify Content Topics
Edit `.env` file:
```
CONTENT_TOPICS=your,custom,topics,here
```

## Workflow Architecture

```
┌─────────────────────────┐
│  Daily Schedule         │
│  (9:00 AM Cron)        │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  AI Content Generator   │
│  (OpenAI GPT)          │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  Format Content         │
│  (Process & Optimize)   │
└────┬──────────────┬─────┘
     │              │
     ▼              ▼
┌─────────┐    ┌─────────┐
│ Twitter │    │LinkedIn │
└────┬────┘    └────┬────┘
     │              │
     └──────┬───────┘
            ▼
┌─────────────────────────┐
│  Log to Google Sheets   │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  Backup Check          │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  Backup to Dropbox     │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  Slack Notification    │
└─────────────────────────┘
```

## Monitoring

### View Execution History
1. Open n8n dashboard
2. Click "Executions" in left sidebar
3. View all past executions
4. Click any execution to see detailed logs

### Google Sheets Log
All posts are logged with:
- Timestamp
- Content
- Platform
- Status

### Slack Notifications
Receive instant alerts when:
- Post is published successfully
- Errors occur
- Workflow completes

## Troubleshooting

### Workflow Not Executing
- Check if workflow is activated (toggle in top-right)
- Verify cron expression in Schedule Trigger
- Check n8n logs: `docker logs n8n` or check console

### API Authentication Errors
- Re-authenticate credentials in n8n
- Verify API keys are valid and not expired
- Check API rate limits

### Content Generation Issues
- Verify OpenAI API key is valid
- Check OpenAI account has credits
- Review AI prompt for clarity

### Platform Posting Failures
- Verify platform credentials
- Check if content meets platform requirements (length, format)
- Review platform API status

## Best Practices

1. **Start Small**: Test with one platform first
2. **Monitor Closely**: Watch executions for the first week
3. **Content Quality**: Review generated content regularly
4. **API Limits**: Be aware of rate limits for each platform
5. **Backup Important**: Enable Dropbox backup for post history
6. **Timezone Matters**: Set correct timezone in `.env`
7. **Security**: Never commit `.env` file to git

## Advanced Features

### Content Templates
Create templates for different content types:
- Motivational quotes
- Industry news
- Tips and tricks
- Product updates
- Behind-the-scenes

### A/B Testing
Duplicate workflow with different:
- Content styles
- Posting times
- Hashtag strategies

### Analytics Integration
Add nodes for:
- Google Analytics
- Social media analytics APIs
- Custom dashboard creation

## Security Considerations

- Store all credentials in n8n's encrypted credential storage
- Use `.env` file for sensitive data (never commit to git)
- Regularly rotate API keys
- Use OAuth2 where possible
- Enable n8n authentication for production
- Use HTTPS for n8n in production

## Support

### Resources
- n8n Documentation: https://docs.n8n.io/
- n8n Community Forum: https://community.n8n.io/
- This Repository: https://github.com/hamza-ai-cloud/First-Project

### Common Issues
Check the troubleshooting section above or create an issue in this repository.

## License
This project is provided as-is for automation purposes.

## Contributing
Contributions welcome! Please open issues or pull requests with improvements.
