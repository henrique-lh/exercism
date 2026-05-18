module ValentinesDay

// TODO: please define the 'Approval' discriminated union type

// TODO: please define the 'Cuisine' discriminated union type

// TODO: please define the 'Genre' discriminated union type

// TODO: please define the 'Activity' discriminated union type

type Approval = 
    | Yes
    | No
    | Maybe

type Cuisine = 
    | Korean
    | Turkish

type Genre = 
    | Crime
    | Horror
    | Romance
    | Thriller

type Activity = 
    | BoardGame
    | Chill
    | Movie of Genre
    | Restaurant of Cuisine
    | Walk of int

let rateActivity (activity: Activity): Approval = 
    match activity with
        | Movie Romance -> Yes
        | Restaurant Korean -> Yes
        | Restaurant Turkish -> Maybe
        | Walk w when w < 3 -> Yes
        | Walk w when w < 5 -> Maybe
        | _ -> No
