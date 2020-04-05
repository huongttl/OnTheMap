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
//        activityIndicator.isHidden =
        // Do any additional setup after loading the view.
        
    }
    


    @IBAction func loginButtonTapped(_ sender: Any) {
        print("Now Logging....")
        Client.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:)) 
            print("Logging....")
 
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let url = URL(string: "https://www.udacity.com/") else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        print(Client.Auth.sessionId)
        print("Checking")
        if success {
            print("Login OK")
//            TMDBClient.postSession(completion: handleSessionResponse(success:error:))
            DispatchQueue.main.async {
                let tabVC = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
                self.navigationController?.pushViewController(tabVC, animated: true
                 )
                print("Login OK")
            }
            
        } else {
            print("falling")
            DispatchQueue.main.async {
                self.showLoginFailure(message: error?.localizedDescription ?? "")
            }
            
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        print(message)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
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
//        loginViaWebsiteButton.isEnabled = !isLoggingIn
    }
}
