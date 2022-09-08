//
//  RegisterScreen.swift
//  LoginViewCode
//
//  Created by Raphael Augusto on 11/08/22.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func actionBackButton()
    func actionRegisterButton()
}

class RegisterScreen: UIView {
    
    weak private var delegate:RegisterScreenProtocol?
    
    func delegate(delegate: RegisterScreenProtocol?) {
        self.delegate = delegate
    }
    

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back")?.withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //Action
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var imageAddUser: UIImageView = {
        let image           = UIImageView()
        image.image         = UIImage(named: "usuario")
        image.contentMode   = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var nameTextField: UITextField = {
        let tf                          = UITextField()
        tf.autocorrectionType           = .no
        tf.backgroundColor              = .systemBackground
        tf.borderStyle                  = .roundedRect
        tf.keyboardType                 = .namePhonePad
        tf.placeholder                  = "Digite seu nome"
        tf.textColor                    = .darkGray
        tf.autocapitalizationType       = .none
//        tf.returnKeyType                = .next
        tf.clearButtonMode              = .whileEditing
        tf.font                         = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    lazy var emailTextField: UITextField = {
        let tf                          = UITextField()
        tf.autocorrectionType           = .no
        tf.backgroundColor              = .systemBackground
        tf.borderStyle                  = .roundedRect
        tf.keyboardType                 = .emailAddress
        tf.placeholder                  = "Digite seu email"
        tf.textColor                    = .darkGray
        tf.autocapitalizationType       = .none
//        tf.returnKeyType                = .next
        tf.clearButtonMode              = .whileEditing
        tf.font                         = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf                          = UITextField()
        tf.autocorrectionType           = .no
        tf.backgroundColor              = .systemBackground
        tf.borderStyle                  = .roundedRect
        tf.keyboardType                 = .default
        tf.placeholder                  = "Digite sua senha"
        tf.textColor                    = .darkGray
        tf.autocapitalizationType       = .none
        tf.textContentType              = .password
        tf.isSecureTextEntry            = true
//        tf.returnKeyType                = .done
        tf.clearButtonMode              = .whileEditing
        tf.font                         = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    lazy var registerButton: UIButton = {
        let button                  = UIButton()
        button.clipsToBounds        = true
        button.layer.cornerRadius   = 7.5
        button.backgroundColor      = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //Action
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureSubviews()
        setUpConstraints()
        configureButtonEnable(false)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
    }
 
    
    private func configureSubviews() {
        addSubview(backButton)
        addSubview(imageAddUser)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerButton)
    }
    
    
    public func configureTextFieldDelegate(delegate:UITextFieldDelegate) {
        self.nameTextField.delegate     = delegate
        self.emailTextField.delegate    = delegate
        self.passwordTextField.delegate = delegate
    }
    
    
    @objc private func tappedBackButton() {
        self.delegate?.actionBackButton()
    }
    
    
    @objc private func tappedRegisterButton() {
        self.delegate?.actionRegisterButton()
    }
    
    
    public func validatesTextFields() {
        let name:String     = self.nameTextField.text ?? ""
        let email:String    = self.emailTextField.text ?? ""
        let password:String = self.passwordTextField.text ?? ""
        
        
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            configureButtonEnable(true)
        } else {
            configureButtonEnable(false)
        }
    }
    

    private func configureButtonEnable(_ enable:Bool) {
        if enable {
            self.registerButton.setTitleColor(.white, for: .normal)
            self.registerButton.isEnabled = true
        } else {
            self.registerButton.setTitleColor(.lightGray, for: .normal)
            self.registerButton.isEnabled = false
        }
    }
    
    
    public func getName() -> String {
        return self.nameTextField.text ?? ""
    }
    
    
    public func getEmail() -> String {
        return self.emailTextField.text ?? ""
    }
    
    
    public func getPassword() -> String {
        return self.passwordTextField.text ?? ""
    }
    
    private func setUpConstraints() {
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            imageAddUser.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            imageAddUser.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageAddUser.widthAnchor.constraint(equalToConstant: 150),
            imageAddUser.heightAnchor.constraint(equalToConstant: 150),

            backButton.topAnchor.constraint(equalTo: imageAddUser.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            nameTextField.topAnchor.constraint(equalTo: imageAddUser.bottomAnchor, constant: padding),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),

            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),

            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
            registerButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            registerButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
        ])
    }
}
