module Allergies

open System

// TODO: define the Allergen type
type Allergen =
    | Eggs = 1
    | Peanuts = 2
    | Shellfish = 4
    | Strawberries = 8
    | Tomatoes = 16
    | Chocolate = 32
    | Pollen = 64
    | Cats = 128

let allergicTo codedAllergies allergen =
    (int allergen &&& codedAllergies) = int allergen

let list codedAllergies =
    Enum.GetValues(typeof<Allergen>) :?> Allergen[]
    |> Array.filter (allergicTo codedAllergies) |> Array.toList
        