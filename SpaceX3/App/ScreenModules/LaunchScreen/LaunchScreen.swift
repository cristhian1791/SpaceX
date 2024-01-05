//
//  LaunchScreen.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 22/12/23.
//
import UIKit
import Lottie
import Combine
protocol LaunchViewControllerCoordinator  {
    func goHome()
    func goLogin()
}
class LaunchScreen: UIViewController {
    private var coordinator: LaunchViewControllerCoordinator
    let animationView = LottieAnimationView()
    init(coordinator: LaunchViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.setupAnimation()
    }
    private func setupAnimation() {
        animationView.animation = LottieAnimation.named("space4")
        animationView.frame = view.bounds
        animationView.center = view.center
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            self.animationView.stop()
            DispatchQueue.main.async {
                self.checkAuthentication()
            }
        }
    }
    private func checkAuthentication() {
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String, let provider = defaults.value(forKey: "provider") as? String {
            self.coordinator.goHome()
        } else {
            self.coordinator.goLogin()
        }
    }
}
