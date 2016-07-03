//: Playground - noun: a place where people can play

import Foundation

let immutableString = "hello, playground"
var str = "Hello, playground"

str = "another string"

var myInt = 42
let myConstant = 50

let implicityDouble = 70.0

let explicityDouble: Double = 70

let label = "the width is "
let width = 94
let widthLabel = label + String(width)
String(94)
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples"
let orangeSummary = "I have \(oranges) apples"

var shoppingList: Array<String> = ["catfish", "water", "tulips", "blue paint"]
var copyList = shoppingList
shoppingList.append("toothpaste")

var occupation: Dictionary<String,String> = [
    "malcom": "captain",
    "kaayee": "mechanic"
]
occupation["Jayne"] = "Public Relations"


var occupationNames = occupation.map { (k:String, v:String) -> String in
    return k
}
var occupationNames2 = occupation.map {$0.0}.map {$0; "blah"}
occupationNames

var r = 50...100
var g = r.generate()
g.next()
g.next()

var g1 = [11,21,31,41,51].generate()
g1.next()
g1.next()

var tuple1 = (1,2)
tuple1.0
tuple1.1

var tuple2 = (first: "van", last: "Simmons")
tuple2.0
tuple2.last

for (k,v) in occupation {
    print("\(k),\(v)")
}

func doubler(x:Int) -> Int {
    
    return x*2
    
}

doubler(3)
doubler(5)

func progression(v: Int, f: Int -> Int) -> Int {
    return f(v)
}


progression(4, f: doubler)

var tf = false
tf = true

var arrArr: Array<Array<Bool>> = [[true]]


var closure = { (x:Int) -> Int in
    return x*3
}

progression(6, f: closure)

progression(6) {(x:Int) -> Int in
    return x*3
}


var optionalN: Int? = 14
var implicityOptionalN: Int! = 12

if let n = optionalN {
    let doubleN = doubler(n)
}

doubler(implicityOptionalN)















