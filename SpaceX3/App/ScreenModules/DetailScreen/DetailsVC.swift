//
//  DetailsVC.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 23/12/23.
//
import UIKit
import Foundation
import Combine
protocol DetailsVCCoordinator {
    func goYTVideo(videoId: String)
    func goWebView(link: String)
}
class DetailsVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var lblDetailsTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblRocketName: UILabel!
    @IBOutlet weak var lblRocketType: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnPlayYTVideo: UIButton!
    @IBOutlet weak var btnYTVideo: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnLaunchInfo: UIButton!
    @IBOutlet weak var pageControlTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    let screenWidth = UIScreen.main.bounds.width
    var launchesItems: LaunchesItem
    var slides:[Slide] = []
    private var coordinator: DetailsVCCoordinator
    init(launchesItems: LaunchesItem, coordinator: DetailsVCCoordinator) {
        self.launchesItems = launchesItems
        self.coordinator = coordinator
        super.init(nibName: "DetailsVC", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSlider()
        title = launchesItems.missionName
        self.setUpElements(launchesItems: launchesItems)
        self.lblDescription.addObserver(self, forKeyPath: "data", options: .new, context: nil)
    }
    private func setUpSlider() {
        if !launchesItems.links.flickrImages.isEmpty {
            slides = createSlides(flickrImages: launchesItems.links.flickrImages)
            setupSlideScrollView(slides: slides)
            pageControl.numberOfPages = slides.count
            pageControl.currentPage = 0
            view.bringSubviewToFront(pageControl)
            self.scrollView.contentSize.height = 1.0
            self.scrollView.showsHorizontalScrollIndicator = false
            self.scrollView.layer.cornerRadius = 10
        } else {
            scrollView.isHidden = true
            pageControl.isHidden = true
            pageControlTopConstrain.constant = 0
        }
    }
    private func setUpElements(launchesItems: LaunchesItem) {
        btnPlayYTVideo.layer.cornerRadius = btnPlayYTVideo.frame.size.width/2
        btnPlayYTVideo.clipsToBounds = true
        btnInfo.layer.cornerRadius = btnInfo.frame.size.width/2
        btnInfo.clipsToBounds = true
        btnYTVideo.layer.cornerRadius = 20
        btnLaunchInfo.layer.cornerRadius = 20
        let date = Utils().convertDateFormat(inputDate: launchesItems.launchDateLocal.valueOrEmpty)
        self.lblDate.text = "Date: \(date)"
        self.lblSite.text = "Site: \(launchesItems.launchSite.siteNameLong.rawValue)"
        self.lblRocketName.text = "Rocket name: \(launchesItems.rocket.rocketName.rawValue)"
        self.lblRocketType.text = "Rocket type: \(launchesItems.rocket.rocketType.rawValue)"
        self.lblDescription.text = launchesItems.details
    }
    @IBAction func YTVideo(_ sender: UIButton) {
        coordinator.goYTVideo(videoId: launchesItems.links.youtubeID)
    }
    @IBAction func launchInfo(_ sender: UIButton) {
        coordinator.goWebView(link: launchesItems.links.articleLink.valueOrEmpty)
    }
}
