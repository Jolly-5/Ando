# LESSONS_LEARNED

- The repo tooling/editor diagnostics may lag behind Rojo build; always validate with `rojo build` before assuming Luau issues are real.
- Avoid diff-based edits when file contents are uncertain; use full-file create/overwrite to prevent diff mismatch.

