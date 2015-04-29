name = ARGV[0]
file = File.open(name,"r")
content = file.read
file.close
string = "token LCURLY value ({) at line: 3, column: 1"
strings_dic = {"{"=>"LCURLY","}"=>"RCURLY","%"=>"PERCENTAGE","!"=>"EXCLAMATION MARK",
				"@"=>"AT","/"=>"SLASH","\\"=>"BACKSLASH","|"=>"CANVAS",
				"_"=>"UNDERSCORE","-"=>"MINUS","="=>"EQUALS",";"=>"SEMICOLON",
				"read"=>"READ","write"=>"WRITE","?"=>"QUESTION MARK",
				":"=>"COLON","("=>"LPARENTHESIS",")"=>"RPARENTHESIS",
				"\d"=>"NUMBER","+"=>"PLUS","*"=>"TIMES","\/\\"=>"AND","\\\/"=>"OR",
				"^"=>"NOT","<"=>"LESS","<="=>"LESSEQUAL",">"=>"GREATER",">="=>"GREATEREQUAL",
				"\/="=>"NOTEQUAL","#"=>"EMPTYCANVAS",}
i=0
#string methods: echa_char,match | matchdata methods: pre_match, post_match
content.each_line do |x|
	#Change order to recognize complex symbols first
	x.match(/\{|\}|\%|\!|\@|\/|\\|\||\_|\-|\ |=|\;|read|write
			|\?|\:|\(|\)|\d|\+|\*|\/\\|\\\/|\^|\<|\<=|\>|\>=
			|\/=|\#|\$|\'|true|false|\{-|\}-|/)
	j=0	
	print x
	j+=1
	i+=1	
end
