//
//  LoginEmailVC.swift
//  SpaceX3
//
//  Created by Cristhian on 01/01/24.
//
import UIKit
import FirebaseAuth
import Combine
import GoogleSignIn
protocol LoginEmailCoordinator {
    func goHome()
}
class LoginEmailVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    private var coordinator: LoginEmailCoordinator
    init(coordinator: LoginEmailCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Autenticación"
        self.checkAuthentication()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    private func checkAuthentication() {
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String, let provider = defaults.value(forKey: "provider") as? String {
            self.coordinator.goHome()
        }
    }
    private func saveDatas(email: String, provider: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider, forKey: "provider")
        defaults.synchronize()
    }
    @IBAction func SignUpBtn(_ sender: Any) {
        if let email = emailTextField.text, let pasword = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: pasword) { (result, error) in
                if let result = result, error == nil {
                    self.coordinator.goHome()
                    self.saveDatas(email: email, provider: "basic")
                } else {
                    let alertController = UIAlertController(title: "Error",
                                                            message: "Se ha producido un error registrando el usuario.",
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    @IBAction func loginBtn(_ sender: Any) {
        if let email = emailTextField.text, let pasword = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: pasword) { (result, error) in
                if let result = result, error == nil {
                    self.coordinator.goHome()
                    self.saveDatas(email: email, provider: "basic")
                } else {
                    let alertController = UIAlertController(title: "Error",
                                                            message: "Usuario ó contraseña incorrecto.",
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    @IBAction func googleBtnAction(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            guard let idToken = user?.user.idToken,
                  let accessToken = user?.user.accessToken else {
                print("Google Sign-In failed: No authentication data")
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            guard let signInResult = user else { return }
            let user = signInResult.user
            let email = user.profile?.email
            self.saveDatas(email: email.valueOrEmpty, provider: "google")
            self.coordinator.goHome()
        }
    }
} 
