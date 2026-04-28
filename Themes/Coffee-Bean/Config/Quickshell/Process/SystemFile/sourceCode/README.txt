easy method

install from releases at :"githup.com/yk-kamel/yk-shell" and look for binary

method 2, build it yourself

1-install go

in arch based systems, runs: "pacman -S go"

2-Build

run "go mod init sysinfo"  ./sourceCode

run "go mod tidy" inside ./sourceCode

run go "build ./main.go 

move binary to SystemFile and rename it to "sysinfo"
