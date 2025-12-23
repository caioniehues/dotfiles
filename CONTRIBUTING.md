# Contributing

Thank you for your interest in contributing to this Claude Code configuration!

## How to Contribute

### Reporting Issues

If you find a bug or have a suggestion:

1. Check existing [issues](https://github.com/caioniehues/dotfiles/issues) first
2. Open a new issue with a clear description
3. Include relevant context (Claude Code version, OS, etc.)

### Submitting Changes

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-improvement`
3. Make your changes following the guidelines below
4. Test your changes with Claude Code
5. Commit with a descriptive message
6. Open a pull request

## Development Guidelines

### Skills

Skills follow the structure in `skills/create-agent-skills/`:

```
skills/skill-name/
├── SKILL.md           # Main skill definition
├── references/        # Domain knowledge files
├── templates/         # Output templates
├── workflows/         # Step-by-step procedures
└── scripts/           # Executable scripts (optional)
```

Key principles:
- Use XML tags for structure
- Progressive disclosure (load references only when needed)
- Include working examples
- Keep SKILL.md under 500 lines

### Agents

Agents are defined in `agents/` as markdown files:

- Clear role description at the top
- Specify available tools
- Include usage examples
- Define success criteria

### Slash Commands

Commands in `commands/` follow YAML frontmatter format:

```markdown
---
description: Brief description
allowed-tools: [Tool1, Tool2]
---

Command prompt content here...
```

### Hooks

Hooks in `hooks/`:
- Shell scripts (`.sh`) for simple operations
- TypeScript (`.ts`) for complex logic
- Follow the hook input/output schemas

## Style Guidelines

### Markdown

- Use proper heading hierarchy (h1 > h2 > h3)
- Include code blocks with language identifiers
- Keep lines under 100 characters when possible

### Naming

- Skills: `kebab-case` directories
- Agents: `kebab-case.md` files
- Commands: `kebab-case.md` files

## Questions?

Open an issue or reach out via the repository discussions.
