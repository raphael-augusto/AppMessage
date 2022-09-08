//
//  Alert.swift
//  LoginViewCode
//
//  Created by Raphael Augusto on 15/08/22.
//

import Foundation
import UIKit

class Alert: NSObject {
    
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    
    func getAlert(title: String, message: String, completion: (() -> Void )? = nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel) { action in
            completion?()
        }
        
        alertController.addAction(cancel)
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
    func addContact(completion:((_ value:String) -> Void)? = nil){
        var _textField:UITextField?
        let alert = UIAlertController(title: "Adicionar Usuario", message: "Digite uma email Valido", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Adicionar", style: .default) { (acao) in
            completion?(_textField?.text ?? "")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            _textField = textField
            textField.placeholder = "Email:"
        })
        
        self.controller.present(alert, animated: true, completion: nil)
    }
}
