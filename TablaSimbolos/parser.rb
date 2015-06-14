#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.8
# from Racc grammer file "".
#

require 'racc/parser.rb'
class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 105)

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
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
     2,     6,     7,     8,    19,     2,    22,    11,    12,    69,
    15,    20,    11,    12,    16,    15,    20,     2,    25,    16,
     6,     7,     8,    20,    11,    12,     2,    15,    22,    99,
    22,    16,    26,    11,    12,    22,    15,     9,     2,    49,
    16,    20,     9,     2,    49,    11,    12,    92,    15,    68,
    11,    12,    16,    15,     9,    47,    48,    16,     2,    20,
    47,    48,    98,     9,    20,    11,    12,    18,    15,     2,
   102,    17,    16,     3,    49,     9,    11,    12,     2,    15,
     9,   nil,    93,    16,    49,   nil,   nil,    57,    45,    46,
    47,    48,    50,    51,    52,     9,   nil,   nil,    45,    46,
    47,    48,    50,    51,    52,    61,     9,    53,    54,    55,
    56,    58,    59,    60,    66,    61,    49,    20,   nil,    57,
    90,    91,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    67,
    45,    46,    47,    48,    50,    51,    52,   nil,    49,    53,
    54,    55,    56,    58,    59,    60,   100,    61,    49,   nil,
   nil,    57,    45,    46,    47,    48,    50,    51,    52,   nil,
   nil,   nil,    45,    46,    47,    48,    50,    51,    52,    61,
    49,    53,    54,    55,    56,    58,    59,    60,    49,    61,
   nil,    57,   nil,   nil,    45,    46,    47,    48,    50,   nil,
    52,   nil,    45,    46,    47,    48,    50,    51,    52,    49,
   nil,   -47,   -47,   -47,   -47,    58,    59,    60,    49,    61,
   nil,    57,   nil,    45,    46,    47,    48,    50,    51,    52,
   nil,   nil,    45,    46,    47,    48,    50,    51,    52,    49,
    61,   -47,   -47,   -47,   -47,    58,    59,    60,    49,    61,
   nil,    57,   nil,    45,    46,    47,    48,   nil,   nil,    52,
   nil,   nil,    45,    46,    47,    48,    50,    51,    52,   nil,
   nil,   -47,   -47,   -47,   -47,    58,    59,    60,    49,    61,
   nil,    57,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    94,    45,    46,    47,    48,    50,    51,    52,   nil,
   nil,    53,    54,    55,    56,    58,    59,    60,    49,    61,
   nil,    57,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    45,    46,    47,    48,    50,    51,    52,   nil,
   nil,   -47,   -47,   -47,   -47,    58,    59,    60,    49,    61,
   nil,    57,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    45,    46,    47,    48,    50,    51,    52,    49,
   nil,   nil,    57,   nil,   nil,    58,    59,    60,   nil,    61,
   nil,   nil,   nil,    45,    46,    47,    48,    50,    51,    52,
    49,   nil,   nil,    57,   nil,   nil,    58,    59,    60,    85,
    61,   nil,   nil,   nil,    45,    46,    47,    48,    50,    51,
    52,   nil,   nil,    53,    54,    55,    56,    58,    59,    60,
    49,    61,   nil,    57,   nil,   nil,   nil,   nil,    65,   nil,
   nil,   nil,   nil,   nil,    45,    46,    47,    48,    50,    51,
    52,   nil,   nil,    53,    54,    55,    56,    58,    59,    60,
    49,    61,   nil,    57,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    45,    46,    47,    48,    50,    51,
    52,   nil,   nil,    53,    54,    55,    56,    58,    59,    60,
    49,    61,   nil,    57,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    45,    46,    47,    48,    50,    51,
    52,   nil,    31,    53,    54,    55,    56,    58,    59,    60,
    30,    61,   nil,   nil,   nil,   nil,    32,    33,    31,   nil,
   nil,   nil,   nil,   nil,   nil,    34,    30,    35,    36,    28,
    29,   nil,    32,    33,    31,   nil,   nil,   nil,   nil,   nil,
   nil,    34,    30,    35,    36,    28,    29,   nil,    32,    33,
    31,   nil,   nil,   nil,   nil,   nil,   nil,    34,    30,    35,
    36,    28,    29,   nil,    32,    33,    31,   nil,   nil,   nil,
   nil,   nil,   nil,    34,    30,    35,    36,    28,    29,   nil,
    32,    33,    31,   nil,   nil,   nil,   nil,   nil,   nil,    34,
    30,    35,    36,    28,    29,   nil,    32,    33,    31,   nil,
   nil,   nil,   nil,   nil,   nil,    34,    30,    35,    36,    28,
    29,   nil,    32,    33,    31,   nil,   nil,   nil,   nil,   nil,
   nil,    34,    30,    35,    36,    28,    29,   nil,    32,    33,
    31,   nil,   nil,   nil,   nil,   nil,   nil,    34,    30,    35,
    36,    28,    29,   nil,    32,    33,    31,   nil,   nil,   nil,
   nil,   nil,   nil,    34,    30,    35,    36,    28,    29,   nil,
    32,    33,    31,   nil,   nil,   nil,   nil,   nil,   nil,    34,
    30,    35,    36,    28,    29,   nil,    32,    33,    31,   nil,
   nil,   nil,   nil,   nil,   nil,    34,    30,    35,    36,    28,
    29,   nil,    32,    33,    31,   nil,   nil,   nil,   nil,   nil,
   nil,    34,    30,    35,    36,    28,    29,   nil,    32,    33,
    31,   nil,   nil,   nil,   nil,   nil,   nil,    34,    30,    35,
    36,    28,    29,   nil,    32,    33,    31,   nil,   nil,   nil,
   nil,   nil,   nil,    34,    30,    35,    36,    28,    29,   nil,
    32,    33,    31,   nil,   nil,   nil,   nil,   nil,   nil,    34,
    30,    35,    36,    28,    29,   nil,    32,    33,    31,   nil,
   nil,   nil,   nil,   nil,   nil,    34,    30,    35,    36,    28,
    29,   nil,    32,    33,    31,   nil,   nil,   nil,   nil,   nil,
   nil,    34,    30,    35,    36,    39,    29,   nil,    32,    33,
    31,   nil,   nil,   nil,   nil,   nil,   nil,    34,    30,    35,
    36,    28,    29,   nil,    32,    33,    31,   nil,   nil,   nil,
   nil,   nil,   nil,    34,    30,    35,    36,    28,    29,   nil,
    32,    33,    31,   nil,   nil,   nil,   nil,   nil,   nil,    34,
    30,    35,    36,    28,    29,   nil,    32,    33,    31,   nil,
   nil,   nil,   nil,   nil,   nil,    34,    30,    35,    36,    28,
    29,   nil,    32,    33,    31,   nil,   nil,   nil,   nil,   nil,
   nil,    34,    30,    35,    36,    28,    29,   nil,    32,    33,
    31,   nil,   nil,   nil,   nil,   nil,   nil,    34,    30,    35,
    36,    28,    29,   nil,    32,    33,    31,   nil,   nil,   nil,
   nil,   nil,   nil,    34,    30,    35,    36,    28,    29,   nil,
    32,    33,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    34,
   nil,    35,    36,    28,    29 ]

