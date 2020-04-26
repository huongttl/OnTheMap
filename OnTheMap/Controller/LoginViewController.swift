//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Huong Tran on 3/22/20.
//  Copyright © 2020 RiRiStudio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    let signUpURL = "https://auth.udacity.com/sign-up"


    @IBAction func loginButtonTapped(_ sender: Any) {
        setLoggingIn(true)
        Client.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "") {
            success, error in
            if success {
                DispatchQueue.main.async {
                    let tabVC = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
                    self.navigationController?.pushViewController(tabVC, animated: true
                     )
                    print("Login OK")
                    self.setLoggingIn(false)
                }
            } else {
                DispatchQueue.main.async {
                    self.showLoginFailure(message: error?.localizedDescription ?? "")
                    self.setLoggingIn(false)
                }
            }
        }
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let url = URL(string: signUpURL) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        print(message)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func setLoggingIn(_ isLoggingIn: Bool) {
        if isLoggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !isLoggingIn
        passwordTextField.isEnabled = !isLoggingIn
        loginButton.isEnabled = !isLoggingIn
        signupButton.isEnabled = !isLoggingIn
    }
}
