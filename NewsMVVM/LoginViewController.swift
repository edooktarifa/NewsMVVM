//
//  LoginViewController.swift
//  NewsMVVM
//
//  Created by Phincon on 09/07/21.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginBtn.delegate = self
        loginBtn.permissions = ["public_profile", "email"]
        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["field":"email, name"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("result")
            }
        }
        
        // MARK: login with google
        GIDSignIn.sharedInstance()?.presentingViewController = self
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(userDidSignInGoogle(_:)),
                                                       name: .signInGoogleCompleted,
                                                       object: nil)
    }
    
    @IBAction func loginWithGoogle(_ sender: UIButton){
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        // Update screen after user successfully signed in
        updateScreen()
    }
    
    func updateScreen() {
        if let user = GIDSignIn.sharedInstance().currentUser {
            print("my name is \(user.profile.givenName ?? "")")
        }
    }

}

extension LoginViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("result: \(result)")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        let loginManager = LoginManager()
        loginManager.logOut()
    }
}
