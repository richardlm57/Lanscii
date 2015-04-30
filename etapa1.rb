name = ARGV[0]
file = File.open(name,"r")
content = file.read
file.close
string = "token LCURLY value ({) at line: 3, column: 1"
strings_dic = {"{"=>"LCURLY","}"=>"RCURLY","|"=>"PIPE","%"=>"PERCENTAGE","!"=>"EXCLAMATION MARK",
				"@"=>"AT","</>"=>"CANVAS","<\\>"=>"CANVAS","<|>"=>"CANVAS",
				"<_>"=>"CANVAS","<->"=>"CANVAS","="=>"EQUALS",";"=>"SEMICOLON",
				"read"=>"READ","write"=>"WRITE","?"=>"QUESTION MARK",
				":"=>"COLON","("=>"LPARENTHESIS",")"=>"RPARENTHESIS",
				"\d"=>"NUMBER","+"=>"PLUS","-"=>"MINUS","*"=>"TIMES","/"=>"DIVIDE",
				"\/\\"=>"AND","\\\/"=>"OR","^"=>"NOT","<"=>"LESS","<="=>"LESS EQUAL",
				">"=>"GREATER",">="=>"GREATER EQUAL",
				"\/="=>"NOTEQUAL","#"=>"EMPTYCANVAS","$"=>"DOLLAR","'"=>"APOSTROPHE","true"=>"TRUE",
				"false"=>"FALSE","{-"=>"LCOMMENT","-}"=>"RCOMMENT"}
correct_program=Array.new
incorrect_program=Array.new
variable_identifiers=Array.new
i=1
#string methods: each_char,match | matchdata methods: pre_match, post_match
content.each_line do |x|
	j=1	
	#Change order to recognize complex symbols first
	m=x.match(/\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >|\/\\|\\\/|<=|>=
			|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\d|\+|-|\*|\/|\^|<|>
			|#|\$|'|true|false/)
	while m do
		case m[0]
		when /\/\\|\\\/|<=|>=|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\d
			|\+|-|\*|\/|\^|<|>|#|\$|'|true|false/
			correct_program.push("token "+strings_dic[m[0]]+" value ("+m[0]+") at line: "+i.to_s+", column: "+j.to_s)
		when /\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >/
			puts "wait"
		else
			puts "wait again"
		end
		j+=m[0].size
		temp=m.post_match
		m=temp.match(/\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >|\/\\|\\\/|<=|>=
			|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\d|\+|-|\*|\/|\^|<|>
			|#|\$|'|true|false/)
	end
	i+=1	
end
puts correct_program