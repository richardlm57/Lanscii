# Archivo con la sintaxis del parser en RACC
# Richard Lares 11-10508
# Oscar Guillén 11-11264

class Parser

# Símbolos terminales de la gramática
token 	LCURLY PIPE RCURLY PERCENTAGE EXCLAMATIONMARK AT EQUALS READ WRITE SEMICOLON 
		LPARENTHESIS QUESTIONMARK RPARENTHESIS COLON LSQUARE RSQUARE DOUBLEDOT PLUS MINUS TIMES DIVIDE 
		AND OR NOT TRUE FALSE LESS LESSEQUAL GREATER GREATEREQUAL NOTEQUAL AMPERSAND TILDE DOLLAR 
		APOSTROPHE CANVAS EMPTYCANVAS ID NUM UMINUS PARENTHESIS

# Precedencias de los símbolos
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

# Símbolo inicial
start PROGRAM

# Reglas de la gramática
rule
	PROGRAM
		:	LCURLY DECLARE PIPE BODY RCURLY		{return PROGRAM_DECLARE_BODY.new(val[0],val[1],val[3])}
		|	LCURLY BODY RCURLY					{return PROGRAM_BODY.new(val[1])}

		# Tipos de las declaraciones
	DECLARE	
		:	PERCENTAGE IDENTS					{result = DECLARE_INT.new(val[1])}
		|	EXCLAMATIONMARK IDENTS				{result = DECLARE_BOOL.new(val[1])}
		|	AT IDENTS							{result = DECLARE_LIE.new(val[1])}

		# Maneras de declarar
	IDENTS	
		:	ID IDENTS							{result = MORE_IDENTS.new(val[0],val[1])}
		|	ID DECLARE 							{result = IDENTS_DECLARE.new(val[0],val[1])}
		| 	ID 									{result = IDENTS_ID.new(val[0])}

		# Cuerpo del programa / Instrucciones
	BODY 	
		: 	ID EQUALS EXPR			{result = BODY_ASSIGN.new(val[0],val[2])}
		| 	PROGRAM 				{result = BODY.new(val[0])}
		|	READ ID 				{result = BODY_READ.new(val[1]) }
		| 	WRITE EXPR				{result = BODY_WRITE.new(val[1]) }
		|	COND					{result = BODY.new(val[0])}
		|	ITER					{result = BODY.new(val[0])}
		|	BODY SEMICOLON BODY     {result = BODIES.new(val[0],val[2])}

		# Condicionales
	COND
		:	LPARENTHESIS EXPR QUESTIONMARK BODY RPARENTHESIS   {result = IF_THEN.new(val[1],val[3])}
		|	LPARENTHESIS EXPR QUESTIONMARK BODY COLON BODY RPARENTHESIS   {result = IF_THEN_ELSE.new(val[1],val[3],val[5])}

		# Ciclos
	ITER	
		: 	LSQUARE EXPR PIPE BODY RSQUARE       {result = ONE_COND_ITER.new(val[1],val[3])}
		|	LSQUARE EXPR DOUBLEDOT EXPR PIPE BODY RSQUARE {result = ITER.new(val[1],val[3],val[5])}
		|	LSQUARE ID COLON EXPR DOUBLEDOT EXPR PIPE BODY RSQUARE {result = ID_ITER.new(val[1],val[3],val[5],val[7])}

		# Expresiones
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

# Clase para los errores sintácticos
class SyntacticError < RuntimeError

  def initialize(tok)
    @token = tok
  end

  def to_s
    "Lanscii Parsing Error: Syntactic error of token '#{@token[0]}' at line '#{@token[1]}', column '#{@token[2]}'"   
  end
end

def parse(t)
	@lexer=t
	do_parse
end

def next_token
	@lexer.shift
end

def on_error(id, token, stack)
	raise SyntacticError::new(token)
end