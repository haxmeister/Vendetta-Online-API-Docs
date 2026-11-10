# GetSkillLevel

**Status:** Historical Racecar API Index2 listing; call behavior not verified.

The [November 2026 function-name survey](../research/2026-11-08-full-function-survey.md) checks name accessibility but **does not invoke this function or verify its signature**.

## Historical Racecar signature

**Individual page:** `GetSkillLevel(int licenseid) -> int current next`

## Historical description

get current and required xp for next level or provided skill

### Arguments named by the historical source

- licenseid type of license (1-5)

### Returns named by the historical source

- current current xp next xp required for next level

## Evidence and limitations

- [Racecar historical function page](https://www.vo-wiki.com/racecar2/index.php/API_GetSkillLevel) (archived in the user-supplied Racecar documentation ZIP).
- Historical wording, argument names and return layouts are **research leads**, not current-client verification.
- Our live captures, where present, override contradictions in these historical descriptions.
