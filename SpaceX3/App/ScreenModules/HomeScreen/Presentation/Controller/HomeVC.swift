//
//  HomeVC.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 23/12/23.
//

import UIKit
import Foundation
import Combine
protocol HomeVCCoordinator {
    func goDetails(launchData: LaunchesItem)
    func goMenu()
}
class HomeVC: UIViewController {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var launchesTableView: UITableView!
    var viewModel = HomeViewModel()
    private var coordinator: HomeVCCoordinator
    var orderState = false
    init(
        viewModel: HomeViewModel,
        coordinator: HomeVCCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Space X 🚀"
        self.setUpNAvigation()
        self.setUpTableView()
        self.prepareViewModelObserver()
        self.detectEntryDate()
    }
    private func setUpNAvigation() {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.loadingView.startAnimating()
        
        let orderBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "shuffle"), style: .plain, target: self, action: #selector(orderArray))
        self.navigationItem.rightBarButtonItem  = orderBarButtonItem
        
        let menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(menuBtn))
        self.navigationItem.leftBarButtonItem  = menuBarButtonItem
    }
    @objc private func orderArray(sender:UIButton) {
        viewModel.orderArray(state: orderState)
        orderState.toggle()
    }
    @objc private func menuBtn(sender:UIButton) {
        coordinator.goMenu()
    }
    private func goDetails(launchData: LaunchesItem) {
        coordinator.goDetails(launchData: launchData)
    }
    func detectEntryDate() {
        viewModel.detectEntryDate()
    }
    func prepareViewModelObserver() {
        self.viewModel.listDidChanges = { (finished, error) in
            if !error { 
                self.launchesTableView.reloadData()
                self.loadingView.stopAnimating()
                self.loadingView.isHidden = true
            } else {
                self.alertMsg(message: self.viewModel.error)
                debugPrint("error")
            }
        }
    }
    func alertMsg(message: String) {
        let dialogMessage = UIAlertController(title: "Alert", message: message , preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
         })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
// MARK: TableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    /// Función que realiza la configuración incial de la tabla.
    func setUpTableView() {
        self.launchesTableView.register(UINib(nibName: "LaunchesCell", bundle: nil), forCellReuseIdentifier: "LaunchesCell")
        self.launchesTableView.delegate = self
        self.launchesTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.launchesItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = launchesTableView.dequeueReusableCell(withIdentifier: "LaunchesCell", for: indexPath) as? LaunchesCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let launchesItem = viewModel.launchesItems[indexPath.row]
        let date = Utils().convertDateFormat(inputDate: launchesItem.launchDateLocal.valueOrEmpty)
        cell.configureCell(urlImage: launchesItem.links.missionPatchSmall.valueOrEmpty,
                           title: launchesItem.missionName,
                           description: launchesItem.launchSite.siteName.rawValue,
                           date: date)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.goDetails(launchData: viewModel.launchesItems[indexPath.row])
    }
}
