//: Playground - noun: a place where people can play

import Cocoa

//Optionals

var x:Int?
var y:Int = 5
var z:Int = 0

//Error!
//z = x + y
//Int? != Int

let slide:String = "🍕"
let pizza:String = " Pizza!"
let pizzaSlide:String = slide + pizza
//let pizzaQuarter:String = 0.25

let meaningOfLife = 42
let pi = 3.14159

_stdlib_getDemangledTypeName(pi)
_stdlib_getDemangledTypeName(meaningOfLife)
/*
                        8888888888  888    88888
                       88     88   88 88   88  88
                        8888  88  88   88  88888
                           88 88 888888888 88   88
                    88888888  88 88     88 88    888888

                    88  88  88   888    88888    888888
                    88  88  88  88 88   88  88  88
                    88 8888 88 88   88  88888    8888
                    888  888 888888888 88   88     88
                     88  88  88     88 88    8888888

                     E X A M P L E S  /  E J E M P L O S
*/

//Values & Reference Types

//Value Type
struct padawan {
    var name:String
}

var anakin = padawan(name: "Anakin")
var azoka = anakin

anakin.name = "Darth Vader"
anakin.name

azoka.name

//Reference Type
class sithLord {
    var ligthabreModel:String?
}

var dartMoul = sithLord()
dartMoul.ligthabreModel = "Double"

var Duku = dartMoul
Duku.ligthabreModel = "Curved"

dartMoul.ligthabreModel

Duku.ligthabreModel

//Generics
func transform<A,B> (x:A, f:A->B) -> B {
    return f(x)
}

let trans1 = transform(5, f: {x in x + 2 })
let trans2 = transform("Dead ", f: {x in x + "Star 🌐" })

//Enum

enum Planet {
    case Tatoine
    case Mustafa
    case Alderan
    case Corusant
    case Naboo
    case Endor
}

let capitalPlanet = Planet.Corusant

enum Force {
    case lightSide(padawan)
    case darkSide(Bool, Bool)
}

let myForceChooise = Force.lightSide(anakin)

//switch myForceChooise {
//    case .lightSide(let jedi):
//        print(jedi.name)
//    case .darkSide(true, true) :
//        print("You don't know the power of the dark side")
//}


//Closures

var buzzLighsaber = { return "Buzzz" }
var lightSaberColor:(String) -> (String) = {  x in x + " Saber" }
var myLightSaber = lightSaberColor("Blue")

//First Class Citizen

func activateDroid(x:String) -> (String) -> Bool {
    return { y in x == "BB8" && y == "Active" }
}

let droid = activateDroid("BB8")


//Functional Composition

func buildDeadStar(part:String, number:Int) -> [Int:String] {
    return [number: part]
}

func deadStarStock(dict:[Int:String]) -> Bool {
    for (key, value) in dict {
        if key == 0  || value == ""{
            return false
        }
    }
    return true
}


var deadStarValidParts = deadStarStock(buildDeadStar("Planet Green Laser", number: 66))
