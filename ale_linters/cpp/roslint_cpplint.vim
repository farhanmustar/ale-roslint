" Author: Farhan Mustar <farhanmustar@gmail.com>
" Description: roslint_cpplint for cpp files

call ale#Set('cpp_roslint_cpplint_executable', 'rosrun')

function! ale_linters#cpp#roslint_cpplint#GetExecutable(buffer) abort
  let pep8_executable = ale#Var(a:buffer, 'cpp_roslint_cpplint_executable')
  if !executable('rosrun') || !executable('rospack')
    return ''
  endif
  silent call system('rospack find roslint')
  if v:shell_error != 0
    return ''
  endif
  return pep8_executable
endfunction

function! ale_linters#cpp#roslint_cpplint#GetCommand(buffer) abort
  return '%e roslint cpplint %s'
endfunction

call ale#linter#Define('cpp', {
\   'name': 'roslint_cpplint',
\   'output_stream': 'stderr',
\   'executable': function('ale_linters#cpp#roslint_cpplint#GetExecutable'),
\   'command': function('ale_linters#cpp#roslint_cpplint#GetCommand'),
\   'callback': 'ale#handlers#cpplint#HandleCppLintFormat',
\   'lint_file': 1,
\})
