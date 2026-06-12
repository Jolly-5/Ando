# Systems

This folder is for cross-cutting systems (messaging, persistence, auth, etc.).

Conventions:
- Keep public interfaces in `shared/` when both sides need them.
- Keep Roblox Service wiring inside `server/` or `client/`.

