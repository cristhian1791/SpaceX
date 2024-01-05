//
//  MenuViewFactory.swift
//  SpaceX3
//
//  Created by Cristhian on 01/01/24.
//
import UIKit
import Combine
protocol MenuViewFactory {
    func makeModule(coordinator: MenuVCCoordinator) -> UIViewController
    func logOut(
        navigation: UINavigationController
    ) -> Coordinator
}
struct MenuViewFactoryImp: MenuViewFactory {
    func logOut(navigation: UINavigationController) -> Coordinator {
        let launchFactory = LaunchFactoryImp()
        let launchCoordinator = LaunchCoordinate(navigation: navigation,
                                                 launchFactory: launchFactory)
        return launchCoordinator
    }
    func makeModule(coordinator: MenuVCCoordinator) -> UIViewController {
        let menuViewController = MenuVC(coordinator: coordinator)
        return menuViewController
    }
}
