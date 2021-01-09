function! QuickFile(reference)
	let reference_file = get(g:, 'quickfile_reference_file', '.quickfile')
	if filereadable(reference_file)
		let root =  "."
		let reference_file_path = reference_file
	else
		let root = system("git rev-parse --show-toplevel | tr -d '\\n'")
		let reference_file_path = root . "/" . reference_file
	endif
	let lines = readfile(reference_file_path, '')
	for line in lines
		let split_line = split(line, "=")
		if len(split_line) != 2
			echom "error in your reference file: " . reference_file_path
			echom "with line: " . line
			echom "expected format: <reference>=<path>"
			return
		endif
		let [ref, path] = split_line
		if ref ==? a:reference
			execute "edit " . root . "/" . path
		endif
	endfor
endfunction
