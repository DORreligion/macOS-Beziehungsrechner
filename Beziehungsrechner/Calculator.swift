//
//  Calculator.swift
//  Beziehungsrechner
//
//  Created by Lukas Schramm on 16-07-10.
//  Copyright © 2016 Cappricorn. All rights reserved.
//

import Foundation

class CalcRelation {
    
    private var names = [String]()
    private var relationRate = Int()
    
    private var numbers = [Int]()
    private var length = Int()
    private var temp = Int()
    private var counter = Int()
    
    init(names:[String]) {
        self.names = names
        sort()
        calc()
    }
    
    func sort() {
        names = names.sorted()
        let nameStr = (names[0] + names[1]).uppercased()
        let chars = Array(nameStr.characters)
        counter = 0
        for a in chars {
            for b in chars {
                if(a==b) {
                    counter += 1
                }
            }
            numbers.append(counter)
            counter = 0
        }
    }
    
    func calc() {
        var numbersStatic = [Int]()
        var digits = [Int]()
        for number in numbers {
            numbersStatic.append(number)
        }
        length = numbersStatic.count
        temp = length-1
        numbers.removeAll()
        
        for i in 0 ..< (length/2) {
            counter = numbersStatic[i] + numbersStatic[temp]
            if counter > 9 {
                while counter > 0 {
                    digits.insert(counter%10, at: 0)
                    counter/=10
                }
                numbers.append(digits[0])
                numbers.append(digits[1])
            } else {
                numbers.append(counter)
            }
            temp -= 1;
        }
        
        if length%2 != 0 {
            numbers.append(numbersStatic[length/2])
        }
        if numbers.count > 2 && !(numbers.count==3 && numbers[0]==1 && numbers[1]==0 && numbers[2]==0) {
            calc()
        } else {
            var str = ""
            for number in numbers {
                str += "\(number)"
            }
            relationRate = Int(str)!
        }
    }
    
    func getRelationRate() -> Int {
        return relationRate
    }
}

extension String {
    var alphabetic: String {
        get {
            return self.replacingOccurrences(of: "[^A-Za-z]", with: "", options: NSString.CompareOptions.regularExpressionSearch, range: nil)
        }
    }
    
    func stringToDOR() -> String {
        var newName = self
        var nIndexBegin = -1
        var nIndexEnd = -1
        for i in 0..<newName.characters.count {
            if (newName.characters.map {String($0)})[i].lowercased() == "n" {
                if nIndexBegin == -1 {
                    nIndexBegin = i
                    nIndexEnd = i
                } else {
                    nIndexEnd = i
                }
            } else if nIndexBegin != -1 {
                if nIndexBegin != nIndexEnd {
                    var tempNameChars = newName.characters.map {String($0)}
                    for j in nIndexBegin...nIndexEnd {
                        tempNameChars[j] = "N"
                    }
                    newName = tempNameChars.joined(separator: "")
                }
                nIndexBegin = -1
                nIndexEnd = -1
            }
        }
        if nIndexBegin != -1 && nIndexBegin != nIndexEnd {
            var tempNameChars = newName.characters.map {String($0)}
            for j in nIndexBegin...nIndexEnd {
                tempNameChars[j] = "N"
            }
            newName = tempNameChars.joined(separator: "")
            nIndexBegin = -1
            nIndexEnd = -1
        }
        return newName
    }
}
