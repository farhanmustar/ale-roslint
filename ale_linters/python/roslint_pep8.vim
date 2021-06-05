" Author: Farhan Mustar <farhanmustar@gmail.com>
" Description: roslint_pep8 for python files

call ale#Set('python_roslint_pep8_executable', 'rosrun roslint pep8')

function! ale_linters#python#roslint_pep8#GetExecutable(buffer) abort
  " TODO: check for roslint package available check rosrun and rospack then rospack find roslint
  let pep8_exe = ale#Var(a:buffer, 'python_roslint_pep8_executable')
  if !executable('rosrun') || !executable('rospack')
    return ''
  endif
  silent system('rospack find roslint')
  if v:shell_error != 0
    return ''
  endif
  return pep8_exe
endfunction

function! ale_linters#python#roslint_pep8#GetCommand(buffer) abort
  return '%e %s'
endfunction

call ale#linter#Define('python', {
\   'name': 'roslint_pep8',
\   'executable': function('ale_linters#python#roslint_pep8#GetExecutable'),
\   'command': function('ale_linters#python#roslint_pep8#GetCommand'),
\   'callback': 'ale#handlers#unix#HandleAsError',
\})
