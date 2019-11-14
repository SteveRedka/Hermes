SLASH_HERMES1, SLASH_HERMES2, SLASH_HERMES3, SLASH_HERMES4, SLASH_HERMES5 = '/common', '/hermes', '/orcish', '/crossfaction', '/cf';
SlashCmdList["HERMES"] = function(msg, editBox)
	sayToOtherFaction(msg, 'SAY')
end

SLASH_YHERMES1, SLASH_YHERMES2, SLASH_YHERMES3, SLASH_YHERMES4, SLASH_YHERMES5 = "/ycommon", "/yorcish", "/yhermes", '/ycrossfaction', '/ycf';
SlashCmdList["YHERMES"] = function(msg, editBox)
	sayToOtherFaction(msg, 'YELL')
end

function sayToOtherFaction(msg, tone)
	local DICTIONARY = chooseDictionary();
	local translation = translate(msg, DICTIONARY);

	if # translation[1] > 210 then
		print('String is too long')
	else
		print('They see: |cFFFF0000'..translation[2])
		SendChatMessage(translation[1], tone, DICTIONARY['LanguageID']);
	end
end

function translate(msg, dictionary)
	local YOU_SAY = ''
	local THEY_SEE = ''
	local RAW_STRING = string.upper(msg)

	while # RAW_STRING > 0 do
		local letter_found = false

		-- Try normal vocabulary
		for i, pairr in ipairs(dictionary['ALPHABET']) do
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
			for key, val in pairs(dictionary['SUBSTITUTES']) do
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
				YOU_SAY = YOU_SAY..dictionary['SEPARATOR']['INPUT']..' '
				THEY_SEE = THEY_SEE..dictionary['SEPARATOR']['OUTPUT']..' '
			end
		end

		if not letter_found then
			-- Ignore all other symbols
			RAW_STRING = string.gsub(RAW_STRING, '^.', '')
		end
	end

	return({ YOU_SAY, THEY_SEE })
end

function chooseDictionary()
	race = UnitRace('player')
	faction = UnitFactionGroup('player')
	if string.match(faction, 'Alliance') then
		return(HERMES_COMMON)
	elseif string.match(race, 'Undead') then
		return(HERMES_UNDEAD)
	elseif string.match(race, 'Troll') then
		return(HERMES_ZANDALI)
	elseif string.match(faction, 'Horde') then
		return(HERMES_ORCISH)
	else
		print('Not supported yet')
	end
end