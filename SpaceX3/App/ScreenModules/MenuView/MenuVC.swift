//
//  MenuVC.swift
//  SpaceX3
//
//  Created by Cristhian on 01/01/24.
//
import UIKit
import FirebaseAuth
import Combine
import GoogleSignIn
protocol MenuVCCoordinator {
    func logOOut()
}
class MenuVC: UIViewController {
    let menuArray: [MenuEntity] = [MenuEntity(title: "cerrar sesión", icon: "rectangle.portrait.and.arrow.right.fill")]
    @IBOutlet weak var menuTableView: UITableView!
    private var coordinator: MenuVCCoordinator
    init(
        coordinator: MenuVCCoordinator
    ) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
    }
}
// MARK: TableView
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let menuArray = menuArray[indexPath.row]
        cell.configureCell(icon: menuArray.icon, title: menuArray.title)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.alertCloseSession()
    }
    private func setUpTableView() {
        self.menuTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
    }
    private func alertCloseSession() {
        let dialogMessage = UIAlertController(title: "", message: "¿Estás seguro de cerrar sesión?" , preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: { (action) -> Void in
            self.closeSession()
        })
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) -> Void in
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    private func closeSession() {
        let defaults = UserDefaults.standard
        let provider = defaults.value(forKey: "provider") as? String
        defaults.synchronize()
        switch provider {
        case "basic":
            self.cleanLocalDatas()
            self.fireBaseLogOut()
        case "google":
            self.cleanLocalDatas()
            GIDSignIn.sharedInstance.signOut()
            self.coordinator.logOOut()
        default:
            self.fireBaseLogOut()
            self.cleanLocalDatas()
        }
    }
    private func fireBaseLogOut() {
        do {
            try Auth.auth().signOut()
            self.coordinator.logOOut()
        } catch {
            debugPrint("error logOut")
        }
    }
    private func cleanLocalDatas() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
    }
}
