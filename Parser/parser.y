class Parser

token 	'{' '|' '}' '%' '!' '@' '=' 'read' 'write' ';' '(' '?' ')' 
		':' '[' ']' '..' '+' '-' '*' '/' '%' '/\' '\/' '^' 'true' 'false'
		'<' '<=' '>' '>=' '=' '/=' '&' '~' '$' ''' '</>' '<\>' '<|>'
		'<_>' '<->' '< >' '#' ID NUM

prechigh
	nonassoc UMINUS
	left '*' '/' '%'
	left '+' '-'
	nonassoc '^'
	left '/\'
	left '\/'
	nonassoc '''
	nonassoc '$'
	left '&' '~''
	nonassoc '<' '<=' '>' '>='
	nonassoc '=' '/='

rule
	S	:	'{' D '|' C '}' 
		|	'{' C '}'

	D	:	'%' I 
		|	'!' I
		|	'@' I
		|	D D

	I	:	ID I
		| 	ID

	C 	: 	ID '=' Ea
		|	ID '=' Eb
		|	ID '=' Ec
		| 	ID '=' ID
		| 	S
		|	'read' ID
		| 	'write' ID
		|	Cond
		|	It
		|	C ';' C

	Cond:	'(' Eb '?' C ')'
		|	'(' Eb '?' C ':' C ')'

	It	: 	'[' Eb '|' C ']'
		|	'[' Ea '..' Ea '|' C ']'
		|	'[' ID ':' Ea '..' Ea '|' C ']'

	Ea	:	Ea '+' Ea
		|	Ea '-' Ea
		|	Ea '*' Ea
		|	Ea '/' Ea
		|	Ea '%' Ea
		|	'-' Ea	=UMINUS
		|	'(' Ea ')'
		|	ID
		|	NUM

	Eb	:	Eb '/\' Eb
		|	Eb '\/' Eb
		|	Eb '^'
		| 	'(' Eb ')'
		|	ID
		|	'true'
		|	'false'
		|	Ea '<' Ea
		|	Ea '<=' Ea
		|	Ea '>' Ea
		|	Ea '>=' Ea
		|	Ea '=' Ea
		|	Ea '/=' Ea
		|	Eb '=' Eb
		|	Eb '/=' Eb
		|	Ec '=' Ec
		|	Ec '/=' Ec

	Ec	:	Ec '&' Ec
		|	Ec '~' Ec
		|	'$' Ec
		|	Ec '''
		| 	'(' Ec ')'
		|	'</>'
		|	'<\>'
		|	'<|>'
		|	'<_>'
		|	'<->' 
		|	'< >'
		|	'#'

end