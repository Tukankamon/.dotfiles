{ config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    
    vialias = true;
    vimalias = true;
    vimdiffalias = true;

    plugins = [];

    #vimrc config
    extraconfig = ''
      set relativenumber
      set tabstop=8
      set autoindent
      set mouse=a

      set clipboard=unnamed

      exmap surround_wiki surround [[ ]]
      exmap surround_double_quotes surround " "
      exmap surround_single_quotes surround ' '
      exmap surround_backticks surround ` `
      exmap surround_brackets surround ( )
      exmap surround_square_brackets surround [ ]
      exmap surround_curly_brackets surround { }
      exmap surround_equals surround == ==

      map [[ :surround_wiki<cr>
      nunmap s
      vunmap s
      map s" :surround_double_quotes<cr>
      map s' :surround_single_quotes<cr>
      map s` :surround_backticks<cr>
      map sb :surround_brackets<cr>
      map s( :surround_brackets<cr>
      map s) :surround_brackets<cr>
      map s[ :surround_square_brackets<cr>
      map s] :surround_square_brackets<cr>
      map s{ :surround_curly_brackets<cr>
      map s} :surround_curly_brackets<cr>
      map s= :surround_equals<cr>
    '';
  };

}
