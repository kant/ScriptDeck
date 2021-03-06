//
//  WebViewPreloader.swift
//  ScriptDeck
//
//  Created by Ravi Tripathi on 14/06/20.
//

import WebKit

class WebViewPreloader {
    
    static let shared = WebViewPreloader()
    
    var webviews = [URL: WKWebView]()
    let imagesUrls = [URL(string:"https://github.com/ravitripathi/ScriptDeck/raw/master/ScriptDeckLogo.png")!,
    URL(string: "https://github.com/ravitripathi/ScriptDeck/raw/master/RemoteAssets/step1.png")!,
    URL(string:"https://github.com/ravitripathi/ScriptDeck/raw/master/RemoteAssets/step2.png")!,
    URL(string:"https://github.com/ravitripathi/ScriptDeck/raw/master/RemoteAssets/step3.png")!,
    URL(string:"https://github.com/ravitripathi/ScriptDeck/raw/master/RemoteAssets/step4.gif")!,
    URL(string:"https://github.com/ravitripathi/ScriptDeck/raw/master/RemoteAssets/step5.png")!]

    /// Registers a web view for preloading. If an webview for that URL already
    /// exists, the web view reloads the request
    ///
    /// - Parameter url: the URL to preload
    func preload(url: URL) {
        webview(for: url).load(URLRequest(url: url))
    }
    
    func preloadImages() {
        for url in self.imagesUrls {
            webview(for: url).load(URLRequest(url: url))
        }
    }

    /// Creates or returns an already cached webview for the given URL.
    /// If the webview doesn't exist, it gets created and asked to load the URL
    ///
    /// - Parameter url: the URL to prefecth
    /// - Returns: a new or existing web view
    func webview(for url: URL) -> WKWebView {
        if let cachedWebView = webviews[url] { return cachedWebView }

        let webview = WKWebView(frame: .zero)
        webview.load(URLRequest(url: url))
        webview.setValue(false, forKey: "drawsBackground")
        webviews[url] = webview
        return webview
    }
}
