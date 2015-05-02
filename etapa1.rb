=begin

	@title	Anlisis Lexicográfico

	@author	Richard Lares 11-10508
	@author	Oscar Guillen 11-11264

	@description

=end

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
				"+"=>"PLUS","-"=>"MINUS","*"=>"TIMES","/"=>"DIVIDE",
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
	s=x.split
	print s
	s.each do |t|
		puts "\nsplit"
		puts t
		m=t.match(/\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >|\/\\|\\\/|<=|>=
				|([A-Z]|[a-z]|\_)([A-Z]|[a-z]|_|[0-9])*|[0-9]+
				|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\+|-|\*|\/|\^|<|>
				|#|\$|'|true|false/)
		if m == nil
			m=t.match(/[0-9]+/)
		end
		while m do
			puts "match"
			puts m[0]
			puts "postmatch"
			puts m.post_match
			if m[0] =~ /\/\\|\\\/|<=|>=|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)
				|\+|-|\*|\/|\^|<|>|#|\$|'|true|false/
				correct_program.push("token "+strings_dic[m[0]]+" value ("+m[0]+") at line: "+i.to_s+", column: "+j.to_s)

			elsif m[0] =~ /([A-Z]|[a-z]|\_)([A-Z]|[a-z]|_|[0-9])*/
				correct_program.push("token IDENTIFIER value ("+m[0]+") at line: "+i.to_s+", column: "+j.to_s)

			elsif m[0] =~ /[0-9]+/
				correct_program.push("token NUMBER value ("+m[0]+") at line: "+i.to_s+", column: "+j.to_s)


			elsif m[0] =~ /\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >/
				puts "wait"

			else
				puts "wait again"
			end

			j+=m[0].size
			temp=m.post_match
			m=temp.match(/\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >|\/\\|\\\/|<=|>=
				|([A-Z]|[a-z]|\_)([A-Z]|[a-z]|_|[0-9])*|[0-9]+
				|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\+|-|\*|\/|\^|<|>
				|#|\$|'|true|false/)
		end
	end
	i+=1	
end
puts correct_program