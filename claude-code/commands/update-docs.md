# Update Documentation

**Skill Name:** `/update-docs`
**Purpose:** Universal documentation updater for any project after code changes

## Usage

```
/update-docs
```

Or with specific commits:
```
/update-docs [commit-hash] [commit-hash]
```

Or for recent N commits:
```
/update-docs --recent 2
```

## What This Skill Does

This skill automatically updates project documentation after code changes, adapting to your project's structure.

### Step 1: Detect Project Structure

Automatically identifies documentation patterns:
- **README.md** (standard project documentation)
- **CLAUDE.md** (development guidelines, if present)
- **CONTRIBUTING.md** (contribution guidelines, if present)
- **specs/** directory (SpecKit methodology)
- **docs/** directory (standard documentation)
- **wiki/** directory (project wiki)

### Step 2: Identify Changes

- Checks recent git commits (default: last 2 commits)
- Or uses specified commit hashes
- Extracts feature names, implementation details, and impacts
- Maps changes to relevant documentation areas

### Step 3: Update User-Facing Documentation

#### README.md (Primary User Documentation)
Common sections to update:
- **Features**: New capabilities with descriptions
- **Installation**: New dependencies or setup steps
- **Usage**: Examples and how-tos
- **Configuration**: New config options
- **API**: Endpoint or function documentation
- **Architecture**: System diagrams and components
- **Advanced Usage**: New workflows
- **Troubleshooting**: Common issues and solutions
- **Performance**: Benchmarks and optimizations

#### docs/ Directory (If Present)
- Getting started guides
- API reference
- Tutorials
- Architecture documentation
- Deployment guides

### Step 4: Update Developer Documentation

#### CLAUDE.md (If Present)
Project-level development guidelines:
- **Recent Changes**: Log of major changes
- **Implementation Details**: Technical patterns and decisions
- **Development Workflow**: Process updates
- **Documentation Status**: What was updated

#### CONTRIBUTING.md (If Present)
- New development workflows
- Updated testing requirements
- New commands or tools
- Architecture changes

#### SpecKit Documentation (If specs/ Directory Exists)

**Automatic Detection:**
- Scans `specs/` for all feature specs (e.g., `001-feature-name/`, `002-another-feature/`)
- Determines which spec(s) to update based on file paths and commit messages

**For Each Relevant Spec:**

**spec.md:**
- Add implementation enhancements to user stories
- Update acceptance scenarios
- Document new edge cases

**tasks.md:**
- Add completed tasks (T0XX format)
- Mark tasks as `[x]` completed
- Add to appropriate phase

**plan.md / quickstart.md:**
- Update architecture diagrams
- Add/update flows
- Document new features
- Update performance targets

### Step 5: Detect File-to-Doc Mapping

Smart mapping based on project structure:

**Common Patterns:**
```
src/**/*.js         → README.md (Features, API)
lib/**/*.py         → README.md (Usage)
cmd/**/*.go         → README.md (CLI commands)
api/**/*            → API documentation
tests/**/*          → Testing section
docs/**/*           → Related docs/ files
config/*            → Configuration section
.github/workflows/* → CI/CD section (if documented)
```

**SpecKit Projects:**
```
Sources/FeatureA/* → specs/001-feature-a/
Sources/FeatureB/* → specs/002-feature-b/
Infrastructure/*   → CLAUDE.md only
```

**Detection Strategy:**
1. Parse commit diffs → Identify changed files
2. Map to documentation → Match file patterns to doc sections
3. Check project structure → Detect README sections, specs/, docs/
4. Ask if unclear → Prompt which docs to update if ambiguous

### Step 6: Commit Documentation

Creates a properly formatted commit:
```
📝 docs: document [feature-name]

Update documentation for [feature description]:
- [Change 1]: [description]
- [Change 2]: [description]

Updated files:
- README.md: [sections updated]
- [other docs]: [changes]

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

## Project Type Detection

### Standard Project
Has `README.md`, possibly `docs/`:
- Updates README with new features/usage
- Updates docs/ if present
- Updates CONTRIBUTING.md if present

### SpecKit Project
Has `specs/` directory with numbered features:
- Updates relevant specs (spec.md, tasks.md, quickstart.md)
- Updates CLAUDE.md with implementation details
- Updates README.md for user-facing changes

### Documentation-Heavy Project
Has extensive `docs/` directory:
- Maps changes to specific doc files
- Updates index/navigation if needed
- Updates README as overview

### Monorepo
Multiple packages/modules:
- Updates package-specific README files
- Updates root README for cross-cutting changes
- Updates workspace documentation

## Examples

### Example 1: Standard Project
```
my-app/
├── README.md
├── src/
└── tests/
```

After committing feature in `src/auth.js`:
```
/update-docs
```
→ Updates README.md (Features, Usage, API sections)

### Example 2: SpecKit Project
```
project/
├── README.md
├── CLAUDE.md
├── specs/
│   ├── 001-auth/
│   └── 002-api/
└── src/
```

After committing in `src/auth/`:
```
/update-docs
```
→ Updates `specs/001-auth/`, `CLAUDE.md`, `README.md`

### Example 3: Documentation Project
```
project/
├── README.md
├── docs/
│   ├── getting-started.md
│   ├── api/
│   └── guides/
└── src/
```

After adding API endpoint:
```
/update-docs
```
→ Updates `docs/api/endpoints.md`, `README.md`

### Example 4: Custom Commits
```
/update-docs abc123 def456
/update-docs --recent 5
```

## Configuration

### Project-Level Config (CLAUDE.md or .claude/config.json)

Optional configuration in CLAUDE.md:
```markdown
## Update-Docs Configuration
- Default commits: 2
- Auto-commit: true
- SpecKit enabled: true
- Doc directories: docs/, wiki/
```

Or in `.claude/config.json`:
```json
{
  "update-docs": {
    "defaultCommits": 2,
    "autoCommit": true,
    "specKit": true,
    "docDirs": ["docs/", "wiki/"]
  }
}
```

### Detection Overrides

If automatic detection fails, prompt the user:
- Which documentation files to update?
- Which sections in README to update?
- Is this a SpecKit project?

## When to Use This Skill

Use `/update-docs` after:
- ✅ Implementing new features
- ✅ Adding/changing APIs or CLIs
- ✅ Changing architecture
- ✅ Fixing significant bugs
- ✅ Adding configuration options
- ✅ Updating workflows

**Do NOT use** for:
- ❌ Typo fixes in code
- ❌ Code formatting changes
- ❌ Minor refactoring without user-visible changes
- ❌ Documentation-only changes (already documented)

## Integration with Other Skills

### After Feature Implementation
1. Implement feature
2. Create feature commit: `/commit`
3. Update documentation: `/update-docs`
4. Review and push

### With SpecKit Workflow
1. Plan: `/speckit.plan`
2. Implement: `/speckit.implement`
3. Commit: `/commit`
4. Document: `/update-docs`
5. Verify: `/speckit.analyze`

## Best Practices

1. **Update immediately** after feature commits
2. **Be comprehensive** - update all relevant sections
3. **Add examples** - show users how to use new features
4. **Match style** - follow existing documentation patterns
5. **Test examples** - verify code samples work
6. **Link sections** - cross-reference related docs
7. **Keep current** - remove outdated information

## Smart Features

### Automatic Section Detection
Detects common README sections:
- Features, Installation, Usage, API, Configuration
- Examples, Tutorial, Advanced, Contributing
- Troubleshooting, FAQ, Performance, Security
- Architecture, Design, Roadmap

### Language Detection
Adapts examples to project language:
- JavaScript/TypeScript → npm, Node.js examples
- Python → pip, Python examples
- Go → go get, Go examples
- Rust → cargo, Rust examples
- Swift → Package.swift, Swift examples

### Change Type Detection
Identifies change types for targeted updates:
- **New feature** → Features, Usage, Examples
- **Bug fix** → Troubleshooting, Changelog
- **Configuration** → Configuration section
- **Architecture** → Architecture, Design
- **Performance** → Performance section
- **Breaking change** → Migration guide, Changelog

## Related Commands

- `/commit` - Create feature commits with conventional format
- `/speckit.tasks` - Generate task lists (SpecKit projects)
- `/speckit.plan` - Create implementation plans (SpecKit projects)
- `/speckit.analyze` - Verify documentation consistency

## Notes

- Documentation commits are separate from feature commits
- Uses emoji conventional commit format: `📝 docs:`
- Auto-includes Co-Authored-By footer
- Preserves existing documentation style
- Works offline (git-based analysis only)
- Respects `.gitignore` for documentation files
- Handles multiple documentation formats (Markdown, AsciiDoc, RST)

## Error Handling

If detection fails:
1. Shows detected structure
2. Lists found documentation files
3. Prompts user for clarification
4. Saves preference for future runs

If no documentation found:
- Offers to create basic README.md
- Suggests standard sections
- Uses project language/framework templates
