//
//  HomeFactory.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 22/12/23.
//
import UIKit
import Combine
protocol HomeFactory {
    func makeModule(coordinator: HomeVCCoordinator) -> UIViewController
    func goDescription(
        navigation: UINavigationController,
        datas: LaunchesItem
    ) -> Coordinator
    func goMenu(
        navigation: UINavigationController
    ) -> Coordinator
}
struct HomeFactoryImp: HomeFactory {
    func makeModule(coordinator: HomeVCCoordinator) -> UIViewController {
        let homeViewModel = HomeViewModel()
        let homeController = HomeVC(viewModel: homeViewModel, coordinator: coordinator)
        return homeController
    }
    func goDescription(navigation: UINavigationController, datas: LaunchesItem) -> Coordinator {
        let detailsFactory = DetailsFactoryImp()
        let detailsCoordinator = DetailCoordinate(navigation: navigation,
                                                  detailFactory: detailsFactory,
                                                  launchItem: datas)
        return detailsCoordinator
    }
    func goMenu(navigation: UINavigationController) -> Coordinator {
        let menuFactory = MenuViewFactoryImp()
        let menuCoordinator = MenuViewCoordinator(navigation: navigation,
                                                  menuViewFactory: menuFactory)
        return menuCoordinator
    }
}
