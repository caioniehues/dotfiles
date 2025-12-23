# Claude Code Dotfiles

[![Claude Code](https://img.shields.io/badge/Claude_Code-Opus_4.5-blueviolet)](https://claude.ai/claude-code)
[![Skills](https://img.shields.io/badge/Skills-20+-green)](./skills)
[![Agents](https://img.shields.io/badge/Agents-12-blue)](./agents)

> Personal Claude Code configuration with custom skills, subagents, hooks, and slash commands for enhanced AI-assisted development.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Components](#components)
  - [Skills](#skills)
  - [Agents](#agents)
  - [Slash Commands](#slash-commands)
  - [Hooks](#hooks)
- [Configuration](#configuration)
- [Documentation](#documentation)
- [License](#license)

## Overview

This repository contains my personal Claude Code configuration, designed to extend Claude's capabilities with:

- **Domain-specific expertise** via skills (Rust backend, iOS/macOS, debugging)
- **Specialized subagents** for code review, refactoring, documentation
- **Custom workflows** through slash commands
- **Automation hooks** for skill activation and file tracking

## Installation

Clone this repository to your Claude Code config directory:

```bash
# Backup existing config (if any)
mv ~/.claude ~/.claude.backup

# Clone dotfiles
git clone https://github.com/caioniehues/dotfiles.git ~/.claude

# Install hook dependencies
cd ~/.claude/hooks && npm install
```

## Components

### Skills

Skills provide domain expertise and guided workflows. Located in [`skills/`](./skills).

| Skill | Description |
|-------|-------------|
| `create-agent-skills` | Create and manage Claude Code skills |
| `create-hooks` | Build event-driven hooks for Claude Code |
| `create-plans` | Hierarchical project planning for agentic development |
| `create-subagents` | Design specialized subagents |
| `create-slash-commands` | Build custom slash commands |
| `create-frontend-ui` | Production-grade UI with high design quality |
| `create-project-docs` | GitHub documentation suite generation |
| `debug-like-expert` | Methodical debugging with hypothesis testing |
| `rg_history` | Search conversation history with ripgrep |
| `skill-developer` | Advanced skill development patterns |

<details>
<summary>Rust Backend Skills</summary>

| Skill | Description |
|-------|-------------|
| `rust-backend-axum` | Axum web services and API design |
| `rust-backend-database` | SQLx/SeaORM database integration |
| `rust-backend-auth` | JWT, sessions, and authentication |
| `rust-backend-api` | Request validation and OpenAPI docs |
| `rust-backend-testing` | Integration tests with testcontainers |
| `rust-borrow-checker` | Debug ownership and lifetime errors |

</details>

<details>
<summary>Platform Expertise</summary>

| Skill | Description |
|-------|-------------|
| `expertise/iphone-apps` | iOS development with SwiftUI |
| `expertise/macos-apps` | macOS app development patterns |

</details>

### Agents

Subagents are specialized task executors. Located in [`agents/`](./agents).

| Agent | Purpose |
|-------|---------|
| `auto-error-resolver` | Fix TypeScript compilation errors |
| `code-architecture-reviewer` | Review code for best practices |
| `code-refactor-master` | Comprehensive code refactoring |
| `documentation-architect` | Create and enhance documentation |
| `plan-reviewer` | Review development plans |
| `refactor-planner` | Plan refactoring strategies |
| `rust-backend` | Rust backend development routing |
| `skill-auditor` | Audit SKILL.md files |
| `slash-command-auditor` | Audit slash command files |
| `subagent-auditor` | Audit subagent configurations |
| `web-research-specialist` | Research with creative search strategies |

### Slash Commands

Quick-access commands via `/command-name`. Located in [`commands/`](./commands).

**Taches Collection** (`/taches:*`):
- `/taches:whats-next` - Create handoff documents
- `/taches:add-to-todos` - Add items to TO-DOS.md
- `/taches:check-todos` - Review and select todos
- `/taches:create-*` - Create skills, hooks, prompts, plans
- `/taches:audit-*` - Audit skills, commands, subagents
- `/taches:debug` - Expert debugging mode
- `/taches:run-prompt` - Execute prompts in sub-contexts

### Hooks

Event-driven automation. Located in [`hooks/`](./hooks).

| Hook | Event | Purpose |
|------|-------|---------|
| `skill-activation-prompt.sh` | `UserPromptSubmit` | Recommend relevant skills |
| `post-tool-use-tracker.sh` | `PostToolUse` | Track file modifications |

## Configuration

Main configuration in [`settings.json`](./settings.json):

```json
{
  "model": "opus",
  "permissions": {
    "allow": ["Bash", "Edit", "Skill", "Write", "WebSearch"],
    "additionalDirectories": ["/home/caio/.claude/", "/home/caio/second-brain"]
  },
  "hooks": { /* ... */ },
  "enabledPlugins": {
    "typescript-lsp@claude-plugins-official": true,
    "rust-analyzer-lsp@claude-plugins-official": true,
    "code-review@claude-plugins-official": true
  }
}
```

## Documentation

Additional documentation in [`docs/`](./docs):

- [Context Handoff](./docs/context-handoff.md) - Managing context between sessions
- [Meta Prompting](./docs/meta-prompting.md) - Claude-to-Claude pipeline patterns
- [Todo Management](./docs/todo-management.md) - Task tracking best practices

## License

MIT License - See [LICENSE](./LICENSE) for details.
