//
//  NavView.swift
//  MessageCursoViewCode
//
//  Created by Raphael Augusto on 17/08/22.
//

import UIKit

enum TypeConversationOrContact {
    case conversation
    case contact
}

protocol NavViewProtocol: AnyObject {
    func typeScreenMessage(type: TypeConversationOrContact)
}


class NavView: UIView {

    weak private var delegate: NavViewProtocol?
    
    func delegate(delegate: NavViewProtocol?) {
        self.delegate = delegate
    }
    
    
    lazy var navViewGroundView: UIView = {
        let view                    = UIView()
        view.backgroundColor        = .white
        view.layer.cornerRadius     = 35
        view.layer.maskedCorners    = [.layerMaxXMaxYCorner]
        view.layer.shadowColor      = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset     = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity    = 1
        view.layer.shadowRadius     = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var navBar: UIView = {
        let view              = UIView()
        view.backgroundColor  = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var searchBar: UIView = {
        let view                = UIView()
        view.backgroundColor    = CustomColor.appLight
        view.clipsToBounds      = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var searchlabel: UILabel = {
        let label       = UILabel()
        label.text      = "Digite aqui"
        label.font      = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var conversationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //Action
        button.addTarget(self, action: #selector(tappedConversationButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //Action
        button.addTarget(self, action: #selector(tappedContactionButton), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configureSubviews() {
        addSubview(navViewGroundView)
        navViewGroundView.addSubview(navBar)
        navBar.addSubview(searchBar)
        navBar.addSubview(stackView)
        stackView.addArrangedSubview(conversationButton)
        stackView.addArrangedSubview(contactButton)
        searchBar.addSubview(searchlabel)
        searchBar.addSubview(searchButton)
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            navViewGroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navViewGroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navViewGroundView.topAnchor.constraint(equalTo: topAnchor),
            navViewGroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            navBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            stackView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 30),
            
            searchlabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
            searchlabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
            searchButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


//MARK: - Action Button
extension NavView {
    
    @objc func tappedConversationButton() {
        self.delegate?.typeScreenMessage(type: .conversation)
        self.conversationButton.tintColor = .systemPink
        self.contactButton.tintColor = .black
    }
    
    
    @objc func tappedContactionButton() {
        self.delegate?.typeScreenMessage(type: .contact)
        self.conversationButton.tintColor = .black
        self.contactButton.tintColor = .systemPink
    }
}
