# Swift-Union

Poor man's untagged union type in Swift.

```swift
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

func testUnion3() throws {
    @Union3<Int, String, Bool>
    var union = true

    XCTAssertEqual($union.value(of: Bool.self), true)
}
```

See also: [inamiy/Swift-Intersection](https://github.com/inamiy/Swift-Intersection)
