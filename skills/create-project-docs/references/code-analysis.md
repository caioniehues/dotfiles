<overview>
Patterns for extracting documentation-relevant information from source code. Use these techniques to generate accurate documentation that reflects the actual codebase.
</overview>

<project_detection>
<identify_language_and_framework>
Check for manifest files to determine project type:

| File | Type |
|------|------|
| `package.json` | Node.js/JavaScript/TypeScript |
| `Cargo.toml` | Rust |
| `pyproject.toml`, `setup.py` | Python |
| `go.mod` | Go |
| `pom.xml`, `build.gradle` | Java |
| `Gemfile` | Ruby |
| `composer.json` | PHP |
| `*.csproj`, `*.sln` | C#/.NET |

**Extract from manifest:**
- Project name
- Version
- Description
- Dependencies
- Scripts/commands
- License
- Author/maintainer info
</identify_language_and_framework>

<determine_entry_points>
**By language:**

| Language | Common Entry Points |
|----------|---------------------|
| Python | `__main__.py`, `main.py`, `app.py`, `src/{name}/__init__.py` |
| JavaScript | `index.js`, `src/index.js`, `main` field in package.json |
| TypeScript | `index.ts`, `src/index.ts`, `main`/`types` in package.json |
| Rust | `src/main.rs`, `src/lib.rs` |
| Go | `main.go`, `cmd/*/main.go` |
</determine_entry_points>
</project_detection>

<extract_public_api>
<javascript_typescript>
Look for exports:

```bash
# Find all exports
grep -rn "export " src/ --include="*.ts" --include="*.js"

# Find default exports
grep -rn "export default" src/

# Check index files for re-exports
cat src/index.ts
```

**Patterns to identify:**
```typescript
// Named exports
export function functionName() {}
export const constantName = value;
export class ClassName {}
export interface InterfaceName {}
export type TypeName = ...;

// Default exports
export default class MyClass {}

// Re-exports
export { thing } from './module';
export * from './module';
```
</javascript_typescript>

<python>
Look for public interfaces:

```bash
# Find __all__ definitions
grep -rn "__all__" src/ --include="*.py"

# Find public functions (not starting with _)
grep -rn "^def [^_]" src/ --include="*.py"

# Find public classes
grep -rn "^class [^_]" src/ --include="*.py"
```

**Patterns to identify:**
```python
# Explicit public API
__all__ = ['function_a', 'ClassB']

# Public by convention (no leading underscore)
def public_function():
    pass

class PublicClass:
    pass

# Private by convention
def _private_function():
    pass
```
</python>

<rust>
Look for pub items:

```bash
# Find public functions
grep -rn "pub fn" src/ --include="*.rs"

# Find public structs
grep -rn "pub struct" src/ --include="*.rs"

# Find public modules
grep -rn "pub mod" src/ --include="*.rs"
```

**Patterns to identify:**
```rust
// Public API
pub fn public_function() {}
pub struct PublicStruct {}
pub enum PublicEnum {}
pub trait PublicTrait {}

// Re-exports
pub use module::Type;
```
</rust>

