-- Lorderon humans speak the same language as Stormwind humans, but they choose to deny it
HERMES_UNDEAD = {}
for k,v in pairs(HERMES_COMMON) do
    HERMES_UNDEAD[k] = v
end
HERMES_UNDEAD['LanguageID'] = 33
