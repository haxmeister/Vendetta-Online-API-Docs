# Assistant-guided API research

**Status:** First implementation committed; integration testing in Vendetta Online and the user's local Perl environment is still required.

This mode reduces the normal workflow to **one terminal command and one in-game command**. The collector runs locally; GitHub is a transport for observations and simple research guidance, not a remote Lua execution service.

## Start a session

From the repository root:

~~~sh
perl tools/assist.pl
~~~

The launcher starts the local Perl/Linux::Event collector on `127.0.0.1:54000`. Then start (or reload) Vendetta Online and enter:

~~~text
/apidocs start
~~~

That command connects APIProbe to the collector, enables bounded callback-time getter context, and registers all 214 historical event candidates. The launcher polls GitHub every **60 seconds** and forwards any changes to [`control/plan.txt`](../../control/plan.txt) as messages inside the game. It requests an aggregated **flush every 180 seconds**, so you can keep playing without manually stopping to upload.

Every two minutes, the local launcher attempts to publish new, unreviewed captures to the **public GitHub repository**. The publisher uses a detached temporary Git worktree and pushes **only** the generated observation report, never your unrelated local commits. It reads the reviewed-through marker from the remote branch to prevent publishing old observations again. Publishing requires functioning GitHub push credentials on your machine.

The launcher can fast-forward your local `main` when its tracked files are clean. It never resets, force-pushes, or overwrites tracked edits. If APIProbe's code changes, it sends an in-game reminder to run `/lua ReloadInterface()` at your convenience. Reloading the interface restarts plugins; you may need to run `/apidocs start` again.

The collector and launcher operate only while the terminal command is running. Use Ctrl-C to stop the launcher. In VO, `/apidocs finish` is also available when you want a deliberate end-of-session flush. Without an explicit finish, the most recent unsent examples may remain in memory until the next periodic flush.

## Changing tests from GitHub

An assistant with write access to this repository can edit `control/plan.txt`. The local launcher checks GitHub and sends approved lines to the in-game plugin without requiring you to relay commands.

| Directive | Meaning |
| --- | --- |
| `NOTE|Try launching and changing sectors` | Display a brief in-game research request |
| `CONTEXT|on` / `CONTEXT|off` | Enable or disable bounded approved getter correlations |
| `WATCH|all` | Register all historical candidate events |
| `WATCH|SECTOR_CHANGED` | Switch that named event to detailed observation |
| `INSPECT|all` | Run the 12 approved, read-only getter inspections |
| `SCAN` | Run the 398-name accessibility survey |
| `RELOAD|New plugin code is ready` | Display instructions to reload when convenient |

The bridge **does not** evaluate downloaded Lua, run arbitrary terminal commands, or call unapproved VO APIs. Only these declarative instructions are accepted. Unknown directives are ignored. Large or non-ASCII lines are rejected by the local collector. The interface reload directive is *a reminder*, not an automatic call to `ReloadInterface()`.

For research, we should prefer the default broad watch plus occasional targeted `INSPECT|all` instructions. Repeated full scans are usually unnecessary.

## Privacy and trust

The collector listens only on localhost and is separate from the game servers. **The `assist.pl` launcher explicitly opts into unattended public publication.** Event values, target names, station identifiers and other non-chat data may become publicly visible through GitHub and remain in its commit history.

APIProbe now records **bounded chat-table keys, types, nesting and example values locally**, including real strings. Treat local `captures/` as private. The public report generator keeps chat schemas (the table keys and field types developers need) and numeric/boolean argument examples, but omits private chat text and chat-table value previews. This protection applies to individual event captures **and** to chat events embedded in broad-watch snapshots. Other events may still contain sensitive values; do not use unattended publication during sensitive play. For local-only research use `perl tools/collect.pl` instead.

GitHub is *not* a secure command channel for executing untrusted code. Repository control access must remain limited to collaborators you trust.

## Automated documentation review

The local bridge can publish and present instructions even if ChatGPT is not currently open. However, **documentation review requires an active ChatGPT run or a separately configured scheduled automation**. A GitHub push alone does not immediately invoke this chat.

With an automation enabled, a future ChatGPT run can inspect new `docs/research/capture-summary.md`, update individual event reference pages, advance `data/reviewed-through.txt`, remove the temporary report and adjust the next test plan. Scheduled reviews are not instantaneous.

## Troubleshooting and verification

Before the first session, update and test the checkout:

~~~sh
git pull --ff-only
prove -lr t
texlua t/mock-plugin.lua
~~~

If either test fails, fix it before enabling automatic upload.

Use `perl tools/assist.pl --help` for launcher options. The default polling interval is 60 seconds and can be changed with `--poll-seconds` (minimum 20); periodic flushes can be changed with `--flush-seconds` (minimum 30). The simpler `perl tools/collect.pl` remains available for local-only capture.

If the terminal reports a Git authentication or merge failure, the existing local captures are not deleted. A report upload can be retried. Nothing in this workflow rewrites Git history or automatically executes downloaded Lua.
