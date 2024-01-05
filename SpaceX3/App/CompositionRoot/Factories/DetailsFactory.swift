//
//  DetailsFactory.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 23/12/23.
//
import UIKit
import Combine
protocol DetailsFactory {
    func makeModule(coordinator: DetailsVCCoordinator, launchDatas: LaunchesItem) -> UIViewController
    func goYTVideo(
        navigation: UINavigationController,
        videoId: String
    ) -> Coordinator
    func goWebView(
        navigation: UINavigationController,
        url: String
    ) -> Coordinator
}
struct DetailsFactoryImp: DetailsFactory {
    func makeModule(coordinator: DetailsVCCoordinator, launchDatas: LaunchesItem) -> UIViewController {
        let detailsController = DetailsVC(launchesItems: launchDatas, coordinator: coordinator)
        detailsController.launchesItems = launchDatas
        return detailsController
    }
    func goYTVideo(navigation: UINavigationController, videoId: String) -> Coordinator {
        let YTVideoFactory = YTVideoFactoryImp()
        let YTVideoCoordinator = YTVideoCoordinate(navigation: navigation,
                                                   YTVideoFactory: YTVideoFactory,
                                                   videoId: videoId)
        return YTVideoCoordinator
    }
    func goWebView(navigation: UINavigationController, url: String) -> Coordinator {
        let webViewFactory = WebViewFactoryImp()
        let webViewCoordinator = WebViewCoordinate(navigation: navigation,
                                                   webViewFactory: webViewFactory,
                                                   url: url)
        return webViewCoordinator
    }
}
