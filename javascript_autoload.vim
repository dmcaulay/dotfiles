""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#javascript#OpenTestAlternate()
  let new_file = ftplugin#javascript#AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! ftplugin#javascript#AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_test = match(current_file, '^test/') != -1
  let going_to_test = !in_test
  if going_to_test
    let new_file = substitute(new_file, '\.coffee$', '-test.coffee', '')
    let new_file = substitute(new_file, '\.js$', '-test.js', '')
    let new_file = 'test/' . new_file
  else
    let new_file = substitute(new_file, '-test\.coffee$', '.coffee', '')
    let new_file = substitute(new_file, '-test\.js$', '.js', '')
    let new_file = substitute(new_file, '^test/', '', '')
  endif
  return new_file
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUN BIN FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#javascript#RunBin(filename)
    " Write the file and exec it using node
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    exec ":!node " . a:filename
endfunction

function! ftplugin#javascript#SetBinFile()
    " Set the spec file that tests will be run for.
    let t:grb_bin_file=@%
endfunction

function! ftplugin#javascript#RunBinFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let is_bin_file = match(expand("%"), '^bin\/') != -1
    if is_bin_file
        call ftplugin#javascript#SetBinFile()
    elseif !exists("t:grb_bin_file")
        return
    end
    call ftplugin#javascript#RunBin(t:grb_bin_file . command_suffix)
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#javascript#RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!bin/features " . a:filename
    else
        exec ":!node_modules/mocha/bin/mocha " . a:filename . ' -C'
    end
endfunction

function! ftplugin#javascript#SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! ftplugin#javascript#RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|-test.coffee\|-test.js\)$') != -1
    if in_test_file
        call ftplugin#javascript#SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call ftplugin#javascript#RunTests(t:grb_test_file . command_suffix)
endfunction

function! ftplugin#javascript#RunNearestTest()
    let test_line_number = line('.')
    call ftplugin#javascript#RunTestFile(":" . test_line_number . " -b")
endfunction
