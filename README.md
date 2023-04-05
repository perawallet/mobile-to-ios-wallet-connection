# mobile-to-ios-wallet-connection

In order to launch Pera Wallet with Wallet Connect Session, Mobile App should open URL that is described below;

* A URL must have valid pattern both deeplinks and universal links.
	* Deeplink URL should contain `perawallet-wc://` scheme
	* Universal link URL should contain `https://perawallet.app` host and `/qr/perawallet-wc/` path 
* The URL should be constructed by `uri` parameter. This uri parameter should contain valid WC URL
* Valid WC URL should have `wc:` prefix, `key` & `bridge` query parameters and values.
* WC URL should be constructed for Wallet Connect V1