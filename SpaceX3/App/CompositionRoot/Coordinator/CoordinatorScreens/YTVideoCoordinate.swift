//
//  YTVideoCoordinate.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 27/12/23.
//
import UIKit
final class YTVideoCoordinate: Coordinator {
    var navigation: UINavigationController
    private var YTVideoFactory: YTVideoFactory
    var videoId: String
    init(navigation: UINavigationController,
         YTVideoFactory: YTVideoFactory,
         videoId: String) {
        self.navigation = navigation
        self.YTVideoFactory = YTVideoFactory
        self.videoId = videoId
    }
    func start() {
        let controller = YTVideoFactory.makeModule(videoId: videoId)
        navigation.pushViewController(controller, animated: true)
    }
}
