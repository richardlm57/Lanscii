class Parser

token 	LCURLY PIPE RCURLY PERCENTAGE EXCLAMATIONMARK AT EQUALS READ WRITE SEMICOLON 
		LPARENTHESIS QUESTIONMARK RPARENTHESIS COLON LSQUARE RSQUARE DOUBLEDOT PLUS MINUS TIMES DIVIDE 
		AND OR NOT TRUE FALSE LESS LESSEQUAL GREATER GREATEREQUAL NOTEQUAL AMPERSAND TILDE DOLLAR 
		APOSTROPHE CANVAS EMPTYCANVAS ID NUM UMINUS PARENTHESIS

prechigh
	nonassoc PARENTHESIS
	left SEMICOLON
	right QUESTIONMARK COLON
	nonassoc UMINUS
	left TIMES DIVIDE PERCENTAGE
	left PLUS MINUS
	nonassoc NOT
	left AND
	left OR
	nonassoc APOSTROPHE
	nonassoc DOLLAR
	left AMPERSAND TILDE
	right EQUALS NOTEQUAL
	nonassoc LESS LESSEQUAL GREATER GREATEREQUAL
		
preclow

start PROGRAM

rule
	PROGRAM
		:	LCURLY DECLARE PIPE BODY RCURLY		{return PROGRAM_DECLARE_BODY.new(val[1],val[3])}
		|	LCURLY BODY RCURLY					{return PROGRAM_BODY.new(val[1])}

	DECLARE	
		:	PERCENTAGE IDENTS					{result = DECLARE_INT.new(val[1])}
		|	EXCLAMATIONMARK IDENTS				{result = DECLARE_BOOL.new(val[1])}
		|	AT IDENTS							{result = DECLARE_LIE.new(val[1])}

	IDENTS	
		:	ID IDENTS							{result = MORE_IDENTS.new(val[0],val[1])}
		|	ID DECLARE 							{result = IDENTS_DECLARE.new(val[0],val[1])}
		| 	ID 									{result = IDENTS_ID.new(val[0])}

	BODY 	
		: 	ID EQUALS EXPR			{result = BODY_ASSIGN.new(val[0],val[2])}
		| 	PROGRAM 				{result = BODY.new(val[0])}
		|	READ ID 				{result = BODY_READ.new(val[1]) }
		| 	WRITE EXPR				{result = BODY_WRITE.new(val[1]) }
		|	COND					{result = BODY.new(val[0])}
		|	ITER					{result = BODY.new(val[0])}
		|	BODY SEMICOLON BODY     {result = BODIES.new(val[0],val[2])}

	COND
		:	LPARENTHESIS EXPR QUESTIONMARK BODY RPARENTHESIS   {result = IF_THEN.new(val[1],val[3])}
		|	LPARENTHESIS EXPR QUESTIONMARK BODY COLON BODY RPARENTHESIS   {result = IF_THEN_ELSE.new(val[1],val[3],val[5])}

	ITER	
		: 	LSQUARE EXPR PIPE BODY RSQUARE       {result = ONE_COND_ITER.new(val[1],val[3])}
		|	LSQUARE EXPR DOUBLEDOT EXPR PIPE BODY RSQUARE {result = ITER.new(val[1],val[3],val[5])}
		|	LSQUARE ID COLON EXPR DOUBLEDOT EXPR PIPE BODY RSQUARE {result = ID_ITER.new(val[1],val[3],val[5],val[7])}

	EXPR	
		:	ID 						{result = EXP_ID.new(val[0])}
		|	NUM						{result = EXP_NUM.new(val[0])}
		|	EXPR PLUS EXPR          {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR MINUS EXPR         {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR TIMES EXPR         {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR DIVIDE EXPR        {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR PERCENTAGE EXPR    {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	MINUS EXPR	=UMINUS		{result = RIGHT_EXP.new(val[0],val[1])}
		|	LPARENTHESIS EXPR RPARENTHESIS =PARENTHESIS	{result = EXP.new(val[1])}
		|	EXPR AND EXPR           {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR OR EXPR            {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR NOT                {result = LEFT_EXP.new(val[0],val[1])}
		|	TRUE					{result = EXP_BOOL.new(val[0])}
		|	FALSE					{result = EXP_BOOL.new(val[0])}
		|	EXPR LESS EXPR          {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR LESSEQUAL EXPR     {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR GREATER EXPR		{result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR GREATEREQUAL EXPR  {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR EQUALS EXPR        {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR NOTEQUAL EXPR      {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR AMPERSAND EXPR     {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	EXPR TILDE EXPR         {result = DOUBLE_EXP.new(val[0],val[1],val[2])}
		|	DOLLAR EXPR         	{result = RIGHT_EXP.new(val[0],val[1])} 
		|	EXPR APOSTROPHE			{result = LEFT_EXP.new(val[0],val[1])}
		|	CANVAS					{result = EXP_CANVAS.new(val[0])}
		|	EMPTYCANVAS				{result = EXP_CANVAS.new(val[0])}

end

---- inner ----

def parse(t)
	@lexer=t
	do_parse
end

def next_token
	@lexer.shift
end