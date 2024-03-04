module DifferenceOfSquares

let squareOfSum (number: int): int = 
    let total: int = [1 .. number] |> Seq.sum
    total * total

let sumOfSquares (number: int): int = 
    let total: int = [1 .. number] |> Seq.map (fun x -> x * x) |> Seq.sum
    total

let differenceOfSquares (number: int): int = 
    squareOfSum number - sumOfSquares number