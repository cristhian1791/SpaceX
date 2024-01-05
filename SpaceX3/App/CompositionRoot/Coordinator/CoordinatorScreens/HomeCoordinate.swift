//
//  HomeCoordinate.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 22/12/23.
//
import UIKit
final class HomeCoordinate: Coordinator {
    var navigation: UINavigationController
    private let homeFactory: HomeFactory
    init(navigation: UINavigationController, homeFactory: HomeFactory) {
        self.navigation = navigation
        self.homeFactory = homeFactory
    }
    func start() {
        let controller = homeFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)        
    }
}
extension HomeCoordinate: HomeVCCoordinator {
    func goMenu() { 
        let menuCoordinator =  homeFactory.goMenu(navigation: navigation)
        menuCoordinator.start()
    }
    func goDetails(launchData: LaunchesItem) {
        let detailsCoordinator =  homeFactory.goDescription(navigation: navigation, datas: launchData)
        detailsCoordinator.start()
    }
}
