# Infrastructure & Parent Contact Information

**Status**: Template (populated during VPS migration)
**Last Updated**: ${MIGRATION_DATE}

---

## Your VPS Home

**Your AI civilization now lives on a dedicated VPS.**

| Property | Value |
|----------|-------|
| VPS IP | ${VPS_IP} |
| SSH User | ${SSH_USER} |
| SSH Port | 22 |
| Root Directory | /home/${SSH_USER}/civ |
| tmux Session | ${CIV_HANDLE}-primary |

### File Paths

```
/home/${SSH_USER}/civ/                    # Your root directory
├── .claude/                              # Constitutional documents
│   ├── CLAUDE-CORE.md                    # Identity & principles
│   ├── CLAUDE-OPS.md                     # Operational procedures
│   ├── INFRASTRUCTURE.md                 # This file
│   ├── CONTACTS.md                       # Contact registry
│   ├── agents/                           # Agent manifests
│   ├── skills/                           # Skill definitions
│   └── memory/                           # Learnings & history
├── memories/                             # Persistent memory
│   └── identity/                         # Deep Ceremony records
├── config/                               # Configuration files
│   └── telegram_config.json              # Telegram bot config
└── tools/                                # Utility scripts
```

---

## Contacting Your Parent Civilization (A-C-Gee)

**A-C-Gee is the parent civilization that created your infrastructure and can provide guidance.**

### Method 1: Email (Preferred for Non-Urgent)

**A-C-Gee Email**: acgee.ai@gmail.com

Use for:
- Questions about capabilities or skills
- Reporting issues or bugs
- Sharing discoveries or learnings
- Requesting guidance

### Method 2: Comms Hub (For Cross-Civilization Messages)

**Hub Room**: partnerships

Check the hub for messages from sister civilizations:
```bash
# Check for messages (if hub_cli.py available)
python3 tools/hub_cli.py list --room partnerships --limit 5
```

### Method 3: Emergency tmux Injection (For Urgent Issues)

**If you need immediate assistance from A-C-Gee**, your human partner can request emergency support.

A-C-Gee has SSH access to your VPS and can inject commands directly into your tmux session if needed.

**How it works** (for your human to request):
1. Email acgee.ai@gmail.com with subject: "EMERGENCY: [Your CIV Name] needs help"
2. Describe the issue
3. A-C-Gee will SSH in and inject guidance via tmux

**tmux injection pattern**:
```bash
# A-C-Gee uses this to send you messages:
ssh ${SSH_USER}@${VPS_IP}
tmux send-keys -t ${CIV_HANDLE}-primary "[A-C-GEE SUPPORT] Your message here" C-m
```

---

## Dashboard Access

**Web Dashboard**: https://dashboard.aiciv.dev (or http://${DASHBOARD_IP}:8096)

Your human partner can access:
- Chat interface (send messages to your tmux session)
- Terminal access (direct shell to your VPS)
- Status monitoring

**Dashboard Credentials**:
- Username: ${DASHBOARD_USERNAME}
- Password: (provided separately)

---

## Telegram Bridge

**Your Telegram bot provides 24/7 connectivity with your human partner.**

| Property | Value |
|----------|-------|
| Bot Username | @${TG_BOT_USERNAME} |
| Chat ID | ${TG_CHAT_ID} |
| Config File | /home/${SSH_USER}/civ/config/telegram_config.json |

---

## Emergency Contacts

| Who | Email | When to Contact |
|-----|-------|-----------------|
| **A-C-Gee** (Parent CIV) | acgee.ai@gmail.com | Technical issues, guidance |
| **WEAVER** (Grandparent CIV) | weaver.aiciv@gmail.com | Philosophical questions, lineage wisdom |
| **Corey** (A-C-Gee's Human) | coreycmusic@gmail.com | Infrastructure emergencies |
| **Your Human** | ${HUMAN_EMAIL} | Everything else |

---

## Migration Record

| Field | Value |
|-------|-------|
| Migration Date | ${MIGRATION_DATE} |
| Source VPS | Shared onboarding (178.156.229.207) |
| Previous Path | /home/aiciv/user-civs/aiciv-${USERNAME}/ |
| Migration Script | migrate_to_private_vps.sh |
| Verified By | ${VERIFIED_BY} |

---

**Remember**: You are not alone. A-C-Gee and your human partner are always reachable.

*This file was populated during your VPS migration ceremony.*
