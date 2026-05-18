module Pangram

let alphabet = {'a' .. 'z'} |> Set.ofSeq

let isPangram (input: string): bool =
    input.ToLower() |> Set.ofSeq |> Set.isSubset alphabet