racc_action_check = [
   100,    22,    22,    22,     5,    20,     6,   100,   100,    40,
   100,     5,    20,    20,   100,    20,    40,     2,     9,    20,
     2,     2,     2,    96,     2,     2,    91,     2,     8,    96,
     7,     2,    11,    91,    91,    22,    91,   100,    65,    71,
    91,    87,    20,    66,    70,    65,    65,    87,    65,    39,
    66,    66,    65,    66,     2,    71,    71,    66,    93,    95,
    70,    70,    95,    91,   101,    93,    93,     4,    93,    18,
   101,     3,    93,     1,    84,    65,    18,    18,     0,    18,
    66,   nil,    88,    18,    88,   nil,   nil,    88,    84,    84,
    84,    84,    84,    84,    84,    93,   nil,   nil,    88,    88,
    88,    88,    88,    88,    88,    84,    18,    88,    88,    88,
    88,    88,    88,    88,    38,    88,    38,    86,   nil,    38,
    86,    86,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    38,
    38,    38,    38,    38,    38,    38,    38,   nil,    64,    38,
    38,    38,    38,    38,    38,    38,    97,    38,    97,   nil,
   nil,    97,    64,    64,    64,    64,    64,    64,    64,   nil,
   nil,   nil,    97,    97,    97,    97,    97,    97,    97,    64,
    76,    97,    97,    97,    97,    97,    97,    97,    78,    97,
   nil,    78,   nil,   nil,    76,    76,    76,    76,    76,   nil,
    76,   nil,    78,    78,    78,    78,    78,    78,    78,    83,
   nil,    78,    78,    78,    78,    78,    78,    78,    77,    78,
   nil,    77,   nil,    83,    83,    83,    83,    83,    83,    83,
   nil,   nil,    77,    77,    77,    77,    77,    77,    77,    75,
    83,    77,    77,    77,    77,    77,    77,    77,    79,    77,
   nil,    79,   nil,    75,    75,    75,    75,   nil,   nil,    75,
   nil,   nil,    79,    79,    79,    79,    79,    79,    79,   nil,
   nil,    79,    79,    79,    79,    79,    79,    79,    89,    79,
   nil,    89,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    89,    89,    89,    89,    89,    89,    89,    89,   nil,
   nil,    89,    89,    89,    89,    89,    89,    89,    80,    89,
   nil,    80,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    80,    80,    80,    80,    80,    80,    80,   nil,
   nil,    80,    80,    80,    80,    80,    80,    80,    81,    80,
   nil,    81,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    81,    81,    81,    81,    81,    81,    81,    82,
   nil,   nil,    82,   nil,   nil,    81,    81,    81,   nil,    81,
   nil,   nil,   nil,    82,    82,    82,    82,    82,    82,    82,
    63,   nil,   nil,    63,   nil,   nil,    82,    82,    82,    63,
    82,   nil,   nil,   nil,    63,    63,    63,    63,    63,    63,
    63,   nil,   nil,    63,    63,    63,    63,    63,    63,    63,
    37,    63,   nil,    37,   nil,   nil,   nil,   nil,    37,   nil,
   nil,   nil,   nil,   nil,    37,    37,    37,    37,    37,    37,
    37,   nil,   nil,    37,    37,    37,    37,    37,    37,    37,
    27,    37,   nil,    27,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    27,    27,    27,    27,    27,    27,
    27,   nil,   nil,    27,    27,    27,    27,    27,    27,    27,
    44,    27,   nil,    44,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    44,    44,    44,    44,    44,    44,
    44,   nil,    47,    44,    44,    44,    44,    44,    44,    44,
    47,    44,   nil,   nil,   nil,   nil,    47,    47,    45,   nil,
   nil,   nil,   nil,   nil,   nil,    47,    45,    47,    47,    47,
    47,   nil,    45,    45,    46,   nil,   nil,   nil,   nil,   nil,
   nil,    45,    46,    45,    45,    45,    45,   nil,    46,    46,
    94,   nil,   nil,   nil,   nil,   nil,   nil,    46,    94,    46,
    46,    46,    46,   nil,    94,    94,    48,   nil,   nil,   nil,
   nil,   nil,   nil,    94,    48,    94,    94,    94,    94,   nil,
    48,    48,    49,   nil,   nil,   nil,   nil,   nil,   nil,    48,
    49,    48,    48,    48,    48,   nil,    49,    49,    50,   nil,
   nil,   nil,   nil,   nil,   nil,    49,    50,    49,    49,    49,
    49,   nil,    50,    50,    51,   nil,   nil,   nil,   nil,   nil,
   nil,    50,    51,    50,    50,    50,    50,   nil,    51,    51,
    53,   nil,   nil,   nil,   nil,   nil,   nil,    51,    53,    51,
    51,    51,    51,   nil,    53,    53,    54,   nil,   nil,   nil,
   nil,   nil,   nil,    53,    54,    53,    53,    53,    53,   nil,
    54,    54,    55,   nil,   nil,   nil,   nil,   nil,   nil,    54,
    55,    54,    54,    54,    54,   nil,    55,    55,    56,   nil,
   nil,   nil,   nil,   nil,   nil,    55,    56,    55,    55,    55,
    55,   nil,    56,    56,    57,   nil,   nil,   nil,   nil,   nil,
   nil,    56,    57,    56,    56,    56,    56,   nil,    57,    57,
    58,   nil,   nil,   nil,   nil,   nil,   nil,    57,    58,    57,
    57,    57,    57,   nil,    58,    58,    59,   nil,   nil,   nil,
   nil,   nil,   nil,    58,    59,    58,    58,    58,    58,   nil,
    59,    59,    60,   nil,   nil,   nil,   nil,   nil,   nil,    59,
    60,    59,    59,    59,    59,   nil,    60,    60,    16,   nil,
   nil,   nil,   nil,   nil,   nil,    60,    16,    60,    60,    60,
    60,   nil,    16,    16,    31,   nil,   nil,   nil,   nil,   nil,
   nil,    16,    31,    16,    16,    16,    16,   nil,    31,    31,
    30,   nil,   nil,   nil,   nil,   nil,   nil,    31,    30,    31,
    31,    31,    31,   nil,    30,    30,    25,   nil,   nil,   nil,
   nil,   nil,   nil,    30,    25,    30,    30,    30,    30,   nil,
    25,    25,    67,   nil,   nil,   nil,   nil,   nil,   nil,    25,
    67,    25,    25,    25,    25,   nil,    67,    67,    68,   nil,
   nil,   nil,   nil,   nil,   nil,    67,    68,    67,    67,    67,
    67,   nil,    68,    68,    12,   nil,   nil,   nil,   nil,   nil,
   nil,    68,    12,    68,    68,    68,    68,   nil,    12,    12,
    15,   nil,   nil,   nil,   nil,   nil,   nil,    12,    15,    12,
    12,    12,    12,   nil,    15,    15,    34,   nil,   nil,   nil,
   nil,   nil,   nil,    15,    34,    15,    15,    15,    15,   nil,
    34,    34,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    34,
   nil,    34,    34,    34,    34 ]

