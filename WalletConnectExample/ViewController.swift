//
//  ViewController.swift
//  WalletConnectExample
//
//  Created by Ömer on 6.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextView: UITextView!
    @IBOutlet weak var deeplinkRouteButton: UIButton!
    @IBOutlet weak var universalLinkRouteButton: UIButton!
    @IBOutlet weak var convertedUrlDeeplinkUrlLabel: UILabel!
    @IBOutlet weak var convertedUniversalLinkUrlLabel: UILabel!

    static let peraWalletConnectRoutingBaseForDeeplink = "perawallet-wc://wc?uri="
    static let peraWalletConnectRoutingBaseForUniversalLink = "https://perawallet.app/qr/perawallet-wc/wc?uri="

    override func viewDidLoad() {
        super.viewDidLoad()

        urlTextView.delegate = self
        updateViews(nil)
    }
    @IBAction func didTapRouteViaDeeplink(_ sender: Any) {
        guard let urlText = urlTextView.text else {
            return
        }

        guard let url = urlText.peraCompatibleWalletConnectUrlForDeeplink else {
            return
        }

        UIApplication.shared.open(url)
    }

    @IBAction func didTapRouteViaUniversalLink(_ sender: Any) {
        guard let urlText = urlTextView.text else {
            return
        }

        guard let url = urlText.peraCompatibleWalletConnectUrlForUniversalLink else {
            return
        }

        UIApplication.shared.open(url)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text

        updateViews(text)
    }
}

/// <mark>: UI Updates
extension ViewController {
    private func updateViews(_ text: String?) {
        updateConvertedUrlForDeeplink(text)
        updateConvertedUrlForUniversalLink(text)
        setRouteButtonsEnabled(text)
    }

    private func updateConvertedUrlForDeeplink(_ text: String?) {
        guard let text = text, let url = text.peraCompatibleWalletConnectUrlForDeeplink else {
            convertedUrlDeeplinkUrlLabel.text = "Invalid URL"
            return
        }

        convertedUrlDeeplinkUrlLabel.text = url.absoluteString
    }

    private func updateConvertedUrlForUniversalLink(_ text: String?) {
        guard let text = text, let url = text.peraCompatibleWalletConnectUrlForUniversalLink else {
            convertedUniversalLinkUrlLabel.text = "Invalid URL"
            return
        }

        convertedUniversalLinkUrlLabel.text = url.absoluteString
    }

    private func setRouteButtonsEnabled(_ text: String?) {
        let buttonsEnabled = text?.hasContainWalletConnectUrl ?? false
        deeplinkRouteButton.isEnabled = buttonsEnabled
        universalLinkRouteButton.isEnabled = buttonsEnabled
    }
}
