//
//  AppFactory.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 22/12/23.
//
import UIKit
protocol AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator
    
}
struct AppFactoryImp: AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator {
        let launchFactory = LaunchFactoryImp()
        let launchCoordinator = LaunchCoordinate(navigation: navigation, launchFactory: launchFactory)
        return launchCoordinator
    }
}

