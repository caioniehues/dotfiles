# Workflow: Audit Documentation

<required_reading>
**Read these reference files NOW:**
1. references/doc-types.md
</required_reading>

<process>

## Step 1: Scan for Documentation

```bash
# Find all markdown files
find . -name "*.md" -not -path "./node_modules/*" -not -path "./.git/*" -not -path "./target/*" -not -path "./dist/*" | sort

# Check standard locations
ls -la README.md CONTRIBUTING.md CODE_OF_CONDUCT.md CHANGELOG.md LICENSE 2>/dev/null
ls -la docs/ 2>/dev/null
```

## Step 2: Evaluate Each Document Type

### README.md
- [ ] Exists?
- [ ] Has project description?
- [ ] Has installation instructions?
- [ ] Has usage example?
- [ ] Has badges (optional but recommended)?
- [ ] Has table of contents (if long)?
- [ ] Links work?

### CONTRIBUTING.md
- [ ] Exists?
- [ ] Has development setup?
- [ ] Has code style guidelines?
- [ ] Has PR process?
- [ ] Has issue reporting guide?

### CODE_OF_CONDUCT.md
- [ ] Exists?
- [ ] Uses standard (Contributor Covenant)?
- [ ] Has contact info for enforcement?

### CHANGELOG.md
- [ ] Exists?
- [ ] Follows Keep a Changelog format?
- [ ] Has recent entries?
- [ ] Links to releases?

### LICENSE
- [ ] Exists?
- [ ] Matches declared license in package config?
- [ ] Has correct year and copyright holder?

### Architecture/Design Docs
- [ ] Exists?
- [ ] Reflects current codebase?
- [ ] Has diagrams?

### API Documentation
- [ ] Exists?
- [ ] Covers public API?
- [ ] Has examples?
- [ ] Types documented?

## Step 3: Check Content Quality

For each existing document:

**Accuracy:**
- Code examples work?
- Commands match actual scripts?
- Version numbers current?

**Completeness:**
- All sections have content (no TODOs)?
- All features documented?

**Style:**
- Consistent formatting?
- Proper markdown syntax?
- Good heading hierarchy?

## Step 4: Generate Audit Report

Present findings as:

```markdown
# Documentation Audit Report

## Summary
- **Coverage:** X/7 standard documents exist
- **Quality Score:** X/10
- **Critical Issues:** X

## Document Status

| Document | Status | Issues |
|----------|--------|--------|
| README.md | ✅ Good | Minor: missing badges |
| CONTRIBUTING.md | ⚠️ Needs work | Outdated setup instructions |
| CODE_OF_CONDUCT.md | ❌ Missing | - |
| CHANGELOG.md | ⚠️ Needs work | No entries since v1.0 |
| LICENSE | ✅ Good | - |
| Architecture | ❌ Missing | - |
| API docs | ⚠️ Needs work | Incomplete coverage |

## Recommendations

### High Priority
1. [Most critical issue]
2. [Second most critical]

### Medium Priority
1. [...]

### Nice to Have
1. [...]

## Next Steps
Would you like me to:
1. Generate missing documents?
2. Fix issues in existing documents?
3. Start with a specific document?
```

</process>

<success_criteria>
Audit is complete when:
- [ ] All documentation locations scanned
- [ ] Each standard document type evaluated
- [ ] Content quality assessed
- [ ] Issues categorized by severity
- [ ] Report presented to user
- [ ] Next steps offered
</success_criteria>
