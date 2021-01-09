function! QuickFile(reference)
	let lines = readfile('.quickfile', '')
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
