# November 8, 2026 observation batch — reviewed

**Review completed:** 65 capture records: 60 getter inspections (12 getters × five calls), three function-inventory snapshots, one `SECTOR_LOADED` event, and one collector test.

**Current status:** Findings are consolidated into permanent reference pages. The large, generated `capture-summary.md` was a temporary handoff, not the canonical reference.

## Extracted results

- [Observed getter signatures and values](../functions/observed-getters.md): includes targetless/asteroid/NPC differences, energy readings, 10-position ship health output, current station state, and speed observations.
- [398-name function accessibility survey](2026-11-08-full-function-survey.md): 388 functions, two tables, one userdata, seven inaccessible names.
- [`SECTOR_LOADED` observation](../events/SECTOR_LOADED.md): recorded zero callback arguments in one occurrence.

**All 60 inspected getter calls completed without Lua errors.** Return counts vary by game state; this does not imply every documented behavior has been validated.

## Subsequent capture handoffs

The raw collector output remains local in `captures/` (Git-ignored). After a new batch is shared and reviewed, record the newest reviewed capture timestamp in `data/reviewed-through.txt` and remove the temporary generated `docs/research/capture-summary.md` from the branch. The Perl report generator then uses the cutoff to share only new observations, rather than republishing the earlier files.

**Caution:** Deleting a file in Git removes it from the current checkout, not from previous commits. Git history still contains previous versions; never treat Git deletion as a secure method for erasing confidential data.
