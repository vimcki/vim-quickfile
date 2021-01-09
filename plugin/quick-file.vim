function! QuickFile(reference)
	let reference_file = get(g:, 'quickfile_reference_file', '.quickfile')
	if filereadable(reference_file)
		let reference_file_path = reference_file
	else
		" TODO test if git present and if git is even installed
		let git_root = system("git rev-parse --show-toplevel | tr -d '\\n'")
		let reference_file_path = git_root . "/" . reference_file
	endif
	echom reference_file_path
	let lines = readfile(reference_file_path, '')
	for line in lines
		let split_line = split(line, "=")
		if len(split_line) != 2
			echom "error in your .quickfile"
			return
		endif
		let [ref, path] = split_line
		if ref ==? a:reference
			execute "edit " . path
		endif
	endfor
endfunction
