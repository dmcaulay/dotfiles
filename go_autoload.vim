""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#go#OpenTestAlternate()
  let new_file = ftplugin#go#AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! ftplugin#go#AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_test = match(current_file, '_test.go') != -1
  let going_to_test = !in_test
  if going_to_test
    let new_file = substitute(new_file, '\.go$', '_test.go', '')
  else
    let new_file = substitute(new_file, '_test\.go$', '.go', '')
  endif
  return new_file
endfunction
