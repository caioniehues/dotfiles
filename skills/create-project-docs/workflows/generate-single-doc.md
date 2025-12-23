# Workflow: Generate Single Document

<required_reading>
**Read these reference files NOW:**
1. references/github-styling.md
2. references/doc-types.md
</required_reading>

<process>

## Step 1: Identify Document Type

Ask the user which document they want:

1. **README.md** - Project overview and getting started
2. **CONTRIBUTING.md** - How to contribute
3. **CODE_OF_CONDUCT.md** - Community guidelines
4. **CHANGELOG.md** - Version history
5. **ARCHITECTURE.md** - System design
6. **API.md** - API reference documentation
7. **Custom** - User specifies

## Step 2: Check Existing State

```bash
# Check if document exists
ls -la [document_name]

# If exists, read current version
cat [document_name]
```

**If document exists:**
- Ask: "Replace entirely, or merge with existing content?"
- If merge: Identify sections to keep vs. regenerate

## Step 3: Analyze Codebase (Contextual)

Based on document type, read relevant source files:

| Document | Analyze |
|----------|---------|
| README | Entry point, package config, main exports |
| CONTRIBUTING | Dev scripts, test setup, lint config |
| CHANGELOG | Git tags, release history, commit messages |
| ARCHITECTURE | Directory structure, core modules, dependencies |
| API | Public exports, type definitions, docstrings |

## Step 4: Generate Document

Use the appropriate template from `templates/`:

- README → `templates/readme-template.md`
- CONTRIBUTING → `templates/contributing-template.md`
- CODE_OF_CONDUCT → `templates/code-of-conduct-template.md`
- CHANGELOG → `templates/changelog-template.md`
- ARCHITECTURE → `templates/architecture-template.md`
- API → `templates/api-docs-template.md`

Apply all conventions from `references/github-styling.md`.

## Step 5: Present and Iterate

Show the generated document to the user.
Ask for specific feedback:
- "Any sections to add or remove?"
- "Anything factually incorrect?"
- "Style adjustments needed?"

Iterate until approved.

</process>

<success_criteria>
Single document is complete when:
- [ ] Document type confirmed with user
- [ ] Relevant codebase analysis performed
- [ ] Template structure followed
- [ ] Styling conventions applied
- [ ] Content accurately reflects codebase
- [ ] User has approved the document
</success_criteria>
