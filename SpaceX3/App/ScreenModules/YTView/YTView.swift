//
//  YTView.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 25/12/23.
//
import UIKit
import Combine
import youtube_ios_player_helper
class YTView: UIViewController {
    @IBOutlet weak var playerView: YTPlayerView!
    var videoId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configPlayerView()
    }
    private func configPlayerView() {
        let playerVars : [AnyHashable: Any] = ["playsinline" : 1, "controls": 1, "autohide": 1, "showinfo": 0, "modestbranding": 0]
        playerView.load(withVideoId: videoId, playerVars: playerVars)
        playerView.delegate = self
    }
}
extension YTView: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
