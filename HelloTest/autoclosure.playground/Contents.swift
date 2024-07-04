import UIKit

func random() -> Int {
    return Int.random(in: 0 ... 100)
}

func takeResult(param: Int) {
    print(#function)
    print(param)
}

takeResult(param: random())

func takeClosure(param: () -> Int) {
    print(#function)
    print(param())
}

takeClosure(param: { Int.random(in: 0 ... 100) })

func takeAutoClosure(param: @autoclosure @escaping () -> Int) {
    print(#function)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        print(param())
    }
    
}

takeAutoClosure(param: Int.random(in: 0 ... 100))

//let rnd = random()
//print(rnd)
//assert(rnd > 30)

