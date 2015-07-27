KillsToLevel = {}

KillsToLevel.name = "KillsToLevel"

function KillsToLevel.onExperienceGain(event, reason, level, previousExperience, currentExperience)
  if reason == PROGRESS_REASON_KILL then
    local experienceGained = currentExperience - previousExperience;
    local experienceInLevel = GetNumExperiencePointsInLevel(level);
    local experienceToGo = experienceInLevel - currentExperience;
    local killsToLevel = experienceToGo / experienceGained;
    KillsToLevel.printKillsToGoMessage(killsToLevel, experienceInLevel, experienceToGo, experienceGained)
  end
end

function KillsToLevel.printKillsToGoMessage(killsToLevel, experienceInLevel, experienceToGo, experienceGained)
    local roundedKillsToLevel = KillsToLevel.round(killsToLevel)
    local message = "[KTL] +" .. experienceGained .. " EXP / " .. roundedKillsToLevel .. " kills until you level [" .. experienceToGo .. " / " .. experienceInLevel .. "]"
    CHAT_SYSTEM:AddMessage(message)
end

function KillsToLevel.round(number)
  local roundedNumber = math.floor(number)
  return roundedNumber
end

EVENT_MANAGER:RegisterForEvent(KillsToLevel.name,
  EVENT_EXPERIENCE_GAIN,
  KillsToLevel.onExperienceGain)
