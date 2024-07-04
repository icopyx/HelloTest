//
//  HelloTestTests.swift
//  HelloTestTests
//
//  Created by Langpeu on 7/3/24.
//

import XCTest
@testable import HelloTest

final class StackTests: XCTestCase {
    
    //IO 타입으로 지정
    var sut: Stack<Int>! //sut System Under Test
    let defaultCapacity = 7
    
    //공통으로 사용하는 멤버는 여기서 초기화
    override func setUpWithError() throws {
        sut = Stack(capacity: defaultCapacity)
    }
    
    //공통으로 사용했던 멤버 제거
    override func tearDownWithError() throws {
        sut = nil
    }
    
    //유틸리티 메서드
    func arrageNotEmpty(_ count: Int, top: Int? = nil) throws {
        for num in 1 ... count - 1 {
            try sut.push(num)
        }
        
        try sut.push(top ?? Int.random(in: 0 ... 100))
    }

    //Stack 초기화시 올바른 capacity 로 초기화 되었는지 검증
    func testInit_whenCacacityParamIsValid_hasCorrectCapacity() {
        // Arrange
        let expectedCapacity = Int.random(in: 2 ... 30)
        var stack = Stack<Int>(capacity: expectedCapacity)
        // Act
        let actualcapacity = stack!.capacity
        // Assert
        XCTAssertEqual(actualcapacity, expectedCapacity, "예상한 길이(\(expectedCapacity)) 와 실제 길이(\(actualcapacity)) 가 다릅니다.")
    }
    
    //Stack 초기화시 capacity 값이 1 이하 값 (음수)로 입력시 nil 이 리턴되는지 검증
    func testInit_whenCapacityParamIsInvalid_returnNil() {
        // Arrange
        let invalidCapacity = Int.random(in: -10 ... 1)
        // Act
        let stack = Stack<Int>(capacity: invalidCapacity)
        // Assert
        XCTAssertNil(stack, "잘못된 capacity(\(invalidCapacity))를 전달했지만 인스턴스가 정상적으로 생성되었습니다.")
    }
    
    // Stack 이 비어 있을때 갯수는 0 으로 리턴되는지 검증
    func testCount_whenEmpty_returns0() {
        // Arrange
        let expectedCount = 0
        
        // Act
        let actualCount = sut.count
        // Assert
        XCTAssertEqual(actualCount, expectedCount, "비어있는 스택에서 count 속성이 0 보다 큰 값(\(actualCount))을 리턴했습니다.")
    }
    
    // Stack 내 갯수 리턴
    func testCount_whenNotEmpty_returnsElementCount() throws {
        // Arrange
        let expectedCount = Int.random(in: 2 ... defaultCapacity)
        try arrageNotEmpty(expectedCount)
        // Act
        
        // Assert
        let actualCount = sut.count
        XCTAssertEqual(actualCount, expectedCount)
    }
    
    // 제일 위에 있는 (마지막)데이터를 리턴하는 peek 메서드를 검증
    // 데이터가 없을때 nil 을 리턴하는지 검증
    func testPeek_empty_returnNil() {
        // Arrange
        
        // Act
        let topElement = sut.peek()
        // Assert
        XCTAssertNil(topElement, "비어있는 스택에서 데이터를 리턴했습니다.")
    }
    
    // 제일 위에 있는 데이터를 리턴하는 peek 메서드를 검증
    // 데이터가 있을때
    func testPeek_whenNotEmpty_returnsTopElement() throws {
        // Arrange
        let expectedTopElement = Int.random(in: 0 ... 100)
        try arrageNotEmpty(defaultCapacity, top: expectedTopElement)
        // Act
        let actualTopElement = sut.peek()
        
        // Assert
        XCTAssertEqual(actualTopElement, expectedTopElement)
    }
    
    //push 메서드 테스트
    func testPush_addDataToTop() throws {
        var expectedCount = 1
        
        for _ in 3 ... 3 + Int.random(in: 0 ... 7) {
            // Arrange
            let expectedTopElement = Int.random(in: 0 ... 100)
           
            // Act
            try sut.push(expectedTopElement)
            
            // Assert
            XCTAssertEqual(sut.count, expectedCount)
            XCTAssertEqual(sut.peek(), expectedTopElement)
            expectedCount += 1
        }
       
    }
    
    //stack 이 full 일때 에러처리 검증
    func testPush_whenStackIsFull_throwsStackOverflowError() throws {
        // Arrange
        for num in 1 ... defaultCapacity {
            try sut.push(num)
        }
        // Act + Assert
        XCTAssertThrowsError(try sut.push(1)) { error in
            XCTAssertEqual(error as? StackError, StackError.overflow)
        }
    }
    
    //stack 에 push가 잘 들어가는거 검증
    //error 가 throw 되지 않는것만 검증하면 됨
    func testPush_whenStackIsNotFull_noThrows() {
        XCTAssertNoThrow(try sut.push(0))
    }
 
//    pop 기능정의
//    1. top에 있는 데이터를 삭제하고 삭제한 데이터 리턴
//    2. 데이터가 비었을때 nil 을 리턴하는지 확인하고
//    3. 데이터가 존재한다면 카운터가 감소하는지 top의 데이터가 리턴되는지 이걸 테스트함
   
    //빈 stack 에서 pop실행시 nil 리턴 체크
    func testPop_whenEmpty_returnsNil() {
        // Arrange
        
        // Act
        let result = sut.pop()
        
        // Assert
        XCTAssertNil(result)
    }
    
    //stack 에서 pop실행시 count 가 1 감소되고 리턴되는 데이터가 삭제된 데이터인지 확인
    func testPop_whenNotEmpty_removesAndReturnsElement() throws{
        // Arrange
        try arrageNotEmpty(defaultCapacity)
        let expectedCount = defaultCapacity - 1
        let expectedElement = sut.peek()
        // Act
        let actualElement = sut.pop()
        // Assert
        XCTAssertEqual(sut.count, expectedCount)
        XCTAssertEqual(actualElement, expectedElement)
    }
    
}
