//
//  AdapterPattern.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/17/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import Foundation


class Duck {
    func quack() {}
    func fly() {}
}

class Turkey {
    func gobble() {}
    func fly() {}
}

class TurkeyAdapter: Duck {
    var turkey: Turkey
    
    init(turkey: Turkey) {
        self.turkey = turkey
    }
    
    override func quack() {
        turkey.gobble()
    }
    
    override func fly() {
        for _ in 1...5 {
            turkey.fly()
        }
    }
}

class DuckSimulator {
    func main() {
        let duck = Duck()
        testDuck(duck: duck)
        
        let turkey = Turkey()
        let turkeyAdapter = TurkeyAdapter(turkey: turkey)
        testDuck(duck: turkeyAdapter)
    }
    
    func testDuck(duck: Duck) {
        duck.quack()
        duck.fly()
    }
}
