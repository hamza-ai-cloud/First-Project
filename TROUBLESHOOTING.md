# Troubleshooting Guide

## Common Issues and Solutions

### Installation Issues

#### Docker Not Starting
**Problem**: `docker-compose up -d` fails

**Solutions**:
1. Check Docker is running: `docker ps`
2. Check Docker daemon: `sudo systemctl start docker` (Linux)
3. Increase Docker memory (Docker Desktop > Settings > Resources)
4. Check ports aren't in use: `lsof -i :5678` or `netstat -an | grep 5678`

#### Port Already in Use
**Problem**: Port 5678 is already occupied

**Solutions**:
```bash
# Find what's using the port
lsof -i :5678

# Kill the process
kill -9 [PID]

# Or change the port in docker-compose.yml
ports:
  - "8080:5678"  # Use 8080 instead
```

### Authentication Issues

#### OpenAI API Errors
**Problem**: Content generation fails

**Solutions**:
1. Verify API key is correct
2. Check OpenAI account has credits: https://platform.openai.com/account/usage
3. Test API key independently:
```bash
curl https://api.openai.com/v1/models \
  -H "Authorization: Bearer YOUR_API_KEY"
```
4. Check rate limits aren't exceeded
5. Ensure billing is set up in OpenAI account

#### Twitter Authentication Failed
**Problem**: Cannot post to Twitter

**Solutions**:
1. Verify all 4 credentials are correct:
   - API Key
   - API Secret
   - Access Token
   - Access Secret
2. Check app permissions include "Read and Write"
3. Regenerate access tokens if needed
4. Ensure app is not in "App-only" mode
5. Check Twitter API tier limits

#### LinkedIn Connection Error
**Problem**: LinkedIn posts fail

**Solutions**:
1. Re-authenticate OAuth2 connection
2. Check app permissions include posting
3. Verify redirect URL is configured correctly
4. Clear and re-add LinkedIn credentials in n8n
5. Check if LinkedIn account is in good standing

### Workflow Issues

#### Workflow Not Executing
**Problem**: Scheduled workflow doesn't run

**Solutions**:
1. **Check workflow is activated**
   - Toggle switch should be ON (green)
   - Look for "Active" status at top

2. **Verify schedule settings**
   ```javascript
   // Correct format
   "0 9 * * *"  // 9 AM daily
   
   // Check your timezone
   GENERIC_TIMEZONE=America/New_York
   ```

3. **Check execution history**
   - Go to "Executions" in n8n
   - Look for errors or warnings

4. **Restart n8n**
   ```bash
   docker-compose restart n8n
   ```

#### Workflow Execution Errors
**Problem**: Workflow runs but fails

**Solutions**:
1. **Check each node's output**
   - Click on workflow in Executions
   - Review each node's input/output
   - Identify where it fails

2. **Common node failures**:
   - **AI node**: Check API key and credits
   - **Social media nodes**: Verify authentication
   - **Google Sheets**: Check permissions
   - **Dropbox**: Verify token is valid

3. **Test manually**
   - Click "Execute Workflow" button
   - Watch real-time execution
   - Debug specific nodes

#### Content Generation Problems
**Problem**: Generated content is poor quality

**Solutions**:
1. **Improve the AI prompt**:
```javascript
// Instead of basic prompt
"Generate a social media post"

// Use detailed prompt
"You are an expert social media manager specializing in [your niche].
Generate an engaging post that:
- Addresses [target audience]
- Focuses on [specific topic]
- Uses a [professional/casual/humorous] tone
- Includes relevant hashtags
- Ends with a call-to-action
Keep it under 280 characters."
```

2. **Test different models**
   - Try GPT-4 for better quality
   - Adjust temperature setting
   - Modify max tokens

3. **Use content templates**
   - See CONTENT_TEMPLATES.md
   - Provide specific examples in prompt

### Platform-Specific Issues

#### Twitter Character Limit
**Problem**: Posts are too long for Twitter

**Solutions**:
1. Add character limit check in Function node:
```javascript
let content = items[0].json.content;
if (content.length > 280) {
  content = content.substring(0, 277) + '...';
}
return [{json: {content}}];
```

2. Specify length in AI prompt:
```
"Generate a post under 280 characters"
```

3. Use Twitter threads for longer content

#### LinkedIn Formatting
**Problem**: LinkedIn posts look bad

**Solutions**:
1. Add line breaks for readability
2. Use emojis sparingly
3. Structure with bullet points
4. Add professional hashtags
5. Include a clear headline

### Data Management Issues

#### Google Sheets Not Updating
**Problem**: Posts aren't logged to Sheets

**Solutions**:
1. **Check sheet permissions**
   - Share sheet with service account email
   - Give "Editor" access

2. **Verify sheet ID**
   - Check GOOGLE_SHEET_ID in .env
   - Should match spreadsheet URL:
     `docs.google.com/spreadsheets/d/[SHEET_ID]/edit`

3. **Check credentials**
   - Re-upload service account JSON
   - Verify JSON format is correct

