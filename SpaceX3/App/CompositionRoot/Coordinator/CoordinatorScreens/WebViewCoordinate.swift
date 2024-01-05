//
//  WebViewCoordinate.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 27/12/23.
//
import UIKit
final class WebViewCoordinate: Coordinator {
    var navigation: UINavigationController
    private var webViewFactory: WebViewFactory
    var url: String
    init(navigation: UINavigationController,
         webViewFactory: WebViewFactory,
         url: String) {
        self.navigation = navigation
        self.webViewFactory = webViewFactory
        self.url = url
    }
    func start() {
        let controller = webViewFactory.makeModule(url: url)
        navigation.pushViewController(controller, animated: true)
    }
} 
