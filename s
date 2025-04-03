
NNAAMMEE
       read - read line of input into variables

SSYYNNOOPPSSIISS
       rreeaadd [_O_P_T_I_O_N_S] [_V_A_R_I_A_B_L_E ...]

DDEESSCCRRIIPPTTIIOONN
       NOTE: This page documents the fish builtin rreeaadd.  To see the documentation on any non-fish versions, use ccoommmmaanndd
       mmaann rreeaadd.

       rreeaadd  reads  from  standard  input and stores the result in shell variables. In an alternative mode, it can also
       print to its own standard output, for example for use in command substitutions.

       By default, rreeaadd reads a single line and splits it into variables on spaces or tabs. Alternatively, a null char‐
       acter or a maximum number of characters can be used to terminate the input, and other delimiters can be given.

       Unlike other shells, there is no default variable (such as RREEPPLLYY) for  storing  the  result  -  instead,  it  is
       printed on standard output.

       When  rreeaadd  reaches the end-of-file (EOF) instead of the terminator, the exit status is set to 1.  Otherwise, it
       is set to 0.

       If rreeaadd sets a variable and you don't specify a scope, it will use the same rules that _s_e_t _- _d_i_s_p_l_a_y _a_n_d  _c_h_a_n_g_e
       _s_h_e_l_l  _v_a_r_i_a_b_l_e_s does - if the variable exists, it will use it (in the lowest scope). If it doesn't, it will use
       an unexported function-scoped variable.

       The following options, like the corresponding ones in _s_e_t _- _d_i_s_p_l_a_y _a_n_d _c_h_a_n_g_e _s_h_e_l_l _v_a_r_i_a_b_l_e_s, control variable
       scope or attributes:

       --UU or ----uunniivveerrssaall
              Sets a universal variable.  The variable will be immediately available to all the user's  ffiisshh  instances
              on the machine, and will be persisted across restarts of the shell.

       --ff or ----ffuunnccttiioonn
              Sets a variable scoped to the executing function.  It is erased when the function ends.

       --ll or ----llooccaall
              Sets  a  locally-scoped  variable  in this block.  It is erased when the block ends.  Outside of a block,
              this is the same as ----ffuunnccttiioonn.

       --gg or ----gglloobbaall
              Sets a globally-scoped variable.  Global variables are available to all functions  running  in  the  same
              shell.  They can be modified or erased.

       --uu or ----uunneexxppoorrtt
              Prevents the variables from being exported to child processes (default behaviour).

       --xx or ----eexxppoorrtt
              Exports the variables to child processes.

       The following options control the interactive mode:

       --cc _C_M_D or ----ccoommmmaanndd _C_M_D
              Sets the initial string in the interactive mode command buffer to _C_M_D.

       --ss or ----ssiilleenntt
              Masks  characters  written  to  the  terminal,  replacing them with asterisks. This is useful for reading
              things like passwords or other sensitive information.

       --pp or ----pprroommpptt _P_R_O_M_P_T___C_M_D
              Uses the output of the shell command _P_R_O_M_P_T___C_M_D as the prompt  for  the  interactive  mode.  The  default
              prompt command is sseett__ccoolloorr ggrreeeenn;; eecchhoo --nn rreeaadd;; sseett__ccoolloorr nnoorrmmaall;; eecchhoo --nn "">> ""

       --PP or ----pprroommpptt--ssttrr _P_R_O_M_P_T___S_T_R
              Uses the literal _P_R_O_M_P_T___S_T_R as the prompt for the interactive mode.

       --RR or ----rriigghhtt--pprroommpptt _R_I_G_H_T___P_R_O_M_P_T___C_M_D
              Uses the output of the shell command _R_I_G_H_T___P_R_O_M_P_T___C_M_D as the right prompt for the interactive mode. There
              is no default right prompt command.

       --SS or ----sshheellll
              Enables  syntax  highlighting,  tab completions and command termination suitable for entering shellscript
              code in the interactive mode. NOTE: Prior to fish 3.0, the short opt for ----sshheellll was --ss, but it has  been
              changed for compatibility with bash's --ss short opt for ----ssiilleenntt.

       The following options control how much is read and how it is stored:

       --dd or ----ddeelliimmiitteerr _D_E_L_I_M_I_T_E_R
              Splits on _D_E_L_I_M_I_T_E_R. _D_E_L_I_M_I_T_E_R will be used as an entire string to split on, not a set of characters.

       --nn or ----nncchhaarrss _N_C_H_A_R_S
              Makes rreeaadd return after reading _N_C_H_A_R_S characters or the end of the line, whichever comes first.

       --tt -or ----ttookkeenniizzee
              Causes read to split the input into variables by the shell's tokenization rules. This means it will honor
              quotes  and  escaping. This option is of course incompatible with other options to control splitting like
              ----ddeelliimmiitteerr and does not honor _I_F_S (like fish's tokenizer). It saves the tokens in the manner  they'd  be
              passed  to commands on the commandline, so e.g. aa\\ bb is stored as aa bb. Note that currently it leaves com‐
              mand substitutions intact along with the parentheses.

       --aa or ----lliisstt
              Stores the result as a list in a single variable. This option is also available as ----aarrrraayy for  backwards
              compatibility.

       --zz or ----nnuullll
              Marks  the  end  of  the  line with the NUL character, instead of newline. This also disables interactive
              mode.

       --LL or ----lliinnee
              Reads each line into successive variables, and stops after each variable has been filled. This cannot  be
              combined with the ----ddeelliimmiitteerr option.

       Without  the  ----lliinnee  option,  rreeaadd reads a single line of input from standard input, breaks it into tokens, and
       then assigns one token to each variable specified in _V_A_R_I_A_B_L_E_S. If there are more  tokens  than  variables,  the
       complete remainder is assigned to the last variable.

       If no option to determine how to split like ----ddeelliimmiitteerr, ----lliinnee or ----ttookkeenniizzee is given, the variable IIFFSS is used
       as  a list of characters to split on. Relying on the use of IIFFSS is deprecated and this behaviour will be removed
       in future versions. The default value of IIFFSS contains space, tab and newline characters. As a special  case,  if
       IIFFSS is set to the empty string, each character of the input is considered a separate token.

       With  the  ----lliinnee  option,  rreeaadd reads a line of input from standard input into each provided variable, stopping
       when each variable has been filled. The line is not tokenized.

       If no variable names are provided, rreeaadd enters a special case that simply provides redirection from standard in‐
       put to standard output, useful for command substitution. For instance, the fish shell command below can be  used
       to read a password from the console instead of hardcoding it in the command itself, which prevents it from show‐
       ing up in fish's history:

          mysql -uuser -p(read)

       When  running  in  this mode, rreeaadd does not split the input in any way and text is redirected to standard output
       without any further processing or manipulation.

       If --ll or ----lliisstt is provided, only one variable name is allowed and the tokens are stored as a list in this vari‐
       able.

       In order to protect the shell from consuming too many system resources, rreeaadd will only consume a maximum of  100
       MiB  (104857600 bytes); if the terminator is not reached before this limit then _V_A_R_I_A_B_L_E is set to empty and the
       exit status is set to 122. This limit can be altered with the _f_i_s_h___r_e_a_d___l_i_m_i_t variable. If set to 0 (zero),  the
       limit is removed.

EEXXAAMMPPLLEE
       rreeaadd has a few separate uses.

       The following code stores the value 'hello' in the shell variable ffoooo.

          echo hello | read foo

       The _w_h_i_l_e command is a neat way to handle command output line-by-line:

          printf '%s\n' line1 line2 line3 line4 | while read -l foo
                            echo "This is another line: $foo"
                        end

       Delimiters given via "-d" are taken as one string:

          echo a==b==c | read -d == -l a b c
          echo $a # a
          echo $b # b
          echo $c # c

       ----ttookkeenniizzee honors quotes and escaping like the shell's argument passing:

          echo 'a\ b' | read -t first second
          echo $first # outputs "a b", $second is empty

          echo 'a"foo bar"b (command echo wurst)*" "{a,b}' | read -lt -l a b c
          echo $a # outputs 'afoo barb' (without the quotes)
          echo $b # outputs '(command echo wurst)* {a,b}' (without the quotes)
          echo $c # nothing

       For an example on interactive use, see _Q_u_e_r_y_i_n_g _f_o_r _u_s_e_r _i_n_p_u_t.
