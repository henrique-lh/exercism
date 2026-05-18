module Bob
open System
let isUpper (s:string): bool = s = s.ToUpper()
let isQuestion (s:string): bool = s.EndsWith("?")
let isNumeric (s:string): bool = s |> Seq.exists Char.IsLetter |> not
let isEmpty (s:string): bool = s = ""
let response (input: string): string =
    match input.Trim() with
        | i when i |> isEmpty -> "Fine. Be that way!"
        | i when i |> isNumeric && i |> isQuestion -> "Sure."
        | i when i |> isNumeric -> "Whatever."
        | i when i |> isUpper && i |> isQuestion -> "Calm down, I know what I'm doing!"
        | i when i |> isQuestion -> "Sure."
        | i when i |> isUpper -> "Whoa, chill out!"
        | _ -> "Whatever."
