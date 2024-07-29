function IsPistolRound()
    local gameRules = GetCCSGameRules()
    if gameRules == nil then return false end
    if gameRules.WarmupPeriod then return false end
    return gameRules.TotalRoundsPlayed == 0 or gameRules.RoundsPlayedThisPhase == 0 or (gameRules.SwitchingTeamsAtRoundReset and gameRules.OvertimePlaying == 0) or gameRules.GameRestart;
end