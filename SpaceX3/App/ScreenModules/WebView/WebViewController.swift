//
//  WebViewController.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 25/12/23.
//
import UIKit
import WebKit
class WebViewController: UIViewController {
    let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero,
                                configuration: configuration)
        return webView
    }()
    var url: String = "" 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        guard let url = URL(string: self.url) else { return }
        webView.load(URLRequest(url: url))
        webView.customUserAgent = "iPad/Chrome"
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
