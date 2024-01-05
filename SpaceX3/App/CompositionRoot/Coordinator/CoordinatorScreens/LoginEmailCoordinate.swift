//
//  LoginEmailCoordinate.swift
//  SpaceX3
//
//  Created by Cristhian on 01/01/24.
//
import UIKit
final class LoginEmailCoordinate: Coordinator {
    var navigation: UINavigationController
    private var loginEmailFactory: LoginEmailFactory
    init(navigation: UINavigationController,
         loginEmailFactory: LoginEmailFactory) {
        self.navigation = navigation
        self.loginEmailFactory = loginEmailFactory
    }
    func start() {
        let controller = loginEmailFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}
extension LoginEmailCoordinate: LoginEmailCoordinator {
    func goHome() { 
        let homeCoordinator =  loginEmailFactory.goHome(navigation: navigation)
        homeCoordinator.start()
    }
}
