SLASH_HERMES1, SLASH_HERMES2, SLASH_HERMES3 = '/common', '/hermes', '/orcish';
function SlashCmdList.HERMES(msg, editBox)
	local YOU_SAY = ''
	local THEY_SEE = ''
	local RAW_STRING = string.upper(msg)

	local DICTIONARY = chooseDictionary();
	print('choseb')

	while # RAW_STRING > 0 do
		local letter_found = false

		-- Try normal vocabulary
		for i, pairr in ipairs(DICTIONARY['ALPHABET']) do
			key = pairr[1]
			val = pairr[2]
			if string.match(RAW_STRING, '^'..key) then
				YOU_SAY = YOU_SAY..val..' '
				THEY_SEE = THEY_SEE..key..' '
				RAW_STRING = string.gsub(RAW_STRING, key, '', 1)
				letter_found = true
				break
			end
		end

		if not letter_found then
			-- Try substituting unavailable letters
			for key, val in pairs(DICTIONARY['SUBSTITUTES']) do
				if string.match(RAW_STRING, '^'..key) then
					RAW_STRING = string.gsub(RAW_STRING, key, val, 1)
					letter_found = true
					break
				end
			end
		end

		if not letter_found then
			-- Replace trailing whitespace with separator
			if string.match(RAW_STRING, '^%s') then
				YOU_SAY = YOU_SAY..DICTIONARY['SEPARATOR']['INPUT']..' '
				THEY_SEE = THEY_SEE..DICTIONARY['SEPARATOR']['OUTPUT']..' '
			end
		end

		if not letter_found then
			-- Ignore all other symbols
			RAW_STRING = string.gsub(RAW_STRING, '^.', '')
		end
	end

	if # YOU_SAY > 210 then
		print('String is too long')
	else
		print('They see: |cFFFF0000'..THEY_SEE)
		SendChatMessage(YOU_SAY, "SAY", DICTIONARY['LanguageID']);
	end
end

function chooseDictionary()
	race = UnitRace('player')
	faction = UnitFactionGroup('player')
	if string.match(faction, 'Alliance') then
		return(HERMES_COMMON)
	elseif string.match(race, 'Undead') then
		return(HERMES_UNDEAD)
	else
		print('Not supported yet')
	end
end