import sequtils, strutils
import "../benchmark"

type Command* = tuple
    cmd: string
    value: int


type Course = tuple
    position: int
    depth: int


proc `+`(course: Course, c: Command): Course = 
    case c.cmd:
        of "forward":
            return (course.position + c.value, course.depth)
        of "down":
            return (course.position, course.depth + c.value)
        of "up":
            return (course.position, course.depth - c.value)


proc mapInputToCommand*(inputSeq: seq[string]): seq[Command] =
    inputSeq
            .map(proc(x: string):seq[string] = splitWhitespace(x))
            .map(proc(x: seq[string]): Command = (x[0], parseInt(x[1])))


proc solve(input: seq[Command]): int =
    
    var course: Course
    
    for c in input:
        course = course + c
        echo "Position: ", $course.position, " - Depth: ", $course.depth

    return course.position * course.depth

when isMainModule:
    import unittest
    suite "day2":
        test "Test Example":
            let inputSeq = @["forward 5","down 5", "forward 8", "up 3", "down 8", "forward 2"]
            let input = mapInputToCommand(inputSeq) 
            echo input[0].cmd
            check(input[0].cmd == "forward")
            check(input[0].value == 5)
            check(input[5].cmd == "forward")
            check(input[5].value == 2)
            check(input.len == 6)
            check(solve(input) == 150)
                
benchmark "day2":
        let input = readFile("input.txt").strip().splitLines()
        echo solve(mapInputToCommand(input))



