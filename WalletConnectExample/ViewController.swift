//
//  ViewController.swift
//  WalletConnectExample
//
//  Created by Ömer on 6.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextView: UITextView!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var convertedUrlLabel: UILabel!

    static let peraWalletConnectRoutingBase = "algorand-wc://wc?uri="

    override func viewDidLoad() {
        super.viewDidLoad()

        urlTextView.delegate = self
        updateViews(nil)
    }
    @IBAction func didTapRoute(_ sender: Any) {
        guard let urlText = urlTextView.text else {
            return
        }

        guard let url = urlText.peraCompatibleWalletConnectUrl else {
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
        updateConvertedUrl(text)
        setRouteButtonEnabled(text)
    }

    private func updateConvertedUrl(_ text: String?) {
        guard let text = text, let url = text.peraCompatibleWalletConnectUrl else {
            convertedUrlLabel.text = "Invalid URL"
            return
        }

        convertedUrlLabel.text = url.absoluteString
    }

    private func setRouteButtonEnabled(_ text: String?) {
        guard let text = text else {
            routeButton.isEnabled = false
            return
        }

        routeButton.isEnabled = text.hasContainWalletConnectUrl
    }
}
