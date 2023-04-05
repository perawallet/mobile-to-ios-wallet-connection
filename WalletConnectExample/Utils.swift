//
//  Utils.swift
//  WalletConnectExample
//
//  Created by Ömer on 8.09.2022.
//

import Foundation

extension Sequence {
    public func contains<T: Equatable>(
        matching equation: (KeyPath<Element, T>, T?)
    ) -> Bool {
        return contains { $0[keyPath: equation.0] == equation.1 }
    }
}

extension String {
    var hasContainWalletConnectUrl: Bool {
        guard !isEmpty else {
            return false
        }

        guard hasPrefix("wc:") else {
            /// check valid wc prefix
            return false
        }

        let convertedDeeplinkText = replacingOccurrences(of: "wc:", with: "wc://")

        guard let urlComponents = URLComponents(string: convertedDeeplinkText) else {
            /// text is not compatible with valid URL
            return false
        }

        guard
            let queryItems = urlComponents.queryItems,
            queryItems.contains(matching: (\.name, "key")),
            queryItems.contains(matching: (\.name, "bridge"))
        else {
            return false
        }

        return true
    }

    var peraCompatibleWalletConnectUrlForDeeplink: URL? {
        guard hasContainWalletConnectUrl else {
            /// text doesn't contain wallet connect url
            return nil
        }

        return peraCompatibleEncodedWalletConnectUrlForDeeplink
    }

    var peraCompatibleWalletConnectUrlForUniversalLink: URL? {
        guard hasContainWalletConnectUrl else {
            /// text doesn't contain wallet connect url
            return nil
        }

        return peraCompatibleEncodedWalletConnectUrlForUniversalLink
    }

    private var peraCompatibleEncodedWalletConnectUrlForDeeplink: URL? {
        guard let encodedUrlText = addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            return nil
        }

        let finalURLText = ViewController.peraWalletConnectRoutingBaseForDeeplink + encodedUrlText
        return URL(string: finalURLText)
    }

    private var peraCompatibleEncodedWalletConnectUrlForUniversalLink: URL? {
        guard let encodedUrlText = addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            return nil
        }

        let finalURLText = ViewController.peraWalletConnectRoutingBaseForUniversalLink + encodedUrlText
        return URL(string: finalURLText)
    }
}
