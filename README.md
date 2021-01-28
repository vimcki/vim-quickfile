# vim-quickfile

This plugin allows you to quickly open commonly accessed files.

## Features

* One mapping allows you to access given "type" of file across multiple
  projects. And by type i mean config file/dependencies file/entrance point for
  your code etc.
* Open multiple files of the same "type" in fzf window
* Open directory in Explore

## What problem does it solve?

1. Using fuzzy search to open commonly accessed files get annoying. Lets use
  golang as example. Imagine having your main application code in
  cmd/server/main.go and couple of tools that also use name main.go, for example
  in tools/client/main.go and tools/whatever/main.go. Server code main.go will
  be accessed way more than tools mains. Using fuzzy search to open server
  main.go you have to type 'main.go' and search through list of 3 files
  potentially having to go up or down and select corrent main.go. This is inefficient.
1. Working with different projects in different languages gets confusing with
  commonly open files. Imagine having 3 projects that you often work on, one has
  a config in server.toml, other has config in configs/default.py and third in
  app/settings/my-django-app-settings.py. While working your first thought is
  'I want to see configuration file' then 'This project configuration file
  was...'(this step takes time and you can confuse project and think about
  wrong path/file name) and then 'fuzzy search for it'. We can do better and
  eliminate second and third step. All you have to do is think 'I want to see
  configuration file' and hit correct mapping

## How to use this plugin?

First you need a mapping to call QuickFile function with reference name. This
function will go through a reference file and find path to a file you want to
access. Reference file lives with a project and defines what is where. Its
default name is .quickfile and if its missing from current working directory
plugin will use git root to check if .quickfile is there.

Example of mappings and .quickfile for 2 projects. Notice in second .quickfile
there is directory specified in config reference. Calling QuickFile on it will
open Explore with that directory. Also there are comma separated file paths in
build. This one will open fzf window with all specified files loaded.

Part of vimrc

``` vimscrip
nnoremap <leader>fm :call QuickFile("makefile")<cr>
nnoremap <leader>fi :call QuickFile("ci")<cr>
nnoremap <leader>fc :call QuickFile("config")<cr>
nnoremap <leader>fb :call QuickFile("build")<cr>
nnoremap <leader>fe :call QuickFile("main")<cr>
nnoremap <leader>fd :call QuickFile("dependencies")<cr>
```

First .quickfile

``` text
makefile=Makefile
build=internal/components/build.go
config=configs/server.toml
main=cmd/server/main.go
ci=.gitlab-ci.yml
dependencies=go.mod
```

Second .quickfile

``` text
makefile=Makefile
build=internal/build/build.py,internal/build/build_frontend.py
config=configs
main=main.py
ci=.gitlab-ci.yml
dependencies=requirements.txt
```

## Customisation

If you don't like .quickfile file name you can use different file name by
setting global variable:

``` vimscript
g:quickfile_reference_file
```
