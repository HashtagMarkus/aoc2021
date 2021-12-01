import std/strutils

# WTF no ++ operator in nim?
proc increment(x: ptr int): int =
  x[] += 1
  x[]

proc solve() =
    let f = open("input.txt")
    defer: f.close()

    var line: string
    var lastDepth = 0
    var count = 0
    while f.read_line(line):
        var curDepth = parseInt(line)
        var status = $count & "(N/A - no previous measurement)"

        if lastDepth > 0:
            status = (  if curDepth > lastDepth: 
                            $increment(addr count) & "(increased)" 
                        else: 
                            $count & "(decreased)"
                     )
        
        echo status
        lastDepth = curDepth

    echo "Total: ", $count

solve()

