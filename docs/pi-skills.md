# Pi

Global Pi skills are tracked in this repo at:

```text
agents/skills
```

and symlinked to Pi's global skill directory:

```text
~/.pi/agent/skills
```

## Skill format

Use a directory containing `SKILL.md`:

```text
agents/skills/example-skill/
└── SKILL.md
```

Minimal `SKILL.md`:

```markdown
---
name: example-skill
description: What this skill does and when Pi should use it.
---

# Example Skill

Instructions for the agent.
```

Pi discovers global skills at startup. Skills are available globally, but their full instructions are loaded on-demand when the task matches the description or when invoked with `/skill:name`.

Pi global extensions and user settings are tracked at:

```text
agents/extensions -> ~/.pi/agent/extensions
agents/settings.json -> ~/.pi/agent/settings.json
```

The `update.ts` extension provides `/update` to update Pi and reload its resources. Use `/update extensions` to update installed Pi packages only and reload. Settings include the Pi package list, such as `npm:@plannotator/pi-extension`.

Do not commit `~/.pi/agent/auth.json`, sessions, logs, model stores, package caches, or other local Pi state.