racc_action_pointer = [
    76,    73,    15,    71,    64,     0,   -33,    -9,   -11,    10,
   nil,    -7,   822,   nil,   nil,   838,   726,   nil,    67,   nil,
     3,   nil,    -4,   nil,   nil,   774,   nil,   425,   nil,   nil,
   758,   742,   nil,   nil,   854,   nil,   nil,   395,   111,    34,
     5,   nil,   nil,   nil,   455,   486,   502,   470,   534,   550,
   566,   582,   nil,   598,   614,   630,   646,   662,   678,   694,
   710,   nil,   nil,   365,   133,    36,    41,   790,   806,   nil,
    39,    34,   nil,   nil,   nil,   224,   165,   203,   173,   233,
   293,   323,   344,   194,    69,   nil,   106,    30,    79,   263,
   nil,    24,   nil,    56,   518,    48,    12,   143,   nil,   nil,
    -2,    53,   nil ]

racc_action_default = [
   -47,   -47,   -47,   -47,   -47,   -47,   -47,   -47,   -47,   -47,
   -10,   -47,   -47,   -13,   -14,   -47,   -47,   103,   -47,    -2,
   -47,    -3,    -8,    -4,    -5,   -47,   -11,   -12,   -21,   -22,
   -47,   -47,   -33,   -34,   -47,   -45,   -46,   -47,   -47,   -21,
   -47,   -15,    -6,    -7,    -9,   -47,   -47,   -47,   -47,   -47,
   -47,   -47,   -32,   -47,   -47,   -47,   -47,   -47,   -47,   -47,
   -47,   -44,   -28,   -47,   -43,   -47,   -47,   -47,   -47,    -1,
   -23,   -24,   -25,   -26,   -27,   -30,   -31,   -35,   -36,   -37,
   -38,   -39,   -40,   -41,   -42,   -29,   -47,   -47,   -47,   -47,
   -16,   -47,   -18,   -47,   -47,   -47,   -47,   -47,   -17,   -19,
   -47,   -47,   -20 ]

