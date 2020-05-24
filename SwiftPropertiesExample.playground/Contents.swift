import Foundation

// Stored properties
let slicesPerPerson = 4
var numberOfPeople = 4

//Observed properties
var pizzaInInches: Int = 10 {
    willSet {
        print("New value of observed property \(newValue)")
    }
    didSet {
        print("New value of observed property \(oldValue)")
        if pizzaInInches > 18 {
            pizzaInInches = 18
        }
    }
}

pizzaInInches = 33
print(pizzaInInches)

//Computed properties
var numberOfSlices: Int {
    return pizzaInInches - 4
}

//Getters and setters for computed properties
var numberOfPizza: Int {
    get { // called when value is used
        let numberOfPeopleFedPerPizza = numberOfSlices/slicesPerPerson
        return numberOfPeople/numberOfPeopleFedPerPizza
    }
    set { // called when value is modified
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices/slicesPerPerson
    }
}

// Calls the setter
numberOfPizza = 6
print(numberOfPeople)
