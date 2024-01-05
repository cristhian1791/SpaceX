//
//  WebViewFactory.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 27/12/23.
//
import UIKit
import Combine
protocol WebViewFactory {
    func makeModule(url: String) -> UIViewController
}
struct WebViewFactoryImp: WebViewFactory {
    func makeModule(url: String) -> UIViewController {
        let webViewController = WebViewController()
        webViewController.url = url
        return webViewController
    }
}
