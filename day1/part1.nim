import std/strutils, sequtils
import "../benchmark"

# WTF no ++ operator in nim?
proc increment*(x: ptr int): int =
  x[] += 1
  x[]


proc evaluate*(inputSeq: seq[int]) =
    var lastDepth = 0
    var count = 0
    for curDepth in inputSeq.items:
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


proc solve() =
    let f = open("input.txt")
    defer: f.close()

    var input = f.readAll().strip()
    var inputSeq = input.split('\n').map(parseInt)

    evaluate(inputSeq)


benchmark "part1":
    solve()

