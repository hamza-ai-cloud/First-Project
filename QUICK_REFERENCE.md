# Quick Reference Card

## 🚀 Getting Started (5 Minutes)

```bash
# 1. Clone and setup
git clone https://github.com/hamza-ai-cloud/First-Project.git
cd First-Project
cp .env.example .env

# 2. Edit .env with your API keys
nano .env

# 3. Start n8n
./start.sh

# 4. Open browser
http://localhost:5678
```

## 📝 Essential Commands

### Docker Management
```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f n8n

# Restart n8n
docker-compose restart n8n

# Check status
docker-compose ps
```

### Workflow Management
```bash
# In n8n UI:
# Import: Settings → Import from File → select social-media-automation-workflow.json
# Activate: Toggle switch in workflow editor (top-right)
# Test: Click "Execute Workflow" button
# View history: Click "Executions" in sidebar
```

## 🔑 Required API Keys

### OpenAI (Required)
- Get at: https://platform.openai.com/api-keys
- Cost: ~$5-20/month for daily posts
- Used for: Content generation

### Twitter (Required if using Twitter)
- Get at: https://developer.twitter.com/
- Need: API Key, API Secret, Access Token, Access Secret
- Used for: Posting tweets

### LinkedIn (Required if using LinkedIn)
- Get at: https://www.linkedin.com/developers/
- Need: OAuth2 credentials
- Used for: Posting to LinkedIn

### Google Sheets (Optional)
- Get at: https://console.cloud.google.com/
- Need: Service account JSON
- Used for: Logging posts

### Dropbox (Optional)
- Get at: https://www.dropbox.com/developers/
- Need: Access token
- Used for: Backup storage

### Slack (Optional)
- Get at: https://api.slack.com/apps
- Need: Webhook URL
- Used for: Notifications

## ⏰ Schedule Configuration

Default schedule: **9:00 AM daily**

### Cron Examples
```javascript
"0 9 * * *"     // 9 AM daily
"0 12 * * *"    // Noon daily
"0 9,15 * * *"  // 9 AM and 3 PM daily
"0 9 * * 1-5"   // 9 AM weekdays only
"*/30 * * * *"  // Every 30 minutes
"0 */2 * * *"   // Every 2 hours
```

## 🎨 Content Customization

### Change AI Prompt
In "AI Content Generator" node:
```javascript
// Modify the prompt:
"You are a [your role]. Generate a post about [your topic]..."
```

### Add More Platforms
1. Click the "+" button in workflow
2. Search for platform (Facebook, Instagram, etc.)
3. Connect from "Format Content" node
4. Configure credentials
5. Test and activate

## 🐛 Quick Troubleshooting

### Workflow Not Running?
- [ ] Check workflow is **activated** (toggle ON)
- [ ] Verify schedule time in correct timezone
- [ ] Check "Executions" for errors
- [ ] Restart n8n: `docker-compose restart n8n`

### API Errors?
- [ ] Verify credentials in n8n Settings
- [ ] Check API keys are valid
- [ ] Ensure billing is set up
- [ ] Check rate limits

### Content Quality Issues?
- [ ] Improve AI prompt with more details
- [ ] Add examples in prompt
- [ ] Try GPT-4 instead of GPT-3.5
- [ ] Use content templates (CONTENT_TEMPLATES.md)

### Posts Too Long?
- [ ] Add character limit to prompt
- [ ] Use function node to trim content
- [ ] Different prompts for different platforms

## 📊 Monitoring

### Check Execution History
```
n8n UI → Executions (left sidebar) → View recent runs
```

### View Logs
```bash
docker-compose logs -f n8n | grep -i error
```

### Check Posted Content
- Twitter: https://twitter.com/[your-username]
- LinkedIn: https://linkedin.com/in/[your-profile]
- Google Sheets: Check your spreadsheet
- Slack: Check configured channel

## 🔒 Security Checklist

- [ ] Never commit .env file
- [ ] Use OAuth2 when possible
- [ ] Rotate API keys every 90 days
- [ ] Enable 2FA on all accounts
- [ ] Use HTTPS for production n8n
- [ ] Regularly update Docker images
- [ ] Backup workflow configurations

## 📚 Documentation

- **Full Setup**: SETUP_GUIDE.md
- **Content Ideas**: CONTENT_TEMPLATES.md
- **Troubleshooting**: TROUBLESHOOTING.md
- **Advanced**: ALTERNATIVE_WORKFLOWS.md

## 🆘 Need Help?

1. **Check docs above first**
2. **Search existing issues**: https://github.com/hamza-ai-cloud/First-Project/issues
3. **Create new issue** with:
   - Error message
   - Steps to reproduce
   - What you've tried
4. **n8n Community**: https://community.n8n.io/

## 💡 Pro Tips

1. **Start Simple**: Test with one platform first
2. **Manual Test First**: Use "Execute Workflow" before activating
3. **Monitor Closely**: Check first week daily
4. **Iterate Prompts**: Improve based on results
5. **Use Templates**: See CONTENT_TEMPLATES.md
6. **Enable Backup**: Don't lose content history
7. **Set Alerts**: Know when something breaks
8. **Review Weekly**: Optimize performance

## 📈 Success Metrics

Track these in Google Sheets:
- Posts published per week
- Engagement rate by platform
- Best performing content types
- Optimal posting times
- Content generation cost
- Automation time saved

## 🎯 Common Use Cases

### Personal Brand
- Daily thought leadership
- Industry insights
- Career tips

### Business Marketing
- Product updates
- Company news
- Customer stories

### Content Creator
- Consistent posting
- Audience engagement
- Community building

### Agency
- Multiple client accounts
- Different content strategies
- Bulk content creation

---

**Quick Links:**
- n8n Dashboard: http://localhost:5678
- OpenAI Platform: https://platform.openai.com
- Twitter Developer: https://developer.twitter.com
- LinkedIn Apps: https://www.linkedin.com/developers

**Remember**: This runs automatically once activated! Monitor the first few days closely.
