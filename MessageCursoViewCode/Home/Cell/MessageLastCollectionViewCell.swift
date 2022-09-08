//
//  MessageLastCollectionViewCell.swift
//  MessageCursoViewCode
//
//  Created by Raphael Augusto on 18/08/22.
//

import UIKit

class MessageLastCollectionViewCell: UICollectionViewCell {
    
    static let identifier:String = "MessageLastCollectionViewCell"
    
    
    lazy var imageView: UIImageView = {
        let image           = UIImageView()
        image.contentMode   = .scaleAspectFit
        image.clipsToBounds = false
        image.image         = UIImage(systemName: "person.badge.plus")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var userName: UILabel = {
        let label           = UILabel()
        label.text          = "Adicionar novo contato"
        label.font          = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor     = .darkGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        addSubview(imageView)
        addSubview(userName)
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 55),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            userName.centerYAnchor.constraint(equalTo: centerYAnchor),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
