import UIKit

/*
 Extension in swift can -
 * Add computed instance properties and computed type properties
 * Define instance methods and type methods
 * Provide new initializer
 * Define and use new nested types
 * Make an existing types
 * Make an existing type to conform to the protocol
 */

// Extension can add new functionality to a type, but type can't override existing functionality

// Extension Syntax

//extension SomeType {
//    // new functionality to add to someType goes here
//}

//extension someType: SomeProtocol, AnotherProtocol {
//    // implementation of protocol requirement goes here
//}

//-------------------------------------------------------------------------------------//
// Computed Properties

extension Double {
    var km: Double { return self*1000.0 }
    var m: Double { return self }
    var cm: Double { return self/100.0 }
    var mm: Double { return self/1000.0 }
    var ft: Double { return self/3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let marathon = 42.km + 195.m
print("A marathon is \(marathon) meters long")

// Extension can add new computed property, but they can't add stored stored property, or add property observers to existing properties.

//-------------------------------------------------------------------------------------//

// Initializers

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

//-------------------------------------------------------------------------------------//

// Methods

extension Int {
    func repetition(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetition {
    print("Hello!")
}

//-------------------------------------------------------------------------------------//

// Mutating Instance Methods

extension Int {
    mutating func square() {
        self = self*self
    }
}

var someInt = 3
someInt.square()

//-------------------------------------------------------------------------------------//

// Subscripts

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase += 10
        }
        return (self / decimalBase) % 10
    }
}

847534[0]
12312[4]
32423423[1]
324233454[5]

//-------------------------------------------------------------------------------------//

// Nested Types

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("_ ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        default:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
