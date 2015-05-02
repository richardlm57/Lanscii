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
incorrect=false
i=1
content.each_line do |x|

	j=0	
	s=x.split
	#print s
	s.each do |t|
		#puts "\nsplit"
		#puts t
		while x[j]!=t[0] do
			j+=1
		end
		m=t.match(/\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >|\/\\|\\\/|<=|>=|
				|([A-Z]|[a-z]|_)([A-Z]|[a-z]|_|[0-9])*|[0-9]+|
				|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\+|-|\*|\/|\^|<|>|
				|#|\$|'|true|false/)

		if m == nil
			incorrect = true
			incorrect_program.push("Error: Unexpected character: \""+t+"\" at line: "+i.to_s+", column: "+(j+1).to_s)
		else
			if (n=m.pre_match.match(/\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >|\/\\|\\\/|<=|>=|
				|([A-Z]|[a-z]|_)([A-Z]|[a-z]|_|[0-9])*|[0-9]+|
				|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\+|-|\*|\/|\^|<|>|
				|#|\$|'|true|false/) == nil) && (m.pre_match != "")
				incorrect= true
				incorrect_program.push("Error: Unexpected character: \""+m.pre_match+"\" at line: "+i.to_s+", column: "+(j+1).to_s)
			end
		end
		while m do
			#puts "match"
			#puts m[0]
			#puts "postmatch"
			#puts m.post_match
			if m[0] =~ /\/\\|\\\/|<=|>=|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|
				|\+|-|\*|\/|\^|<|>|#|\$|'|true|false/
				correct_program.push("token "+strings_dic[m[0]]+" value ("+m[0]+") at line: "+i.to_s+", column: "+(j+1).to_s)
				j+=m[0].size

			elsif m[0] =~ /([A-Z]|[a-z]|_)([A-Z]|[a-z]|_|[0-9])*/
				correct_program.push("token IDENTIFIER value ("+m[0]+") at line: "+i.to_s+", column: "+(j+1).to_s)
				j+=m[0].size

			elsif m[0] =~ /[0-9]+/
				correct_program.push("token NUMBER value ("+m[0]+") at line: "+i.to_s+", column: "+(j+1).to_s)
				j+=m[0].size

			elsif m[0] =~ /\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >/
				#puts "wait"
				j+=m[0].size

			else
				#puts "wait again"
				j+=1
			end

			
			temp=m.post_match
			m=temp.match(/\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >|\/\\|\\\/|<=|>=|
				|([A-Z]|[a-z]|_)([A-Z]|[a-z]|_|[0-9])*|[0-9]+|
				|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\+|-|\*|\/|\^|<|>|
				|#|\$|'|true|false/)
			if m == nil
				if temp != ""
					incorrect = true
					incorrect_program.push("Error: Unexpected character: \""+temp+"\" at line: "+i.to_s+", column: "+j+1.to_s)
				end
			else
				if (n=m.pre_match.match(/\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >|\/\\|\\\/|<=|>=|
					|([A-Z]|[a-z]|_)([A-Z]|[a-z]|_|[0-9])*|[0-9]+|
					|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\+|-|\*|\/|\^|<|>|
					|#|\$|'|true|false/) == nil) && (m.pre_match != "")
					incorrect= true
					incorrect_program.push("Error: Unexpected character: \""+m.pre_match+"\" at line: "+i.to_s+", column: "+j+1.to_s)
				end
			end
		end
	end
	i+=1	
end
if incorrect
	puts incorrect_program
else
	puts correct_program
end