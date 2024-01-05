//
//  LaunchCoordinate.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 22/12/23.
//
import UIKit
final class LaunchCoordinate: Coordinator {
    var navigation: UINavigationController
    private let launchFactory: LaunchFactory
    init(navigation: UINavigationController, launchFactory: LaunchFactory) {
        self.navigation = navigation
        self.launchFactory = launchFactory
    }
    func start() {
        let controller = launchFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}
extension LaunchCoordinate: LaunchViewControllerCoordinator {
    func goLogin() {
        let loginCoordinator = launchFactory.goLogin(navigation: navigation)
        loginCoordinator.start()
    }
    func goHome() {
        let homeCoordinator =  launchFactory.goHome(navigation: navigation)
        homeCoordinator.start()
    }
}
