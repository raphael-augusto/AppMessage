//
//  ChatNavigationView.swift
//  MessageCursoViewCode
//
//  Created by Raphael Augusto on 23/08/22.
//

import UIKit

class ChatNavigationView: UIView {

    //MARK: - Action Button
    var controller: ChatViewController?{
        didSet {
            self.backButton.addTarget(controller, action: #selector(ChatViewController.tappedBackButton), for: .touchUpInside)
        }
    }
    
    //MARK: - Components UI
    lazy var navViewGroundView: UIView = {
        let view                    = UIView()
        view.backgroundColor        = .white
        view.layer.cornerRadius     = 35
        view.layer.maskedCorners    = [.layerMaxXMaxYCorner]
        view.layer.shadowColor      = UIColor(white: 0, alpha: 0.05).cgColor
        view.layer.shadowOffset     = CGSize(width: 0, height: 10)
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
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var customImage: UIImageView = {
        let image                   = UIImageView()
        image.contentMode           = .scaleAspectFill
        image.clipsToBounds         = true
        image.layer.cornerRadius    = 26
        image.image                 = UIImage(named: "imagem-perfil")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    // MARK: - Init  Components
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        setUpConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Components and Constraints
    private func configureSubviews() {
        addSubview(navViewGroundView)
        navViewGroundView.addSubview(navBar)
        navBar.addSubview(backButton)
        navBar.addSubview(customImage)
        navBar.addSubview(searchBar)
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
            
            backButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            backButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            customImage.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
            customImage.heightAnchor.constraint(equalToConstant: 55),
            customImage.widthAnchor.constraint(equalToConstant: 55),
            customImage.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: customImage.trailingAnchor, constant: 20),
            searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            searchlabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
            searchlabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 20),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}