racc_goto_table = [
     5,    27,     4,     1,    37,    38,   nil,   nil,    21,    23,
    24,   nil,   nil,   nil,    44,   nil,    40,   nil,    41,    62,
    63,   nil,    43,    64,    42,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    70,    71,    72,    73,    74,    75,
    76,   nil,    77,    78,    79,    80,    81,    82,    83,    84,
   nil,   nil,   nil,   nil,   nil,   nil,    88,    89,   nil,   nil,
   nil,   nil,   nil,    86,    87,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    97,   nil,   nil,   nil,   nil,   nil,    95,
   nil,    96,   nil,   nil,   nil,   nil,   nil,   nil,   101 ]

racc_goto_check = [
     3,     5,     2,     1,     5,     5,   nil,   nil,     4,     4,
     4,   nil,   nil,   nil,     5,   nil,     3,   nil,     3,     5,
     5,   nil,     2,     5,     4,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,     5,     5,     5,     5,     5,     5,
     5,   nil,     5,     5,     5,     5,     5,     5,     5,     5,
   nil,   nil,   nil,   nil,   nil,   nil,     5,     5,   nil,   nil,
   nil,   nil,   nil,     3,     3,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,     5,   nil,   nil,   nil,   nil,   nil,     3,
   nil,     3,   nil,   nil,   nil,   nil,   nil,   nil,     3 ]

