//
//  Stack.swift
//  HelloTest
//
//  Created by Langpeu on 7/4/24.
//

import Foundation

enum StackError: Error {
    case overflow
    case unknown
}

struct Stack<Element> {
    //private 속성은 접근이 안되기 때문에
    //method 를 통해서 간접적으로 테스트 할 수 있다.
    private var storage =  [Element]()
    
    let capacity: Int
    
    var count: Int {
        storage.count
    }
    
    init?(capacity: Int) {
        guard capacity > 1 else { return nil }
        self.capacity = capacity
    }
    
    func peek() -> Element? {
        return storage.last
    }
    
    mutating func push(_ element: Element) throws {
        guard count < capacity else {
            throw StackError.overflow
        }
        
       storage.append(element)
    }
    
    mutating func pop() -> Element? {
        return storage.popLast()
    }
}
