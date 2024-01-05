//
//  DetailCoordinate.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 23/12/23.
//
import UIKit
final class DetailCoordinate: Coordinator {
    var navigation: UINavigationController
    private let detailFactory: DetailsFactory
    let launchItem: LaunchesItem
    init(navigation: UINavigationController,
         detailFactory: DetailsFactory,
         launchItem: LaunchesItem) {
        self.navigation = navigation
        self.detailFactory = detailFactory
        self.launchItem = launchItem
    }
    func start() {
        let controller = detailFactory.makeModule(coordinator: self, launchDatas: launchItem)
        navigation.pushViewController(controller, animated: true)
    }
}
extension DetailCoordinate: DetailsVCCoordinator {
    func goYTVideo(videoId: String) {
        let goYTVideo =  detailFactory.goYTVideo(navigation: navigation, videoId: videoId)
        goYTVideo.start()
    }
    func goWebView(link: String) {
        let goYTVideo =  detailFactory.goWebView(navigation: navigation, url: link)
        goYTVideo.start()
    }
}
