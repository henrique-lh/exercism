module LuciansLusciousLasagna

// TODO: define the 'expectedMinutesInOven' binding
let expectedMinutesInOven: int = 40
// TODO: define the 'remainingMinutesInOven' function
let remainingMinutesInOven x = 
    expectedMinutesInOven - x
// TODO: define the 'preparationTimeInMinutes' function
let preparationTimeInMinutes layers = 
    layers * 2
// TODO: define the 'elapsedTimeInMinutes' function
let elapsedTimeInMinutes layers time = preparationTimeInMinutes layers + time