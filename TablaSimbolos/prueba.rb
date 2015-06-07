require './symboltable'

a=SymbolTable.new
a.insert("hola","holi")
a.insert("como","estas")
a.delete("como")
puts a.get_table
a.insert("como","estas")
a.update("como","nada")
puts a.contains("hla")
puts a.lookup("como")