import times, strutils

template benchmark*(benchmarkName: string, code: untyped) =
    block:
        let t0 = cpuTime()
        code
        let elapsed = cpuTime() - t0
        let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 6)
        echo "CPU Time [", benchmarkName, "] ", elapsedStr, "s"