4. **Test connection**
   - Use "Test" button in node
   - Check for specific error messages

#### Dropbox Backup Failing
**Problem**: Backups not saving to Dropbox

**Solutions**:
1. **Verify access token**
   - Generate new token if expired
   - Check token has write permissions

2. **Check folder path**
   - Use absolute path: `/Social Media Backups/`
   - Ensure folder exists

3. **Verify file size**
   - Dropbox has limits
   - Check available space

### Performance Issues

#### Slow Execution
**Problem**: Workflow takes too long

**Solutions**:
1. **Optimize AI calls**
   - Reduce max_tokens
   - Use faster model (GPT-3.5 vs GPT-4)

2. **Parallel execution**
   - Post to platforms simultaneously
   - Use n8n's parallel processing

3. **Increase resources**
   ```yaml
   # In docker-compose.yml
   deploy:
     resources:
       limits:
         cpus: '2'
         memory: 4G
   ```

#### Rate Limiting
**Problem**: APIs return rate limit errors

**Solutions**:
1. **Add delays between requests**
   - Insert "Wait" nodes
   - Stagger execution times

2. **Check API limits**
   - Twitter: 50 tweets/day (free)
   - OpenAI: Tier-based limits
   - LinkedIn: 100 posts/day

3. **Upgrade API tiers** if needed

### Monitoring Issues

#### No Slack Notifications
**Problem**: Not receiving alerts

**Solutions**:
1. **Verify webhook URL**
   - Test webhook independently:
   ```bash
   curl -X POST -H 'Content-type: application/json' \
   --data '{"text":"Test"}' \
   YOUR_WEBHOOK_URL
   ```

2. **Check Slack channel**
   - Bot must be added to channel
   - Channel name must match exactly

3. **Check node configuration**
   - Verify message format
   - Test node independently

### Debug Techniques

#### Enable Detailed Logging
```bash
# In docker-compose.yml, add:
environment:
  - N8N_LOG_LEVEL=debug
  - N8N_LOG_OUTPUT=console,file

# Restart
docker-compose restart n8n

# View logs
docker-compose logs -f n8n
```

#### Test Individual Nodes
1. Click on node in workflow
2. Click "Execute Node"
3. Check input/output data
4. Verify credentials work

#### Manual Testing
```bash
# Test workflow manually
# 1. Open workflow
# 2. Click "Execute Workflow"
# 3. Watch real-time execution
# 4. Check each node's data
```

#### Check System Resources
```bash
# Check Docker stats
docker stats

# Check disk space
df -h

# Check memory
free -h
```

### Getting Help

#### Before Asking for Help

Gather this information:
1. Error messages (exact text)
2. Node configuration (screenshot)
3. Execution history (from n8n)
4. System info (OS, Docker version)
5. What you've already tried

#### Where to Get Help

1. **GitHub Issues**: https://github.com/hamza-ai-cloud/First-Project/issues
2. **n8n Community**: https://community.n8n.io/
3. **n8n Documentation**: https://docs.n8n.io/
4. **Stack Overflow**: Tag with `n8n`

### Preventive Maintenance

#### Regular Checks
- [ ] Monitor execution history weekly
- [ ] Check API credit usage monthly
- [ ] Review generated content quality
- [ ] Update API keys before expiration
- [ ] Backup workflow configuration
- [ ] Test disaster recovery

#### Monthly Tasks
```bash
# Update n8n
docker-compose pull
docker-compose up -d

# Clean old executions
# Settings > Executions > Prune

# Review and optimize workflow
# Check for unused nodes
# Update prompts based on performance
```

#### Security Checklist
- [ ] Rotate API keys every 90 days
- [ ] Review OAuth connections
- [ ] Check for credential leaks
- [ ] Audit workflow permissions
- [ ] Update Docker images
- [ ] Backup credentials securely

### Emergency Procedures

#### Workflow Posting Wrong Content
1. **Immediately deactivate workflow**
   - Toggle OFF in n8n
2. **Delete problematic posts** manually
3. **Review execution history** to find issue
4. **Fix prompt/node** causing problem
5. **Test manually** before reactivating

#### API Key Compromised
1. **Immediately revoke key** at provider
2. **Generate new key**
3. **Update in n8n credentials**
4. **Check for unauthorized usage**
5. **Enable 2FA** on accounts

#### Data Loss
1. **Stop workflow**
2. **Check Dropbox backups**
3. **Restore from backup**:
   ```bash
   # Restore workflow
   # Import from backup JSON
   ```
4. **Review execution logs**
5. **Enable more frequent backups**

## Still Having Issues?

If none of these solutions work:

1. **Create detailed issue**: https://github.com/hamza-ai-cloud/First-Project/issues
2. **Include**:
   - Error messages
   - Steps to reproduce
   - System information
   - What you've tried
3. **Check n8n community** for similar issues
4. **Consider professional support** for critical issues

---

**Remember**: Most issues are related to:
- Incorrect API credentials
- Missing permissions
- Workflow not activated
- Timezone/scheduling confusion
- Rate limiting

Check these first before deep debugging!
