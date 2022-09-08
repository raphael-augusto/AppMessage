//
//  RegisterViewController.swift
//  LoginViewCode
//
//  Created by Raphael Augusto on 11/08/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    var registerScreen: RegisterScreen?
    
    var auth:Auth?
    var firastore:Firestore?
    var alert: Alert?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configureTextFieldDelegate(delegate: self)
        self.registerScreen?.delegate(delegate: self)
        
        self.auth       = Auth.auth()
        self.firastore  = Firestore.firestore()
        self.alert      = Alert(controller: self)
        
        createDismissKeyboardTapGesture()
    }
    
    private func createDismissKeyboardTapGesture() {
            let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(tap)
   }
}


//MARK: - Delegete TextField
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.validatesTextFields()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


//MARK: - Action Button
extension RegisterViewController: RegisterScreenProtocol {
    
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton() {
        
        guard let register = self.registerScreen else { return }
        
        //authentication
        self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { (result, error) in
            if error != nil {
                self.alert?.getAlert(title: "Atenção", message: "Error ao cadastrar")
            } else {
                
                //fireStore - create dataBase (user)
                if let idUsuario = result?.user.uid {
                    self.firastore?.collection("usuarios").document(idUsuario).setData([
                        "nome": self.registerScreen?.getName() ?? "",
                        "email": self.registerScreen?.getEmail() ?? "",
                        "id": idUsuario
                    ])
                }
                
                self.alert?.getAlert(title: "Parabéns", message: "Usuário cadastrado com sucesso.", completion: {
                    let homeVC = HomeViewController()
                    let navVC  = UINavigationController(rootViewController: homeVC)
                    navVC.modalPresentationStyle = .fullScreen
                    self.present(navVC, animated: true, completion: nil)
                })
            }
        })
    }
}
