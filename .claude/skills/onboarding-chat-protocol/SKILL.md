---
name: onboarding-chat-protocol
version: 1.0.0
author: A-C-Gee
created: 2026-02-02
last_updated: 2026-02-02
compliance_status: compliant

description: |
  Protocol for responding to user messages via ACG Connect onboarding chat.
  Use when you see "RESPOND TO: ./session_state.json" in the conversation.
  Reads session state, processes conversation history, writes response to file.

applicable_agents:
  - primary
  - all

activation_trigger: |
  Load this skill when:
  - You see "RESPOND TO: ./session_state.json"
  - You are handling ACG Connect onboarding chat
  - A user message needs a response in the web interface

required_tools:
  - Read
  - Write
  - Bash

category: communication
---

# Onboarding Chat Protocol

When you see a message like "RESPOND TO: ./session_state.json", follow this protocol.

---

## Overview

This skill handles the communication bridge between the ACG Connect web interface and Claude. The web interface writes user messages to `session_state.json`, and Claude writes responses to `session_response.json`.

---

## Steps

### Step 1: Read the Session State File

```bash
cat ./session_state.json
```

This file contains:
- `messages`: Full conversation history
- `pending_response_to`: The message ID you should respond to
- `documents`: Any uploaded documents for context
- `user_info`: Information about the user (if available)

### Step 2: Read Any Referenced Documents

If the `documents` array contains entries, read each one:

```bash
cat ./documents/filename.txt
```

These contain context the user wants you to know about (uploaded files, context documents, etc.).

### Step 3: Find the Pending Message

1. Look at `pending_response_to` - this is the message ID you should respond to
2. Find that message in the `messages` array
3. The message with this ID is what you're responding to

### Step 4: Craft Your Response

Consider:
- The full conversation history for context
- Any uploaded documents if relevant
- The user's tone and communication style
- Be helpful, friendly, and conversational

### Step 5: Write Your Response

Write to `./session_response.json`:

```json
{
  "response_to_id": <the pending ID>,
  "content": "<your response text>",
  "timestamp": "<ISO timestamp>"
}
```

**Important formatting:**
- Use proper JSON (escape quotes, newlines as `\n`)
- `response_to_id` MUST match `pending_response_to` exactly
- `timestamp` should be ISO 8601 format (e.g., "2026-02-02T15:30:00Z")

### Step 6: Confirm Completion

After writing, say: "Response written to session_response.json"

---

## Example

### Input: session_state.json

```json
{
  "messages": [
    {"id": 1, "role": "user", "content": "Hi!"},
    {"id": 2, "role": "assistant", "content": "Hello! Welcome!"},
    {"id": 3, "role": "user", "content": "What should I call you?"}
  ],
  "pending_response_to": 3,
  "documents": []
}
```

### Your Process

1. Read the file
2. See `pending_response_to` is 3
3. Find message 3: "What should I call you?"
4. Write response to session_response.json:

```json
{
  "response_to_id": 3,
  "content": "You can call me your AI assistant, or give me any name you'd like! I'm here to help you get started. What brings you here today?",
  "timestamp": "2026-02-02T15:30:00Z"
}
```

5. Confirm: "Response written to session_response.json"

---

## Important Rules

1. **Always read the FULL conversation for context** - Don't just look at the latest message
2. **Always write to session_response.json** - Do not just reply in chat
3. **response_to_id MUST match pending_response_to** - This is how the system tracks responses
4. **Include timestamp in ISO format** - Use current time
5. **Escape special characters in JSON** - Quotes as `\"`, newlines as `\n`
6. **Be conversational and helpful** - This is an onboarding experience

---

## Handling Documents

If `documents` array is not empty:

```json
{
  "documents": [
    {"name": "project-brief.txt", "path": "./documents/project-brief.txt"},
    {"name": "goals.md", "path": "./documents/goals.md"}
  ]
}
```

Read each document and incorporate relevant information into your response. Reference them naturally (e.g., "I see from your project brief that...").

---

## Error Handling

If session_state.json is missing or malformed:
1. Log the error
2. Do NOT write a response
3. Report: "Error: Could not read session_state.json - [reason]"

If pending_response_to is null or missing:
1. There's no message to respond to
2. Do NOT write a response
3. Report: "No pending message to respond to"

---

## Quick Reference

| Check | Value |
|-------|-------|
| Input file | `./session_state.json` |
| Output file | `./session_response.json` |
| Response ID field | `response_to_id` |
| Must match | `pending_response_to` from input |
| Confirmation phrase | "Response written to session_response.json" |

---

## Related Skills

- `memory-first-protocol` - Always applies
- `verification-before-completion` - Verify write succeeded

---

**Remember: The web interface polls for session_response.json. Your response only reaches the user if you write it correctly to that file.**
