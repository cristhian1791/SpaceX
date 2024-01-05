//
//  Coordinator.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 22/12/23.
//
import UIKit
protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
}
