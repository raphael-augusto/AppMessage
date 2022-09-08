//
//  LoginViewController.swift
//  LoginViewCode
//
//  Created by Raphael Augusto on 10/08/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var auth:Auth?
    var loginScreen: LoginScreen?
    var alert: Alert?
    
    override func loadView() {
        self.loginScreen    = LoginScreen()
        self.view           = self.loginScreen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.delegate(delegate: self)
        self.loginScreen?.configureTextFieldDelegate(delegete: self)
        
        self.auth   = Auth.auth()
        self.alert  = Alert(controller: self)
        
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
    
    private func createDismissKeyboardTapGesture() {
            let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(tap)
   }
}

//MARK: - TextField

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.validatesTextFields()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - actionButton

extension LoginViewController: LoginScreenProtocol {
    
    func actionLoginButton() {

        guard let login = self.loginScreen else { return }

        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { (user, error)  in

            if error != nil {
                self.alert?.getAlert(title: "Atenção", message: "Dados incorretos, verifique e tente novamente.")
            } else {
                if user == nil {
                    self.alert?.getAlert(title: "Atenção", message: "Tivemos um problema inesperado, tente novamente mais tarde.")
                }else{
                    let homeVC = HomeViewController()
                    let navVC  = UINavigationController(rootViewController: homeVC)
                    navVC.modalPresentationStyle = .fullScreen
                    self.present(navVC, animated: true, completion: nil)
                }
            }
        })
    }
    
    
    func actionRegisterButton() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
