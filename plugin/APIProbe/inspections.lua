-- Approved, argument-free, read-only game state getters.
-- Explicit closures work under VO's strict global sandbox.
-- Do not add mutating actions, arbitrary user expressions, or functions
-- that require arguments here.
return {
    {"GetCurrentSectorid",  function() return GetCurrentSectorid() end},
    {"GetCurrentSystemid",  function() return GetCurrentSystemid() end},
    {"GetCurrentStationID", function() return GetCurrentStationID() end},
    {"GetActiveShipHealth", function() return GetActiveShipHealth() end},
    {"GetActiveShipEnergy", function() return GetActiveShipEnergy() end},
    {"GetActiveShipSpeed",  function() return GetActiveShipSpeed() end},
    {"GetActiveShipName",   function() return GetActiveShipName() end},
    {"GetTargetInfo",       function() return GetTargetInfo() end},
    {"GetTargetDistance",   function() return GetTargetDistance() end},
    {"HasActiveShip",       function() return HasActiveShip() end},
    {"PlayerInStation",     function() return PlayerInStation() end},
    {"IsStormPresent",      function() return IsStormPresent() end},
}
