module TwoFer

let twoFer (input: string option): string = 
    match input with
        | Some(input) -> sprintf "One for %s, one for me." input
        | None -> "One for you, one for me."
