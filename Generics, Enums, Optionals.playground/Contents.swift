//: Generics, Enums, Optionals Playground
//
//  Created by Jeremy Kelleher on 10/24/2018.
//

import UIKit

// MARK: Generics

func myFirstProject() {
    print("Name = Jeremy Kelleher")
    print("Age = 18")
    let heightFeet = 5
    let heightRemainderInches = 8
    let totalHeightInches = (heightFeet * 12) + heightRemainderInches
    print("Height in Inches = \(totalHeightInches)")
    let totalHeightCM = (Double(totalHeightInches) * 2.54)
    print("Height in CM = \(totalHeightCM)")
}

//myFirstProject()

func generalizedFirstProject(name: String, age: Int, heightFeet: Int, heightRemainderInches: Int) {
    print("Name = \(name)")
    print("Age = \(age)")
    let totalHeightInches = (heightFeet * 12) + heightRemainderInches
    print("Height in Inches = \(totalHeightInches)")
    let totalHeightCM = (Double(totalHeightInches) * 2.54)
    print("Height in CM = \(totalHeightCM)")
}

//generalizedFirstProject(name: "Jeremy Kelleher", age: 18, heightFeet: 5, heightRemainderInches: 8)

class Apple { }

class ApplePickingBag {
    var apples = [Apple]()
    func add(apple: Apple) {
        apples.append(apple)
    }
}

class Textbook { }

class TextbookBag {
    var textbooks = [Textbook]()
    func add(textbook: Textbook) {
        textbooks.append(textbook)
    }
}

class Bag<Thing> {
    var things = [Thing]()
    func add(thing: Thing) {
        things.append(thing)
    }
}

let yayFallIsHere = Bag<Apple>()
let booSchoolIsTheWorst = Bag<Textbook>()

//let completeConfusion = Bag()

//let bagOfBruisedApples = Bag<Apple & Textbook>()

protocol Clothing { }

class LightClothingItem: Clothing { }
class DarkClothingItem: Clothing { }
class Rock { }

class WashingMachine<ClothingItem: Clothing> {
    func wash(dirtyClothes: [ClothingItem]) { }
}

//let brockenWashingMachine = WashingMachine<Rock>()

let whiteShirtForCareerFairs = LightClothingItem()
let darkShirtForParties = DarkClothingItem()

let lightsWashingMachine = WashingMachine<LightClothingItem>()
lightsWashingMachine.wash(dirtyClothes: [whiteShirtForCareerFairs])

let darksWashingMachine = WashingMachine<DarkClothingItem>()
darksWashingMachine.wash(dirtyClothes: [darkShirtForParties])

//darksWashingMachine.wash(dirtyClothes: [whiteShirtForCareerFairs])

//lightsWashingMachine.wash(dirtyClothes: [darkShirtForParties])

class OmniWashingMachine {
    func wash(dirtyClothes: [Clothing]) { }
}

let everythingWashingMachine = OmniWashingMachine()

everythingWashingMachine.wash(dirtyClothes: [whiteShirtForCareerFairs])

everythingWashingMachine.wash(dirtyClothes: [darkShirtForParties])

everythingWashingMachine.wash(dirtyClothes: [whiteShirtForCareerFairs, darkShirtForParties])

class NoBlendingColorsWashingMachine {
    func wash<ClothingItem: Clothing>(dirtyClothes: [ClothingItem]) { }
}

let betterWashingMachine = NoBlendingColorsWashingMachine()

betterWashingMachine.wash(dirtyClothes: [whiteShirtForCareerFairs])

betterWashingMachine.wash(dirtyClothes: [darkShirtForParties])

//betterWashingMachine.wash(dirtyClothes: [whiteShirtForCareerFairs, darkShirtForParties])

// MARK: Enums

enum Major {
    case computerScience
    case spanish
    case biochemistry
}

let myMajor = Major.computerScience

func willIHaveProfessorBarington(in major: Major) -> Bool {
    switch major {
    case .computerScience:
        return true
    default:
        return false
    }
}

willIHaveProfessorBarington(in: .biochemistry) // returns false

enum FlexibleMajor {
    case computerScience
    case spanish
    case biochemistry
    case bdic(focus: String)
}

let coolMajor: FlexibleMajor = .bdic(focus: "iOS App Development")

func isCoolestKidOnCampus(myMajor major: FlexibleMajor) -> Bool {
    switch major {
    case .bdic(focus: let focusDescription) where focusDescription == "iOS App Development":
        return true
    default:
        return false
    }
}

// https://github.com/apple/swift/blob/master/stdlib/public/core/Optional.swift
// Optional

class WifiNetwork { }
class AppleWifi: WifiNetwork { }
class Eduroam: WifiNetwork { }

let wifiAtAppleStore: WifiNetwork = AppleWifi()

//var wifiAtUMass: WifiNetwork?
var wifiAtUMass: Optional<WifiNetwork>

wifiAtUMass = nil
wifiAtUMass = Optional.none

wifiAtUMass = Eduroam()
wifiAtUMass = Optional.some(Eduroam())

func visitAppleDotCom(on wifiNetwork: WifiNetwork) { }

func watchAppleKeynote(on maybeWifiNetwork: WifiNetwork?) {

    switch maybeWifiNetwork {
    case .some(let definiteWifiNetwork):
        // let's hope for some new MacBooks
        visitAppleDotCom(on: definiteWifiNetwork)
    case .none:
        // no keynote for you
        return
    }
    
    visitAppleDotCom(on: maybeWifiNetwork!)
    
    if maybeWifiNetwork != nil {
        visitAppleDotCom(on: maybeWifiNetwork!)
    } else {
        return
    }
    
    if let definiteWifiNetwork = maybeWifiNetwork {
        visitAppleDotCom(on: definiteWifiNetwork)
    } else {
        return
    }
    
    guard let definiteWifiNetwork = maybeWifiNetwork else {
        return
    }
    
    visitAppleDotCom(on: definiteWifiNetwork)

}

// optional chaining
var commentText: String?
let commentLabel: UILabel = UILabel()
commentLabel.text = commentText?.uppercased()

// nil coalescing
var likeEmoji: String?
//print(likeEmoji ?? "👍🏻")

enum State {
    case noData
    case requestingData
    case hasData(Data)
}
