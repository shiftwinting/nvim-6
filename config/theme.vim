" >>> colorscheme
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

colorscheme hybrid_reverse
" hybrid material
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:hybrid_transparent_background = 1
let g:enable_bold_font = 0
let g:enable_italic_font = 1
" one
let g:one_allow_italics = 1

