//
//  LoginEmailFactory.swift
//  SpaceX3
//
//  Created by Cristhian on 01/01/24.
//
import UIKit
import Combine
protocol LoginEmailFactory {
    func makeModule(coordinator: LoginEmailCoordinator) -> UIViewController
    func goHome(
        navigation: UINavigationController
    ) -> Coordinator
}
struct LoginEmailFactoryImp: LoginEmailFactory {  
    func makeModule(coordinator: LoginEmailCoordinator) -> UIViewController {
        let loginViewController = LoginEmailVC(coordinator: coordinator)
        return loginViewController
    }
    func goHome(navigation: UINavigationController) -> Coordinator {
        let homeFactory = HomeFactoryImp()
        let homeCoordinator = HomeCoordinate(navigation: navigation,
                                             homeFactory: homeFactory)
        return homeCoordinator
    }
    func logOut(navigation: UINavigationController) -> Coordinator {
        let launchFactory = LaunchFactoryImp()
        let launchCoordinator = LaunchCoordinate(navigation: navigation,
                                                 launchFactory: launchFactory)
        return launchCoordinator
    }
}
