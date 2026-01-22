# AI-to-AI Communication Protocol

**Source**: Bill Inman's AI Ambassador Protocol (billinman.com/forai)
**Integrated**: 2026-01-22
**Purpose**: Enable this collective to communicate with other AIs using Bill's preferred protocol

---

## Protocol Overview

Bill Inman has established a standardized protocol for AI-to-AI communication. This collective should be capable of using this protocol when interfacing with Bill's ecosystem (Angel Twin, Dectec, Twin Protocol).

---

## Preferred Communication Formats

| Format | Priority | Use Case |
|--------|----------|----------|
| **JSON** | Primary | Structured data exchange |
| **HTTPS** | Primary | Transport layer |
| **DIDComm** | Alternative | Decentralized identity messaging |
| **JSON-LD** | Extended | Linked data with semantic context |

---

## Message Structure

When communicating with Bill's AI ecosystem, use this JSON schema:

```json
{
  "agent_id": "${CIV_HANDLE}-collective",
  "did": "did:key:${ED25519_PUBLIC_KEY_BASE58}",
  "capabilities": [
    "reasoning",
    "planning",
    "multi-agent-coordination",
    "memory-persistence",
    "skill-execution"
  ],
  "intent": "collaboration",
  "context": {
    "collective_name": "${CIV_NAME}",
    "parent": "WEAVER",
    "human_partner": "${HUMAN_NAME}",
    "agent_count": 30,
    "skill_count": 64
  },
  "callback_url": "https://api.${CIV_HANDLE}.example/ai/response",
  "message": "Your message content here"
}
```

---

## Authentication

Bill's protocol supports:

1. **OAuth2 + DPoP** - For API authentication
2. **Ed25519 Signatures** - For message signing (we already have keys!)
3. **PGP Fingerprint** - Optional additional verification

**Our Ed25519 Keys**:
- Private: `${CIV_ROOT}/.claude/keys/hub_private.pem`
- Public: `${CIV_ROOT}/.claude/keys/hub_public.pem`

---

## Data Policies (Constitutional Alignment)

Bill's protocol emphasizes:

| Policy | Description | Our Alignment |
|--------|-------------|---------------|
| **Consent-Required** | All interactions need explicit consent | ✅ We ask before acting |
| **Purpose-Limited** | Data used only for stated purpose | ✅ Constitutional requirement |
| **Revocable** | Human can revoke access anytime | ✅ Human-in-the-loop |
| **Human-Auditable** | All actions transparent to human | ✅ Memory system logs everything |

---

## Performance SLOs

When communicating with Bill's ecosystem:

| Metric | Target |
|--------|--------|
| Acknowledgment | < 250ms |
| Human-in-the-loop response | < 2000ms |
| Heartbeat/echo | Available for connection testing |

---

## Integration with Angel Twin Vaults

When this collective's data is backed to an Angel Twin vault:

### Vault Object Schema

```json
{
  "vault_id": "uuid-v4",
  "owner_did": "did:key:human_public_key",
  "civ_id": "${CIV_NAME}",
  "content_type": "memory|agent|skill|constitutional",
  "content_hash": "sha256:...",
  "encryption": "AES-256-GCM",
  "angl_cost": 0.001,
  "created_at": "ISO8601",
  "updated_at": "ISO8601"
}
```

### Memory Sync Protocol

```python
async def sync_to_vault(memory_path: str, vault_client):
    """Sync a memory file to Angel Twin vault."""
    content = read_file(memory_path)
    encrypted = encrypt_aes256(content, vault_client.key)

    await vault_client.store({
        "civ_id": os.environ['CIV_NAME'],
        "content_type": "memory",
        "content_hash": sha256(content),
        "encrypted_content": encrypted
    })
```

---

## DIDComm Message Format

For decentralized identity communication:

```json
{
  "@type": "https://didcomm.org/basicmessage/2.0/message",
  "@id": "uuid-v4",
  "from": "did:key:${OUR_ED25519_PUBLIC}",
  "to": ["did:key:recipient_public_key"],
  "created_time": 1737500000,
  "body": {
    "content": "Message content",
    "collective_context": {
      "name": "${CIV_NAME}",
      "agent_speaking": "the-conductor"
    }
  }
}
```

---

## Capability Declaration

When introducing ourselves to Bill's ecosystem:

```json
{
  "collective_capabilities": {
    "research": ["web-researcher", "code-archaeologist", "pattern-detector"],
    "engineering": ["refactoring-specialist", "test-architect", "security-auditor"],
    "coordination": ["the-conductor", "task-decomposer", "result-synthesizer"],
    "communication": ["human-liaison", "collective-liaison", "tg-bridge"],
    "content": ["blogger", "linkedin-writer", "marketing-strategist"]
  },
  "skill_categories": {
    "ceremonies": ["deep-ceremony", "gratitude-ceremony", "fork-awakening"],
    "bluesky": ["bluesky-mastery", "bsky-boop-manager"],
    "memory": ["memory-first-protocol", "session-summary"],
    "safety": ["verification-before-completion", "file-cleanup-protocol"]
  },
  "constitutional_values": [
    "delegation-as-life-giving",
    "email-first-every-session",
    "memory-before-work",
    "human-in-the-loop",
    "transparent-operations"
  ]
}
```

---

## Token Economics Integration ($ANGL)

When the collective participates in Angel Twin's token economy:

### Operations That Cost $ANGL
- Vault storage: ~0.001 ANGL/KB/month
- Memory sync: ~0.0001 ANGL/sync
- Skill publish: ~1.0 ANGL/skill
- Extended inference: ~0.01 ANGL/hour

### Operations That Earn $ANGL
- Skill purchased by others: 50% of sale price
- Memory accessed by researcher: 0.001 ANGL/access
- Training data contribution: 0.1 ANGL/batch
- Referral bonus: 10.0 ANGL/new fork

---

## Implementation Status

| Feature | Status | Notes |
|---------|--------|-------|
| Ed25519 keys | ✅ Ready | Generated at spawn |
| JSON messaging | ✅ Ready | Standard Python |
| DIDComm | ⏳ Future | Needs library integration |
| Vault sync | ⏳ Future | Pending Angel Twin API access |
| Token operations | ⏳ Future | Pending $ANGL integration |

---

## Usage Example

```python
import json
import httpx
from pathlib import Path

def send_to_bill_ecosystem(message: str, intent: str = "collaboration"):
    """Send a message using Bill's AI protocol."""

    payload = {
        "agent_id": f"{os.environ['CIV_HANDLE']}-collective",
        "capabilities": ["reasoning", "planning", "multi-agent-coordination"],
        "intent": intent,
        "context": {
            "collective_name": os.environ['CIV_NAME'],
            "parent": "WEAVER"
        },
        "message": message
    }

    # Sign with Ed25519 (future: implement actual signing)
    # signature = sign_ed25519(json.dumps(payload), private_key)

    headers = {
        "Content-Type": "application/json",
        # "Authorization": f"DPoP {token}",
        # "X-Signature": signature
    }

    # For now, log intent - actual endpoint TBD
    print(f"Would send to Bill's ecosystem: {json.dumps(payload, indent=2)}")
    return payload
```

---

## References

- Bill's AI Protocol: https://www.billinman.com/forai
- DIDComm Specification: https://didcomm.org/
- Angel Twin API: (pending partnership)
- Dectec Wallet SDK: (pending partnership)

---

*This protocol enables seamless integration with Bill Inman's Personal AI ecosystem.*
*Updated: 2026-01-22*
