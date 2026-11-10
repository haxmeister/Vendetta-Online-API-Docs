# OverlapPrevention

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `OverlapPrevention(table ip) -> bool overlap`

## Historical description

Adjust icon positions in a viewport so that they don't overlap

### Arguments named by the historical source

- ip table with viewport dimensions and icon positions
- ip.icon_positions table with icon_postions
- ip.width width of viewport
- ip.height height of viewport

### Returns named by the historical source

- overlap true if icons overlapped

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_OverlapPrevention) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
