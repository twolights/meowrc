# git
When running git diff or git show, always include --no-ext-diff flag.

# Product design

Products should be **AI-friendly** — usable by AI agents/LLMs, not just human UIs.

Concrete examples:
- **APIs**: well-structured, documented (OpenAPI), predictable schemas
- **CLIs**: scriptable, parseable output, stable interfaces
- More broadly: any surface an AI could drive (MCP servers, structured logs, machine-readable configs)

**Why:** AI agents are increasingly the consumers of software. Building AI-friendly interfaces from the start makes products integrable into agent workflows and multiplies their reach beyond human operators.

**How to apply:** When designing or reviewing product surfaces (new endpoints, CLI tools, admin features), ask "could an AI agent drive this effectively?" Prefer structured/declarative interfaces over GUI-only flows. Ensure documentation is machine-readable (OpenAPI, typed schemas, examples).

@RTK.md
