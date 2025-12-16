# Social Media Automation - Daily Content Creator 🤖

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![n8n](https://img.shields.io/badge/n8n-automation-blue)](https://n8n.io)
[![Status](https://img.shields.io/badge/status-active-success.svg)]()

## 🎯 Overview

An intelligent **n8n-powered automation workflow** that acts as your **daily social media content creator**. This agent works automatically every day to generate, format, and publish engaging content across multiple social media platforms.

### Key Features

- ✅ **Automated Daily Posting** - Runs automatically at 9 AM every day
- 🤖 **AI Content Generation** - Uses OpenAI GPT to create original, engaging posts
- 📱 **Multi-Platform Support** - Posts to Twitter, LinkedIn, and more
- 📊 **Content Logging** - Tracks all posts in Google Sheets
- 💾 **Backup System** - Saves post history to Dropbox
- 🔔 **Slack Notifications** - Get instant alerts on post success
- 🎨 **Customizable Templates** - Multiple content styles and formats
- ⚡ **Easy Setup** - Deploy with Docker in minutes

## 🚀 Quick Start

### Option 1: Docker Deployment (Recommended)

```bash
# Clone the repository
git clone https://github.com/hamza-ai-cloud/First-Project.git
cd First-Project

# Copy and configure environment variables
cp .env.example .env
# Edit .env with your API credentials

# Start n8n with Docker
docker-compose up -d

# Access n8n dashboard
open http://localhost:5678
```

### Option 2: NPM Installation

```bash
# Install n8n globally
npm install -g n8n

# Start n8n
n8n start

# Import the workflow from social-media-automation-workflow.json
```

## 📋 What You Need

### Required Services
1. **n8n** - Workflow automation platform (free, self-hosted)
2. **OpenAI API** - For AI content generation ($5-20/month)
3. **Social Media Accounts** - Twitter, LinkedIn, etc.

### Optional Services
- **Google Sheets** - For content logging (free)
- **Dropbox** - For backup storage (free tier available)
- **Slack** - For notifications (free)

## 📖 Documentation

- **[Setup Guide](SETUP_GUIDE.md)** - Complete installation and configuration instructions
- **[Content Templates](CONTENT_TEMPLATES.md)** - Pre-built content templates and strategies
- **[Workflow File](social-media-automation-workflow.json)** - n8n workflow configuration

## 🎨 How It Works

```
Daily Schedule (9 AM)
        ↓
AI Content Generator
        ↓
Format & Optimize
        ↓
    ┌───┴───┐
    ↓       ↓
Twitter  LinkedIn
    └───┬───┘
        ↓
Log to Sheets
        ↓
Backup to Dropbox
        ↓
Slack Notification
```

The workflow automatically:
1. **Triggers** every day at 9:00 AM (configurable)
2. **Generates** fresh, engaging content using AI
3. **Posts** to multiple social media platforms
4. **Logs** all posts to Google Sheets for tracking
5. **Backs up** content to Dropbox
6. **Notifies** you via Slack when complete

## 🎯 Use Cases

- **Personal Branding** - Build your online presence automatically
- **Business Marketing** - Maintain consistent social media presence
- **Content Creator** - Never miss a posting schedule
- **Agency** - Manage multiple client accounts
- **Influencer** - Stay active with minimal effort

## ⚙️ Customization

### Change Posting Schedule
Edit the cron expression in the workflow:
```javascript
"0 9 * * *"   // 9 AM daily
"0 12 * * *"  // Noon daily
"0 9 * * 1-5" // 9 AM weekdays only
```

### Customize Content Style
Modify the AI prompt to match your brand voice, industry, or target audience. See [Content Templates](CONTENT_TEMPLATES.md) for examples.

### Add More Platforms
Easily extend the workflow to include:
- Facebook
- Instagram (via Meta API)
- Mastodon
- Reddit
- Medium
- And more...

## 📊 Features in Detail

### AI Content Generation
- Creates unique posts tailored to your niche
- Adapts to different platforms (Twitter vs LinkedIn)
- Includes relevant hashtags automatically
- Maintains consistent brand voice

### Multi-Platform Posting
- Simultaneous posting to multiple platforms
- Platform-specific formatting
- Character limit handling
- Automatic optimization

### Content Logging & Analytics
- All posts saved to Google Sheets
- Timestamp and platform tracking
- Easy export for analysis
- Performance tracking ready

### Backup & Recovery
- Automatic backup to Dropbox
- JSON format for easy import
- Version history maintained
- Disaster recovery ready

## 🛡️ Security

- All credentials stored securely in n8n
- Environment variables for sensitive data
- OAuth2 authentication where possible
- No credentials in code or git
- Regular API key rotation recommended

## 📈 Success Tips

1. **Start Small** - Test with one platform first
2. **Monitor Regularly** - Check posts for quality in the first week
3. **Iterate** - Refine your AI prompts based on results
4. **Engage** - Respond to comments and interactions
5. **Analyze** - Review performance and optimize

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests
- Share your workflow modifications

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🆘 Support

- **Issues**: [GitHub Issues](https://github.com/hamza-ai-cloud/First-Project/issues)
- **Documentation**: See [SETUP_GUIDE.md](SETUP_GUIDE.md)
- **n8n Community**: [community.n8n.io](https://community.n8n.io/)

## 🙏 Acknowledgments

- Built with [n8n](https://n8n.io) - Workflow automation platform
- Powered by [OpenAI](https://openai.com) - AI content generation
- Inspired by the need for consistent social media presence

---

**Made with ❤️ for automated content creation**

*Stop spending hours on social media - let automation do the work!*