" http://labs.timedia.co.jp/2011/04/9-points-to-customize-automatic-indentation-in-vim.html

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0

if !exists('b:undo_indent')
    let b:undo_indent = ''
endif

let b:undo_indent = 'setlocal '.join([
	    \	'tabstop<',
	    \	'shiftwidth<',
	    \	'softtabstop<',
	    \ ])

