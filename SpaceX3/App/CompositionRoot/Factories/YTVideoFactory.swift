//
//  YTVideoFactory.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 27/12/23.
//
import UIKit
import Combine
protocol YTVideoFactory {
    func makeModule(videoId: String) -> UIViewController
}
struct YTVideoFactoryImp: YTVideoFactory {
    func makeModule(videoId: String) -> UIViewController {
        let YTVController = YTView()
        YTVController.videoId = videoId
        return YTVController
    }
} 
