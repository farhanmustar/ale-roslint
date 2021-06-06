" Author: Farhan Mustar <farhanmustar@gmail.com>
" Description: roslint_pep8 for python files

call ale#Set('python_roslint_pep8_executable', 'rosrun')

function! ale_linters#python#roslint_pep8#GetExecutable(buffer) abort
    let pep8_executable = ale#Var(a:buffer, 'python_roslint_pep8_executable')

    if !executable('rosrun') || !executable('rospack')
        return ''
    endif

    silent call system('rospack find roslint')

    if v:shell_error != 0
        return ''
    endif

    return pep8_executable
endfunction

function! ale_linters#python#roslint_pep8#GetCommand(buffer) abort
    return '%e roslint pep8 %s'
endfunction

call ale#linter#Define('python', {
\   'name': 'roslint_pep8',
\   'executable': function('ale_linters#python#roslint_pep8#GetExecutable'),
\   'command': function('ale_linters#python#roslint_pep8#GetCommand'),
\   'callback': 'ale#handlers#unix#HandleAsError',
\})
