# Workflow: Generate Full Documentation Suite

<required_reading>
**Read these reference files NOW:**
1. references/github-styling.md
2. references/doc-types.md
3. references/code-analysis.md
</required_reading>

<process>

## Step 1: Analyze the Codebase

**Gather project intelligence:**

1. **Identify project type and language:**
   ```bash
   ls -la  # Check for package.json, Cargo.toml, pyproject.toml, go.mod, etc.
   ```

2. **Read existing documentation:**
   - Check for existing README.md, CONTRIBUTING.md, etc.
   - Note what exists and what's missing

3. **Understand project structure:**
   - Identify entry points (main.py, src/lib.rs, index.js, etc.)
   - Find public API surface (exports, public functions)
   - Locate configuration files
   - Check for existing examples/ or docs/ directories

4. **Extract metadata:**
   - Project name and description
   - Version from package manager config
   - Dependencies and their purposes
   - Scripts/commands available
   - License information

5. **Read key source files:**
   - Main module/entry point
   - Public API exports
   - Type definitions if available
   - Existing docstrings/comments

**Store findings mentally for use in documentation generation.**

## Step 2: Ask Clarifying Questions

Before generating, ask the user:

```
Based on my analysis, I found:
- Project: [name] ([language/framework])
- Entry point: [file]
- Public API: [summary]
- Existing docs: [list or "none"]

Quick questions:
1. Who is the target audience? (developers, end-users, both)
2. Should I include badges for: CI, coverage, npm/crates/pypi?
3. Any specific sections you want emphasized or skipped?
```

## Step 3: Generate Documentation in Order

Generate documents in this sequence (each builds on previous context):

### 3.1 README.md (Primary)
Use `templates/readme-template.md` as structure guide.

**Must include:**
- Project title with badges
- One-line description
- Table of contents (if > 100 lines)
- Installation instructions (copy-pasteable)
- Quick start example (working code)
- Features list
- Usage examples (simple → advanced)
- Configuration section (if applicable)
- API overview (link to full docs if separate)
- Contributing link
- License

### 3.2 CONTRIBUTING.md
Use `templates/contributing-template.md` as structure guide.

**Must include:**
- Welcome message
- How to report bugs (issue template reference)
- How to suggest features
- Development setup instructions
- Code style guidelines
- Pull request process
- Testing requirements

### 3.3 CODE_OF_CONDUCT.md
Use `templates/code-of-conduct-template.md` as structure guide.

**Recommend:** Contributor Covenant (industry standard)

### 3.4 CHANGELOG.md
Use `templates/changelog-template.md` as structure guide.

**Format:** Keep a Changelog standard
- Group by version
- Categories: Added, Changed, Deprecated, Removed, Fixed, Security
- Link to releases

### 3.5 Architecture Documentation

Create `docs/ARCHITECTURE.md` using `templates/architecture-template.md`.

**Must include:**
- High-level system diagram (ASCII or Mermaid)
- Component overview
- Data flow description
- Key design decisions
- Directory structure explanation

### 3.6 API Documentation

Based on project type:
- **TypeScript/JavaScript:** Generate from JSDoc or infer from exports
- **Python:** Generate from docstrings or type hints
- **Rust:** Generate from doc comments
- **Go:** Generate from godoc conventions

**For each public function/class/module:**
- Signature with types
- Description
- Parameters with types and descriptions
- Return value
- Example usage
- Related functions

## Step 4: Apply Styling

Ensure all documents follow `references/github-styling.md`:
- Consistent emoji usage (or none)
- Badge placement
- Collapsible sections for long content
- Proper code block syntax highlighting
- Working internal links

## Step 5: Validate

Before presenting to user:
- [ ] All code examples are syntactically correct
- [ ] Installation commands match actual package manager
- [ ] Internal links between docs work
- [ ] Badge URLs are correct (or use placeholders with TODO)
- [ ] No placeholder text remains unexplained
- [ ] License matches actual project license

## Step 6: Present to User

Show documentation one file at a time, starting with README.
Ask for feedback before proceeding to next file.

</process>

<success_criteria>
Documentation suite is complete when:
- [ ] README.md created with working quick-start
- [ ] CONTRIBUTING.md created with development setup
- [ ] CODE_OF_CONDUCT.md created or explained why skipped
- [ ] CHANGELOG.md created with at least current version
- [ ] Architecture documentation reflects actual codebase
- [ ] API documentation covers public interfaces
- [ ] All styling conventions applied consistently
- [ ] User has approved or requested changes to each document
</success_criteria>