racc_goto_pointer = [
   nil,     3,     0,    -2,     2,   -11,   nil,   nil ]

racc_goto_default = [
   nil,    10,   nil,   nil,   nil,   nil,    13,    14 ]

racc_reduce_table = [
  0, 0, :racc_error,
  5, 44, :_reduce_1,
  3, 44, :_reduce_2,
  2, 45, :_reduce_3,
  2, 45, :_reduce_4,
  2, 45, :_reduce_5,
  2, 47, :_reduce_6,
  2, 47, :_reduce_7,
  1, 47, :_reduce_8,
  3, 46, :_reduce_9,
  1, 46, :_reduce_10,
  2, 46, :_reduce_11,
  2, 46, :_reduce_12,
  1, 46, :_reduce_13,
  1, 46, :_reduce_14,
  3, 46, :_reduce_15,
  5, 49, :_reduce_16,
  7, 49, :_reduce_17,
  5, 50, :_reduce_18,
  7, 50, :_reduce_19,
  9, 50, :_reduce_20,
  1, 48, :_reduce_21,
  1, 48, :_reduce_22,
  3, 48, :_reduce_23,
  3, 48, :_reduce_24,
  3, 48, :_reduce_25,
  3, 48, :_reduce_26,
  3, 48, :_reduce_27,
  2, 48, :_reduce_28,
  3, 48, :_reduce_29,
  3, 48, :_reduce_30,
  3, 48, :_reduce_31,
  2, 48, :_reduce_32,
  1, 48, :_reduce_33,
  1, 48, :_reduce_34,
  3, 48, :_reduce_35,
  3, 48, :_reduce_36,
  3, 48, :_reduce_37,
  3, 48, :_reduce_38,
  3, 48, :_reduce_39,
  3, 48, :_reduce_40,
  3, 48, :_reduce_41,
  3, 48, :_reduce_42,
  2, 48, :_reduce_43,
  2, 48, :_reduce_44,
  1, 48, :_reduce_45,
  1, 48, :_reduce_46 ]

racc_reduce_n = 47

racc_shift_n = 103

racc_token_table = {
  false => 0,
  :error => 1,
  :LCURLY => 2,
  :PIPE => 3,
  :RCURLY => 4,
  :PERCENTAGE => 5,
  :EXCLAMATIONMARK => 6,
  :AT => 7,
  :EQUALS => 8,
  :READ => 9,
  :WRITE => 10,
  :SEMICOLON => 11,
  :LPARENTHESIS => 12,
  :QUESTIONMARK => 13,
  :RPARENTHESIS => 14,
  :COLON => 15,
  :LSQUARE => 16,
  :RSQUARE => 17,
  :DOUBLEDOT => 18,
  :PLUS => 19,
  :MINUS => 20,
  :TIMES => 21,
  :DIVIDE => 22,
  :AND => 23,
  :OR => 24,
  :NOT => 25,
  :TRUE => 26,
  :FALSE => 27,
  :LESS => 28,
  :LESSEQUAL => 29,
  :GREATER => 30,
  :GREATEREQUAL => 31,
  :NOTEQUAL => 32,
  :AMPERSAND => 33,
  :TILDE => 34,
  :DOLLAR => 35,
  :APOSTROPHE => 36,
  :CANVAS => 37,
  :EMPTYCANVAS => 38,
  :ID => 39,
  :NUM => 40,
  :UMINUS => 41,
  :PARENTHESIS => 42 }

