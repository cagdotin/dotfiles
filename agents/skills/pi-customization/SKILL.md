---
name: pi-customization
description: Instructions that must always be read before creating or modifying Pi extensions, skills, prompts, themes, settings, or other Pi resources.
---

# Pi customization

Follow Pi's installed documentation and examples before implementing Pi resources.

## Choose scope first

Before creating or changing a Pi resource, determine whether it should be local or global.

- If the user already explicitly chose a scope, use it.
- Otherwise, ask whether they want **local** (only the current project) or **global** (available in every project).
- Do not assume global scope merely because the current repository is the dotfiles repository.

## Local resources

Store local resources in the current project's Pi directory:

- Extensions: `<cwd>/.pi/extensions/`
- Skills: `<cwd>/.pi/skills/`
- Prompts: `<cwd>/.pi/prompts/`
- Themes: `<cwd>/.pi/themes/`
- Settings: `<cwd>/.pi/settings.json`

Treat `<cwd>` as the project where the customization should apply. Keep project-local resources safe to commit and remember that Pi loads them only after the project is trusted.

## Global resources

All publishable global Pi customizations must be created and maintained in the dotfiles repository at:

```text
~/code/dotfiles
```

Use these tracked source locations:

- Extensions: `~/code/dotfiles/agents/extensions/`
- Skills: `~/code/dotfiles/agents/skills/`
- Prompts: `~/code/dotfiles/agents/prompts/`
- Themes: `~/code/dotfiles/agents/themes/`
- Settings: `~/code/dotfiles/agents/settings.json`

Never create a global customization only inside `~/.pi/agent`. Add it to the dotfiles repository first, then ensure `~/code/dotfiles/scripts/link-pi-skills.sh` or another focused, idempotent linking script makes Pi's corresponding global path point to the tracked source. Extensions placed directly in `agents/extensions/` are linked automatically. Preserve and back up existing untracked global resources rather than replacing an entire directory blindly.

Do not put secrets, auth data, sessions, logs, caches, downloaded packages, or machine-local generated state in the dotfiles repository.

## Implementation workflow

1. Ask local or global scope unless already specified.
2. Read the relevant Pi documentation completely and follow its linked documentation and examples.
3. Inspect existing resources and linking behavior before editing.
4. Add the resource at the correct tracked location.
5. For global resources, ensure setup can link it safely and idempotently from `~/code/dotfiles`.
6. Validate the resource, run relevant syntax or load checks, and inspect `git diff` and `git status` without disturbing unrelated changes.
7. Tell the user whether `/reload` or a Pi restart is needed.
