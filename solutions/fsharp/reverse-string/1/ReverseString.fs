module ReverseString

let reverse (input: string): string =
    input |> Seq.toArray |> Array.rev |> System.String