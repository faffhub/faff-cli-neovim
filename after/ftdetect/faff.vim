" Detect Faff files in the Faff workspace
" Using 'set filetype=' to override built-in toml detection
" (placed in after/ftdetect/ to run after built-in detection)

" Match temporary files created by faff CLI (faff intent edit, etc.)
autocmd BufRead,BufNewFile *.faff.toml set filetype=faff

" Detect files in FAFF_DIR (defaults to ~/.faff if not set)
augroup faff_workspace_detect
  autocmd!
  autocmd BufRead,BufNewFile *.toml,*.json call s:DetectFaffWorkspaceFile()
augroup END

function! s:DetectFaffWorkspaceFile()
  " Determine FAFF_DIR: use $FAFF_DIR if set, otherwise default to ~/.faff
  let faff_dir = empty($FAFF_DIR) ? expand('~/.faff') : $FAFF_DIR

  " Normalize paths for comparison
  let faff_dir = fnamemodify(faff_dir, ':p')
  let current_file = expand('%:p')

  " Check if file is in logs/ or plans/ subdirectory of FAFF_DIR
  if current_file =~# '^' . escape(faff_dir, '/\') . 'logs/.*\.toml$'
    set filetype=faff
  elseif current_file =~# '^' . escape(faff_dir, '/\') . 'plans/.*\.\(toml\|json\)$'
    set filetype=faff
  endif
endfunction
