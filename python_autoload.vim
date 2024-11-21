""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GET THE PYTHON PROJECT NAME
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#python#ProjectName()
  let name = system("grep 'name=' setup.py | head -n1 | cut -d '=' -f 2")
  let name = substitute(name, '-', '_', 'g')
  let name = substitute(name, '"', '', 'g')
  let name = substitute(name, ',', '', 'g')
  let name = substitute(name, '\n', '', 'g')
  " Check if name includes 'No such file or directory' and try pyproject.py
  if name =~ 'No such file or directory'
    let name = system("grep 'name =' pyproject.py | head -n1 | cut -d '=' -f 2")
    let name = substitute(name, '-', '_', 'g')
    let name = substitute(name, '"', '', 'g')
    let name = substitute(name, ',', '', 'g')
    let name = substitute(name, '\n', '', 'g')
  endif

  return name
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP + project dirs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#python#CtrlpProject(...)
  if a:0
    let prefix = a:1
  else
    let prefix = ""
  endif
  exec ":CtrlP " . ftplugin#python#ProjectName() . "/" . prefix
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#python#OpenTestAlternate()
  let new_file = ftplugin#python#AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! ftplugin#python#AlternateForCurrentFile()
  let project_name = ftplugin#python#ProjectName()
  let current_file = expand("%")
  let new_file = current_file
  let in_test = match(current_file, '/tests/') != -1
  let going_to_test = !in_test
  if going_to_test
    let new_file = substitute(new_file, '\/\(\w\{-}\.py$\)', '/test_\1', '')
    let new_file = substitute(new_file, '^' . project_name . '/', project_name . '/tests/', '')
  else
    let new_file = substitute(new_file, '\/test_\(\w\{-}\.py$\)', '/\1', '')
    let new_file = substitute(new_file, '^' . project_name . '/tests/', project_name . '/', '')
  endif
  return new_file
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUN BIN FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#python#RunBin(filename)
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

function! ftplugin#python#SetBinFile()
    " Set the spec file that tests will be run for.
    let t:grb_bin_file=@%
endfunction

function! ftplugin#python#RunBinFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let is_bin_file = match(expand("%"), '^bin\/') != -1
    if is_bin_file
        call ftplugin#python#SetBinFile()
    elseif !exists("t:grb_bin_file")
        return
    end
    call ftplugin#python#RunBin(t:grb_bin_file . command_suffix)
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ftplugin#python#RunTests(test_name)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    let project_name = ftplugin#python#ProjectName()
    exec ":!./env/bin/python test_project/manage.py test " . a:test_name . " --settings=" . project_name . ".test_settings"
endfunction

function! ftplugin#python#SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! ftplugin#python#RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), 'test_') != -1
    if in_test_file
        call ftplugin#python#SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call ftplugin#python#RunTests(ftplugin#python#TranslateTestFile(t:grb_test_file) . command_suffix)
endfunction

function! ftplugin#python#TranslateTestFile(filename)
    let test_name = substitute(a:filename, '/', '.', 'g')
    let test_name = substitute(test_name, '.py', '', '')
    return test_name
endfunction

function! ftplugin#python#RunNearestTest()
    let test_line_number = line('.')
    let module_details = system('line_to_path ' . expand("%") . " " . test_line_number)
    let module_details = substitute(module_details, '\n', '', '')
    call ftplugin#python#RunTestFile(module_details)
endfunction
