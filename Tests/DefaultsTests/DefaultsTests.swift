import XCTest
@testable import Defaults

let fixtureUrl = URL(string: "httos://sindresorhus.com")!

enum FixtureEnum: String, Codable {
	case tenMinutes = "10 Minutes"
	case halfHour = "30 Minutes"
	case oneHour = "1 Hour"
}

extension Defaults.Keys {
	static let key = Defaults.Key<Bool>("key", default: false)
	static let url = Defaults.Key<URL>("url", default: fixtureUrl)
	static let `enum` = Defaults.Key<FixtureEnum>("enum", default: .oneHour)
}

final class DefaultsTests: XCTestCase {
	override func setUp() {
		super.setUp()
		defaults.clear()
	}

    func testKey() {
		let key = Defaults.Key<Bool>("key", default: false)
		XCTAssertFalse(UserDefaults.standard[key])
		UserDefaults.standard[key] = true
		XCTAssertTrue(UserDefaults.standard[key])
	}

	func testOptionalKey() {
		let key = Defaults.OptionalKey<Bool>("key")
		XCTAssertNil(UserDefaults.standard[key])
		UserDefaults.standard[key] = true
		XCTAssertTrue(UserDefaults.standard[key]!)
	}

	func testKeys() {
		XCTAssertFalse(defaults[.key])
		defaults[.key] = true
		XCTAssertTrue(defaults[.key])
	}

	func testUrlType() {
		XCTAssertEqual(defaults[.url], fixtureUrl)

		let newUrl = URL(string: "https://twitter.com")!
		defaults[.url] = newUrl
		XCTAssertEqual(defaults[.url], newUrl)
	}

	func testEnumType() {
		XCTAssertEqual(defaults[.enum], FixtureEnum.oneHour)
	}

	func testClear() {
		defaults[.key] = true
		XCTAssertTrue(defaults[.key])
		defaults.clear()
		XCTAssertFalse(defaults[.key])
	}
}
