""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#ruby#PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#ruby#OpenTestAlternate()
  let new_file = ftplugin#ruby#AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! ftplugin#ruby#AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<services\>') != -1 || match(current_file, '\<javascripts\>') != -1 || match(current_file, '\<helpers\>') != -1 || match(current_file, '\<finders\>') != -1 || match(current_file, '\<mailers\>') != -1 || match(current_file, '\<middleware\>') != -1 || match(current_file, '\<presenters\>') != -1 || match(current_file, '\<validators\>') != -1 || match(current_file, '\<workers\>') != -1


  let in_js = match(current_file, '/javascripts/') != -1
  let is_erb = match(current_file, '\.erb') != -1
  let going_to_spec = !in_spec
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    if in_js
      let new_file = substitute(new_file, '^assets/', '', '')
      let new_file = substitute(new_file, '\.js.coffee$', '_spec.js.coffee', '')
    else
      let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
      let new_file = substitute(new_file, '\.erb$', '.erb_spec.rb', '')
    endif
    let new_file = 'spec/' . new_file
  else
    if in_js
      let new_file = substitute(new_file, '_spec\.js.coffee$', '.js.coffee', '')
      let new_file = substitute(new_file, '^spec/', 'assets/', '')
    else
      if is_erb
        let new_file = substitute(new_file, '_spec\.rb$', '', '')
      else
        let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
      end
      let new_file = substitute(new_file, '^spec/', '', '')
    endif
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#ruby#RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if filereadable("script/test")
        exec ":!script/test " . a:filename
    elseif filereadable("Gemfile")
        exec ":!bin/rspec " . a:filename
    else
        exec ":!rspec " . a:filename
    end
endfunction

function! ftplugin#ruby#SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! ftplugin#ruby#RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(spec.js.coffee\|_spec.rb\)$') != -1
    if in_test_file
        call ftplugin#ruby#SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call ftplugin#ruby#RunTests(t:grb_test_file . command_suffix)
endfunction

function! ftplugin#ruby#RunNearestTest()
    let spec_line_number = line('.')
    call ftplugin#ruby#RunTestFile(" -l " . spec_line_number)
endfunction
