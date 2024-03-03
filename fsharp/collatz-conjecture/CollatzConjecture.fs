module CollatzConjecture

let steps (number: int): int option =
    if number <= 0 then None
    else
        let mutable counter = 0
        let mutable currentNumber: int = number
        while currentNumber <> 1 do
            counter <- counter + 1
            if currentNumber % 2 = 0 then 
                currentNumber <- currentNumber / 2
            else 
                currentNumber <- currentNumber * 3 + 1
        Some counter
