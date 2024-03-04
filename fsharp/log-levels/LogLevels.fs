module LogLevels

let message (logLine: string): string = 
    logLine.Split(":").[1].Trim()

let logLevel(logLine: string): string = 
    logLine.Split(":").[0] |> String.filter System.Char.IsLetter |> String.map System.Char.ToLower

let reformat(logLine: string): string = 
    let newLogLine = message logLine
    let newLogLevel = logLevel logLine
    let t = sprintf "%s (%s)" newLogLine newLogLevel
    t
