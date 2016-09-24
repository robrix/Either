//  Copyright (c) 2014 Rob Rix. All rights reserved.

import Either
import Prelude
import XCTest

final class EitherTests: XCTestCase {
	let left = Either<Int, String>.left(4)
	let right = Either<Int, String>.right("four")


	// MARK: - either

	func testEitherExtractsFromLeft() {
		let value = left.either(ifLeft: id, ifRight: count)
		XCTAssertEqual(value, 4)
	}

	func testEitherExtractsFromRight() {
		let value = right.either(ifLeft: toString, ifRight: id)
		XCTAssertEqual(value, "four")
	}


	// MARK: - map

	func testMapIgnoresLeftValues() {
		let result = left.map(const(5)).either(ifLeft: id, ifRight: id)
		XCTAssertEqual(result, 4)
	}

	func testMapAppliesToRightValues() {
		let result = right.map(const(5)).either(ifLeft: id, ifRight: id)
		XCTAssertEqual(result, 5)
	}


	// MARK: - mapLeft

	func testMapLeftIgnoresRightValues() {
		let result = right.mapLeft(const("five")).either(ifLeft: id, ifRight: id)
		XCTAssertEqual(result, "four")
	}

	func testMapLeftAppliesToLeftValues() {
		let result = left.mapLeft(const("five")).either(ifLeft: id, ifRight: id)
		XCTAssertEqual(result, "five")
	}
	
	
	// MARK: - bimap
	
	func testBimapAppliesToBetterValues() {
		var result: Either<Int, String>
		
		result = right.bimap(leftBy: { $0 + 1 }, rightBy: const("Five"))
		guard let str = result.right else {
			XCTFail()
			return
		}
		XCTAssertEqual(str, "Five")
		
		result = left.bimap(leftBy: { $0 + 1 }, rightBy: const("Five"))
		guard let int = result.left else {
			XCTFail()
			return
		}
		XCTAssertEqual(int, 5)
	}


	// MARK: - >>-

	func testFlatMapRetypesLeftValues() {
		let result = (left >>- isFull).either(ifLeft: id, ifRight: const(0))
		XCTAssertEqual(result, 4)
	}

	func testFlatMapAppliesItsRightOperandToRightValues() {
		let result = (right >>- isFull).either(ifLeft: const(false), ifRight: id)
		XCTAssert(result)
	}
}


private func isFull<T>(string: String) -> Either<T, Bool> {
	return .right(!string.isEmpty)
}

func toString<T>(x: T) -> String {
	return String(describing: x)
}

func count(string: String) -> Int {
	return string.characters.count
}
