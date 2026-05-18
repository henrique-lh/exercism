module Isogram

open System

let isIsogram (str: string): bool = 
    let counter = str 
                        |> String.filter System.Char.IsLetter 
                        |> String.map System.Char.ToLower
                        |> Set.ofSeq
                        |> Set.count
    String.length (str |> String.filter System.Char.IsLetter) = counter
