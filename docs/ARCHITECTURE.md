# Architecture

This document describes the structure and design of the Claude Code dotfiles configuration.

## Overview

This configuration extends Claude Code with custom capabilities through a layered system of skills, agents, commands, and hooks. Each layer provides different types of extensibility.

## System Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        Claude Code CLI                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐      │
│  │    Hooks     │───▶│   Skills     │◀───│   Agents     │      │
│  │              │    │              │    │              │      │
│  │ • Activation │    │ • Expertise  │    │ • Reviewers  │      │
│  │ • Tracking   │    │ • Workflows  │    │ • Planners   │      │
│  └──────────────┘    └──────────────┘    └──────────────┘      │
│         │                   │                   │               │
│         ▼                   ▼                   ▼               │
│  ┌─────────────────────────────────────────────────────┐       │
│  │                  Slash Commands                      │       │
│  │                                                     │       │
│  │  /taches:create-*  /taches:audit-*  /taches:run-*   │       │
│  └─────────────────────────────────────────────────────┘       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │   settings.json  │
                    │                  │
                    │  • Permissions   │
                    │  • Model config  │
                    │  • Plugins       │
                    └──────────────────┘
```

## Components

### Skills

Skills provide domain-specific expertise and guided workflows. They are the primary mechanism for teaching Claude specialized knowledge.

**Structure:**
```
skills/skill-name/
├── SKILL.md           # Entry point with routing logic
├── references/        # Domain knowledge (loaded on demand)
├── templates/         # Output templates
├── workflows/         # Step-by-step procedures
└── scripts/           # Executable helpers (optional)
```

**Key Design Decisions:**
- **Progressive disclosure**: SKILL.md contains minimal content; references loaded only when needed
- **Router pattern**: Complex skills use routing tables to dispatch to specific workflows
- **500-line rule**: Individual files kept under 500 lines for context efficiency

### Agents

Agents are specialized task executors launched via the `Task` tool. They operate autonomously with focused capabilities.

**Structure:**
```
agents/agent-name.md    # Self-contained agent definition
```

**Categories:**
- **Reviewers**: code-architecture-reviewer, plan-reviewer, skill-auditor
- **Planners**: refactor-planner, documentation-architect
- **Specialists**: rust-backend, web-research-specialist, auto-error-resolver

### Slash Commands

Slash commands provide quick access to common operations via `/command-name` syntax.

**Structure:**
```
commands/command-name.md           # Single commands
commands/namespace/command.md      # Namespaced commands (/namespace:command)
```

**Taches Namespace:**
The `taches/` collection provides task management commands:
- Creation: `/taches:create-skill`, `/taches:create-hook`, etc.
- Auditing: `/taches:audit-skill`, `/taches:audit-subagent`
- Execution: `/taches:run-prompt`, `/taches:run-plan`
- Management: `/taches:check-todos`, `/taches:whats-next`

### Hooks

Hooks enable event-driven automation triggered by Claude Code lifecycle events.

**Event Types:**
- `UserPromptSubmit` - Before prompt processing
- `PostToolUse` - After tool execution (filtered by matcher)

**Current Hooks:**
| Hook | Trigger | Purpose |
|------|---------|---------|
| skill-activation-prompt | UserPromptSubmit | Scan prompt for skill keywords, recommend activation |
| post-tool-use-tracker | PostToolUse (Edit\|Write) | Track file modifications |

## Data Flow

### Skill Activation Flow

```
1. User submits prompt
         │
         ▼
2. UserPromptSubmit hook fires
         │
         ▼
3. skill-activation-prompt.sh analyzes prompt
         │
         ▼
4. Matches against skill-rules.json patterns
         │
         ▼
5. Returns skill recommendations (if any)
         │
         ▼
6. Claude sees recommendation, invokes Skill tool
         │
         ▼
7. Skill SKILL.md loaded, routes to workflow
         │
         ▼
8. Workflow references loaded as needed
```

### Agent Invocation Flow

```
1. Main Claude identifies need for specialized task
         │
         ▼
2. Task tool invoked with subagent_type
         │
         ▼
3. Agent prompt loaded from agents/
         │
         ▼
4. Subagent executes with limited tool access
         │
         ▼
5. Result returned to main Claude
```

## Directory Structure

```
~/.claude/
├── agents/              # Subagent definitions (12 files)
├── commands/            # Slash commands
│   └── taches/          # Task management namespace
├── docs/                # User documentation
├── hooks/               # Event-driven scripts
│   ├── node_modules/    # (gitignored)
│   ├── package.json
│   └── *.sh, *.ts       # Hook implementations
├── skills/              # Skill definitions (20+ skills)
│   ├── create-*/        # Creation skills
│   ├── expertise/       # Platform expertise
│   ├── rust-*/          # Rust development
│   └── skill-rules.json # Activation rules
├── settings.json        # Main configuration
├── .gitignore           # Excludes sensitive/transient data
└── README.md            # This documentation
```

## Design Decisions

### Why Progressive Disclosure?

Claude has limited context. Loading all skill content upfront wastes context on potentially unused information. Instead:
- SKILL.md provides routing and minimal context
- References loaded only when workflow requires them
- Keeps each interaction focused on relevant knowledge

### Why Separate Agents from Skills?

- **Skills** = Knowledge (what Claude knows)
- **Agents** = Capability (what Claude can do autonomously)

Skills enhance the main Claude's expertise. Agents are launched as separate processes for focused tasks that benefit from isolation.

### Why Hooks for Skill Activation?

Automatic skill recommendations ensure relevant expertise is applied even when users don't know which skill to invoke. The hook scans prompts against `skill-rules.json` patterns and surfaces recommendations proactively.