<go>
Look for capitalized identifiers (Go's public convention):

```bash
# Find exported functions
grep -rn "^func [A-Z]" --include="*.go"

# Find exported types
grep -rn "^type [A-Z]" --include="*.go"
```

**Patterns to identify:**
```go
// Exported (public)
func PublicFunction() {}
type PublicType struct {}

// Unexported (private)
func privateFunction() {}
type privateType struct {}
```
</go>
</extract_public_api>

<extract_docstrings>
<python_docstrings>
```python
def function():
    """This is the docstring.

    Args:
        param1: Description
        param2: Description

    Returns:
        Description of return value

    Raises:
        ErrorType: When this happens
    """
```

**Formats:**
- Google style (shown above)
- NumPy style
- Sphinx/reST style
</python_docstrings>

<jsdoc>
```javascript
/**
 * Description of function.
 *
 * @param {string} param1 - Description
 * @param {number} [param2=10] - Optional with default
 * @returns {Promise<Result>} Description
 * @throws {Error} When something fails
 * @example
 * const result = await myFunction('test');
 */
```
</jsdoc>

<rust_doc_comments>
```rust
/// Description of function.
///
/// # Arguments
///
/// * `param1` - Description
///
/// # Returns
///
/// Description of return value
///
/// # Examples
///
/// ```
/// let result = my_function(arg);
/// ```
///
/// # Errors
///
/// Returns `Error` when...
pub fn my_function(param1: Type) -> Result<T, E> {}
```
</rust_doc_comments>

<go_comments>
```go
// FunctionName does something.
//
// It takes param1 and returns result.
// If something goes wrong, it returns an error.
func FunctionName(param1 Type) (Result, error) {}
```

Go uses plain comments directly above declarations.
</go_comments>
</extract_docstrings>

<infer_features>
<from_dependencies>
Analyze dependencies to understand capabilities:

**package.json:**
```json
{
  "dependencies": {
    "express": "^4.18.0",    // HTTP server
    "mongoose": "^7.0.0",    // MongoDB
    "redis": "^4.0.0",       // Caching
    "jsonwebtoken": "^9.0.0" // Authentication
  }
}
```

Implies: Web server with MongoDB database, Redis caching, JWT authentication.

**Cargo.toml:**
```toml
[dependencies]
tokio = { version = "1", features = ["full"] }  # Async runtime
axum = "0.7"                                     # Web framework
sqlx = { version = "0.7", features = ["postgres"] }  # Database
```

Implies: Async web server with PostgreSQL.
</from_dependencies>

<from_directory_structure>
```
src/
├── api/          # REST/GraphQL endpoints
├── auth/         # Authentication logic
├── db/           # Database layer
├── models/       # Data models
├── services/     # Business logic
├── utils/        # Utilities
└── config/       # Configuration

tests/            # Test files
docs/             # Documentation
examples/         # Usage examples
scripts/          # Build/deploy scripts
```

Directory names reveal architecture and features.
</from_directory_structure>

<from_scripts>
**package.json scripts:**
```json
{
  "scripts": {
    "start": "node dist/index.js",
    "dev": "nodemon src/index.ts",
    "build": "tsc",
    "test": "jest",
    "lint": "eslint src/",
    "migrate": "prisma migrate dev"
  }
}
```

Documents available commands for README.
</from_scripts>
</infer_features>

<extract_configuration>
<config_files>
Look for configuration patterns:

| File | Purpose |
|------|---------|
| `.env.example` | Environment variables |
| `config/` directory | Configuration modules |
| `*.config.js`, `*.config.ts` | Tool configs |
| `settings.py`, `config.py` | Python settings |
| `config.toml`, `config.yaml` | Config files |
</config_files>

<environment_variables>
From `.env.example`:
```env
DATABASE_URL=postgresql://localhost/mydb
REDIS_URL=redis://localhost:6379
JWT_SECRET=your-secret-key
PORT=3000
LOG_LEVEL=info
```

Document each variable:
- Name
- Purpose
- Required or optional
- Default value
- Example value
</environment_variables>
</extract_configuration>

<extract_cli_interface>
<python_argparse>
Look for ArgumentParser usage:
```python
parser = argparse.ArgumentParser(description='Tool description')
parser.add_argument('-v', '--verbose', action='store_true')
parser.add_argument('-o', '--output', type=str, default='output.txt')
```
</python_argparse>

<rust_clap>
Look for Clap derive or builder patterns:
```rust
#[derive(Parser)]
#[command(name = "tool", about = "Tool description")]
struct Cli {
    #[arg(short, long)]
    verbose: bool,
}
```
</rust_clap>

<javascript_commander>
Look for Commander.js or yargs:
```javascript
program
  .name('tool')
  .description('Tool description')
  .option('-v, --verbose', 'Verbose output')
```
</javascript_commander>
</extract_cli_interface>

<analysis_workflow>
<step_1>
**Identify project type:**
```bash
ls -la
```
Find manifest file, determine language/framework.
</step_1>

<step_2>
**Read manifest:**
```bash
cat package.json  # or Cargo.toml, pyproject.toml, etc.
```
Extract name, version, description, dependencies.
</step_2>

<step_3>
**Map directory structure:**
```bash
find . -type f -name "*.py" -o -name "*.ts" -o -name "*.rs" | head -50
```
Understand project layout.
</step_3>

<step_4>
**Find entry points:**
Read main files to understand what the project does.
</step_4>

<step_5>
**Extract public API:**
Find exports, public functions, types.
</step_5>

<step_6>
**Read docstrings:**
Extract existing documentation from code.
</step_6>

<step_7>
**Infer from dependencies:**
Understand capabilities from what's installed.
</step_7>

<step_8>
**Check for examples:**
```bash
ls examples/ docs/ 2>/dev/null
```
Existing examples can be incorporated.
</step_8>
</analysis_workflow>

<accuracy_checks>
**Before writing documentation:**
- Verify version numbers match manifest
- Test that installation commands work
- Ensure code examples are syntactically correct
- Confirm imports match actual module structure
- Check that referenced files exist
</accuracy_checks>
