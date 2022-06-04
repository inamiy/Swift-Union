import XCTest
@testable import Union

final class UnionTests: XCTestCase {
    func testUnion_first() throws {
        @Union<Int, String>
        var union = 1

        XCTAssertEqual($union.value(of: Int.self), 1)
        XCTAssertEqual($union.value(of: String.self), nil)
    }

    func testUnion_second() throws {
        @Union<Int, String>
        var union = "hello"

        XCTAssertEqual($union.value(of: String.self), "hello")
        XCTAssertEqual($union.value(of: Int.self), nil)
    }

    // Comment-Out: Same type union is not supported.
//    func testUnion_sameType() throws {
//        @Union3<Int, Int, Never>
//        var union = 1
//
//        XCTAssertEqual($union.value(of: Int.self), 1)
//    }

    func testUnion3() throws {
        @Union3<Int, String, Bool>
        var union = true

        XCTAssertEqual($union.value(of: Bool.self), true)
    }

    func testUnion4() throws {
        @Union4<Int, String, Bool, Double>
        var union = 3.14

        XCTAssertEqual($union.value(of: Double.self), 3.14)
    }

    func testUnion5() throws {
        @Union5<Int, String, Bool, Double, Character>
        var union = "a" as Character

        XCTAssertEqual($union.value(of: Character.self), "a")
    }
}
