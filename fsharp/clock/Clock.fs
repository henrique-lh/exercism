module Clock

let normalise time = 
    if time < 0 then 1440 + (time % 1440) else time % 1440

let create hours minutes = 
    normalise (60 * hours + minutes)

let add minutes clock = clock + minutes

let subtract minutes clock = clock - minutes

let display clock = 
    let time = normalise clock
    let hours = (time / 60) % 24
    let minutes = time % 60
    sprintf "%02d:%02d" hours minutes
