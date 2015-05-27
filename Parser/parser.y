class LansciiParser
rule
	S 	: 	'{' D '|' I S '}'
		|	'{' I S '}'
		|	'Listo'
end