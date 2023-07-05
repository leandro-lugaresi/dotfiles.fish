#!/usr/bin/env fish
set -Ux GOPATH $PROJECTS/Go
fish_add_path -a $GOPATH/bin /usr/local/go/bin

if command -qs go
    go install github.com/go-delve/delve/cmd/dlv@latest
    go install github.com/mattn/goreman@latest
end

alias --save gmt='go mod tidy'
alias --save grm='go run ./...'
