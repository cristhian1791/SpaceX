//
//  AppCoordinator.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 22/12/23.
//
import Foundation
import UIKit
final class AppCoordinator: Coordinator {
    var navigation: UINavigationController
    private let appFactory: AppFactory
    private var launchCoordinator: Coordinator?
    init(navigation: UINavigationController, appFactory: AppFactory, window: UIWindow?) {
        self.navigation = navigation
        self.appFactory = appFactory
        self.configWindow(window: window)
    }
    func start() {
        launchCoordinator = appFactory.makeHomeCoordinator(navigation: navigation)
        launchCoordinator?.start()
    }
    private func configWindow(window: UIWindow?) {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
