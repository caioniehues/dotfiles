# Workflow: Update Existing Documentation

<required_reading>
**Read these reference files NOW:**
1. references/code-analysis.md
</required_reading>

<process>

## Step 1: Inventory Existing Documentation

```bash
# Find all markdown documentation
find . -name "*.md" -not -path "./node_modules/*" -not -path "./.git/*" | head -20

# Check docs directory if exists
ls -la docs/ 2>/dev/null || echo "No docs/ directory"
```

List what exists and note last modified dates.

## Step 2: Identify Changes Since Last Update

**For git repositories:**
```bash
# Recent changes to source files
git log --oneline --since="1 month ago" -- "*.py" "*.ts" "*.js" "*.rs" "*.go" "src/" "lib/"

# Check for new exports or public API changes
git diff HEAD~10 -- "**/index.*" "**/lib.*" "**/mod.rs" "**/main.*"
```

**Analyze changes:**
- New features added?
- API signatures changed?
- New dependencies?
- Configuration options changed?
- Breaking changes?

## Step 3: Cross-Reference with Docs

For each existing document, check:

| Document | Check Against |
|----------|---------------|
| README | Package version, features list, installation, examples |
| CONTRIBUTING | Dev setup, test commands, dependencies |
| CHANGELOG | Git tags, releases, recent commits |
| ARCHITECTURE | Directory structure, new modules |
| API docs | Public exports, function signatures |

Flag sections that are potentially outdated.

## Step 4: Present Findings

Tell the user:

```
Documentation audit results:

✅ Up to date:
- [list]

⚠️ Potentially outdated:
- README.md: Installation section references old dependency
- API.md: Missing documentation for new_function()
- CHANGELOG: Missing entries since v1.2.0

❌ Missing:
- [list]

Would you like me to update the outdated sections?
```

## Step 5: Update Selectively

For each outdated section:
1. Read current documentation section
2. Read current source code
3. Generate updated content
4. Show diff to user
5. Apply if approved

**Preserve:**
- User customizations
- Manual additions
- Specific wording choices (when not factually wrong)

**Update:**
- Version numbers
- Code examples that no longer work
- API documentation that doesn't match signatures
- Installation instructions
- Dependency lists

## Step 6: Validate Updates

After updates:
- [ ] Code examples still work
- [ ] Links not broken
- [ ] Version numbers consistent
- [ ] No contradictions between documents

</process>

<success_criteria>
Documentation update is complete when:
- [ ] All existing docs inventoried
- [ ] Changes since last update identified
- [ ] Outdated sections flagged
- [ ] User approved update plan
- [ ] Updates applied preserving customizations
- [ ] Validation checks pass
</success_criteria>
