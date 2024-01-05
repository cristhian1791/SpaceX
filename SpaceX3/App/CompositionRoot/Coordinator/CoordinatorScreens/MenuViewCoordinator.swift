//
//  MenuViewCoordinator.swift
//  SpaceX3
//
//  Created by Cristhian on 01/01/24.
//
import UIKit
final class MenuViewCoordinator: Coordinator {
    var navigation: UINavigationController
    private var menuViewFactory: MenuViewFactory
    init(navigation: UINavigationController,
         menuViewFactory: MenuViewFactory) {
        self.navigation = navigation
        self.menuViewFactory = menuViewFactory
    }
    func start() {
        let controller = menuViewFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}
extension MenuViewCoordinator: MenuVCCoordinator {
    func logOOut() { 
        let menuCoordinator =  menuViewFactory.logOut(navigation: navigation)
        menuCoordinator.start()

    }
}