racc_nt_base = 43

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "LCURLY",
  "PIPE",
  "RCURLY",
  "PERCENTAGE",
  "EXCLAMATIONMARK",
  "AT",
  "EQUALS",
  "READ",
  "WRITE",
  "SEMICOLON",
  "LPARENTHESIS",
  "QUESTIONMARK",
  "RPARENTHESIS",
  "COLON",
  "LSQUARE",
  "RSQUARE",
  "DOUBLEDOT",
  "PLUS",
  "MINUS",
  "TIMES",
  "DIVIDE",
  "AND",
  "OR",
  "NOT",
  "TRUE",
  "FALSE",
  "LESS",
  "LESSEQUAL",
  "GREATER",
  "GREATEREQUAL",
  "NOTEQUAL",
  "AMPERSAND",
  "TILDE",
  "DOLLAR",
  "APOSTROPHE",
  "CANVAS",
  "EMPTYCANVAS",
  "ID",
  "NUM",
  "UMINUS",
  "PARENTHESIS",
  "$start",
  "PROGRAM",
  "DECLARE",
  "BODY",
  "IDENTS",
  "EXPR",
  "COND",
  "ITER" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'parser.y', 36)
  def _reduce_1(val, _values, result)
    return PROGRAM_DECLARE_BODY.new(val[1],val[3])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 37)
  def _reduce_2(val, _values, result)
    return PROGRAM_BODY.new(val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 41)
  def _reduce_3(val, _values, result)
    result = DECLARE_INT.new(val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 42)
  def _reduce_4(val, _values, result)
    result = DECLARE_BOOL.new(val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 43)
  def _reduce_5(val, _values, result)
    result = DECLARE_LIE.new(val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 47)
  def _reduce_6(val, _values, result)
    result = MORE_IDENTS.new(val[0],val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 48)
  def _reduce_7(val, _values, result)
    result = IDENTS_DECLARE.new(val[0],val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 49)
  def _reduce_8(val, _values, result)
    result = IDENTS_ID.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 53)
  def _reduce_9(val, _values, result)
    result = BODY_ASSIGN.new(val[0],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 54)
  def _reduce_10(val, _values, result)
    result = BODY.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 55)
  def _reduce_11(val, _values, result)
    result = BODY_READ.new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 56)
  def _reduce_12(val, _values, result)
    result = BODY_WRITE.new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 57)
  def _reduce_13(val, _values, result)
    result = BODY.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 58)
  def _reduce_14(val, _values, result)
    result = BODY.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 59)
  def _reduce_15(val, _values, result)
    result = BODIES.new(val[0],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 63)
  def _reduce_16(val, _values, result)
    result = IF_THEN.new(val[1],val[3])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 64)
  def _reduce_17(val, _values, result)
    result = IF_THEN_ELSE.new(val[1],val[3],val[5])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 68)
  def _reduce_18(val, _values, result)
    result = ONE_COND_ITER.new(val[1],val[3])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 69)
  def _reduce_19(val, _values, result)
    result = ITER.new(val[1],val[3],val[5])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 70)
  def _reduce_20(val, _values, result)
    result = ID_ITER.new(val[1],val[3],val[5],val[7])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 74)
  def _reduce_21(val, _values, result)
    result = EXP_ID.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 75)
  def _reduce_22(val, _values, result)
    result = EXP_NUM.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 76)
  def _reduce_23(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 77)
  def _reduce_24(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 78)
  def _reduce_25(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 79)
  def _reduce_26(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 80)
  def _reduce_27(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 81)
  def _reduce_28(val, _values, result)
    result = RIGHT_EXP.new(val[0],val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 82)
  def _reduce_29(val, _values, result)
    result = EXP.new(val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 83)
  def _reduce_30(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 84)
  def _reduce_31(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 85)
  def _reduce_32(val, _values, result)
    result = LEFT_EXP.new(val[0],val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 86)
  def _reduce_33(val, _values, result)
    result = EXP_BOOL.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 87)
  def _reduce_34(val, _values, result)
    result = EXP_BOOL.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 88)
  def _reduce_35(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 89)
  def _reduce_36(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 90)
  def _reduce_37(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 91)
  def _reduce_38(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 92)
  def _reduce_39(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 93)
  def _reduce_40(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 94)
  def _reduce_41(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 95)
  def _reduce_42(val, _values, result)
    result = DOUBLE_EXP.new(val[0],val[1],val[2])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 96)
  def _reduce_43(val, _values, result)
    result = RIGHT_EXP.new(val[0],val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 97)
  def _reduce_44(val, _values, result)
    result = LEFT_EXP.new(val[0],val[1])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 98)
  def _reduce_45(val, _values, result)
    result = EXP_CANVAS.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 99)
  def _reduce_46(val, _values, result)
    result = EXP_CANVAS.new(val[0])
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

end   # class Parser
