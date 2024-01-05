//
//  LaunchFactory.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 22/12/23.
//
import UIKit
import Combine
protocol LaunchFactory {
    func makeModule(coordinator: LaunchViewControllerCoordinator) -> UIViewController
    func goHome(
        navigation: UINavigationController
    ) -> Coordinator
    func goLogin(
        navigation: UINavigationController
    ) -> Coordinator
}
struct LaunchFactoryImp: LaunchFactory {
    func makeModule(coordinator: LaunchViewControllerCoordinator) -> UIViewController {
        let launchController = LaunchScreen(coordinator: coordinator)
        return launchController
    }
    func goHome(navigation: UINavigationController) -> Coordinator {
        let homeFactory = HomeFactoryImp()
        let homeCoordinator = HomeCoordinate(navigation: navigation,
                                             homeFactory: homeFactory)
        return homeCoordinator
    }
    func goLogin(navigation: UINavigationController) -> Coordinator {
        let loginFactory = LoginEmailFactoryImp()
        let loginCoordinator = LoginEmailCoordinate(navigation: navigation,
                                                    loginEmailFactory: loginFactory)
        return loginCoordinator
    }
}
