//
//  WalletConnectExampleTests.swift
//  WalletConnectExampleTests
//
//  Created by Ömer on 6.09.2022.
//

import XCTest
@testable import WalletConnectExample

class WalletConnectExampleTests: XCTestCase {
    func testWCUrls() throws {
        let validUrl = "wc:3bd1767d-39ff-4c1b-8sa9-4dcd95f56458@1?bridge=https%3A%2F%2F9.bridge.walletconnect.org&key=7c401ddc1f9b57647bfa49a76b71aae150f8659100f492c914923ca0ec566103&algorand=true"
        let invalidURL = "wc:3bd1767d-39ff-4c1b-8sa9-4dcd95f56458@1?bridge=https%3A%2F%2F9.bridge.walletconnect.org&algorand=true"
        let invalidEncodedUrl = "wc%3A3bd1767d-39ff-4c1b-8ca9-4dcd95f56458%401%3Fbridge%3Dhttps%253A%252F%252F9.bridge.walletconnect.org%26key%3D7c401ddc1f9b57647bfa49a76b71aae150f8659ca0f492c914923ca0ec566103%26algorand%3Dtrue"
        let invalidWebUrl = "https://perawallet.app"
        let emptyString = ""
        XCTAssertTrue(validUrl.hasContainWalletConnectUrl)
        XCTAssertFalse(invalidURL.hasContainWalletConnectUrl)
        XCTAssertFalse(invalidEncodedUrl.hasContainWalletConnectUrl)
        XCTAssertFalse(invalidWebUrl.hasContainWalletConnectUrl)
        XCTAssertFalse(emptyString.hasContainWalletConnectUrl)
    }

    func testDeeplinkURLS() throws {
        let validUrl = "wc:3bd1767d-39ff-4c1b-8sa9-4dcd95f56458@1?bridge=https%3A%2F%2F9.bridge.walletconnect.org&key=7c401ddc1f9b57647bfa49a76b71aae150f8659100f492c914923ca0ec566103&algorand=true"

        XCTAssertTrue(validUrl.hasContainWalletConnectUrl)
        XCTAssertNotNil(validUrl.peraCompatibleWalletConnectUrl)

        let invalidEncodedUrl = "wc%3A3bd1767d-39ff-4c1b-8ca9-4dcd95f56458%401%3Fbridge%3Dhttps%253A%252F%252F9.bridge.walletconnect.org%26key%3D7c401ddc1f9b57647bfa49a76b71aae150f8659ca0f492c914923ca0ec566103%26algorand%3Dtrue"

        XCTAssertNil(invalidEncodedUrl.peraCompatibleWalletConnectUrl)
    }
}
