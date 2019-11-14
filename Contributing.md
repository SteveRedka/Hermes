## Vocabulary structure

### ALPHABET
Alphabet contains exact matches. Left part is what others see, right is what you have to type in to make it appear.

```lua
ALPHABET = {
	{ 'Y', '3' }, -- Typing 3 as humie will make orcs see letter Y
	...
},
```

Alphabets should contain longer words first.
```lua
-- Incorrect
Y = '3'
Loktar = 123456

-- Correct
Loktar = 123456
Y = '3'
```

### SUBSTITUTES
Some letters can't be written using WoW "translator". But they can be substituted with something else.

```lua
	SUBSTITUTES = {
		-- Humans can't say letter 'P'. We replace it with letter B because it sounds relatively close
		POPPY = 'BOBBY'
	},
```

## SEPARATOR
Separator separates words for better readability. In normal languages we use whitespaces for that, but for translation we already separate letters with whitespaces.

`INPUT`: what you put in
`OUTPUT`: how other factions see it


```lua
	SEPARATOR = { 
		INPUT = 'à',
		OUTPUT = 'r'
	}
```

Separator should be as visually disctinct from capital letters as possible. Letter `v` is bad separator, because it blends with `V` and `Y`. Letter `r` is relatively good separator.