//
//  LoginScreen.swift
//  LoginViewCode
//
//  Created by Raphael Augusto on 10/08/22.
//

import UIKit

protocol LoginScreenProtocol: AnyObject {
    func actionLoginButton()
    func actionRegisterButton()
}


class LoginScreen: UIView {
    
    private weak var delegate: LoginScreenProtocol?
    
    func delegate(delegate: LoginScreenProtocol?) {
        self.delegate = delegate
    }
    

    lazy var loginLabel: UILabel = {
        let label       = UILabel()
        label.textColor = .white
        label.font      = UIFont.boldSystemFont(ofSize: 40)
        label.text      = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image           = UIImageView()
        image.image         = UIImage(named: "logo")
        image.contentMode   = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
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
        tf.returnKeyType                = .next
        tf.clearButtonMode              = .whileEditing
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
        tf.returnKeyType                = .done
        tf.clearButtonMode              = .whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button                      = UIButton()
        button.titleLabel?.font         = UIFont.systemFont(ofSize: 18)
        button.clipsToBounds            = true
        button.layer.cornerRadius       = 7.5
        button.backgroundColor          = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        
        button.setTitle("Logar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button                      = UIButton()
        button.titleLabel?.font         = UIFont.systemFont(ofSize: 18)
        
        button.setTitle("Não tem conta? Cadastre-se", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(loginLabel)
        addSubview(logoAppImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    
    public func configureTextFieldDelegate(delegete: UITextFieldDelegate) {
        self.emailTextField.delegate    = delegete
        self.passwordTextField.delegate = delegete
    }
    
    
    public func validatesTextFields() {
        let email:String = self.emailTextField.text ?? ""
        let password:String = self.passwordTextField.text ?? ""
        
        
        if !email.isEmpty && !password.isEmpty {
            configureButtonEnable(true)
        } else {
            configureButtonEnable(false)
        }
    }
    

    private func configureButtonEnable(_ enable:Bool) {
        if enable {
            self.loginButton.setTitleColor(.white, for: .normal)
            self.loginButton.isEnabled = true
        } else {
            self.loginButton.setTitleColor(.lightGray, for: .normal)
            self.loginButton.isEnabled = false
        }
    }
    
    
    public func getEmail() -> String {
        return self.emailTextField.text ?? ""
    }
    
    
    public func getPassword() -> String {
        return self.passwordTextField.text ?? ""
    }
    
    
    @objc private func tappedLoginButton() {
        self.delegate?.actionLoginButton()
    }
    
    
    @objc private func tappedRegisterButton() {
        self.delegate?.actionRegisterButton()
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            logoAppImageView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            logoAppImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            logoAppImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            logoAppImageView.heightAnchor.constraint(equalToConstant: 200),
            
            emailTextField.topAnchor.constraint(equalTo: logoAppImageView.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            registerButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            registerButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
        ])
    }
}
