import std/strutils
import "../benchmark"

const
    WINDOW_SIZE = 3

# WTF no ++ operator in nim?
proc increment(x: ptr int): int =
  x[] += 1
  x[]

proc calculate(inputSeq: seq[string]): seq[int] =
    # calculate inputSequence
    var 
        resPos = 0 # position of result array
        winPos = 0 
        line: string
        res = newSeq[int](1)
        i: int

    while i < inputSeq.len:
        line = inputSeq[i]
        if isEmptyOrWhitespace(line):
            break
#        echo line, " ", $i
#        echo $res[resPos], " + ", $parseInt(line), " = ", $(res[resPos] + parseInt(line))
        res[resPos] = res[resPos] + parseInt(line)
        inc winPos
 
        if winPos == WINDOW_SIZE and i != inputSeq.len - (WINDOW_SIZE - 1):
            inc(resPos)
            res.add(0)
            winPos = 0
            dec(i) # move window one step back
        else:
            inc(i)

    res


proc solve() =
    let f = open("input.txt")
    defer: f.close()

    # read complete file
    var 
        input = readAll(f)
        inputSeq = input.split('\n')
        res = calculate(inputSeq)
        lastDepth = 0
        count = 0
    
    for curDepth in res.items:
        var status = $count & "(N/A - no previous measurement)"

        if lastDepth > 0:
            status = (  if curDepth > lastDepth: 
                            $increment(addr count) & "(increased)" 
                        elif curDepth == lastDepth:
                            $count & "(no change)"
                        else: 
                            $count & "(decreased)"
                     )
        
        echo $curDepth, ": ", status
        lastDepth = curDepth

    echo "Total: ", $count

benchmark "part2":
    solve()

