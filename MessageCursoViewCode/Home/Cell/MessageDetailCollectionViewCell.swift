//
//  MessageDetailCollectionViewCell.swift
//  MessageCursoViewCode
//
//  Created by Raphael Augusto on 19/08/22.
//

import UIKit

class MessageDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier:String = "MessageDetailCollectionViewCell"
    
    
    lazy var imageView: UIImageView = {
        let image                = UIImageView()
        image.contentMode        = .scaleAspectFit
        image.clipsToBounds      = true
        image.layer.cornerRadius = 26
        image.image              = UIImage(named: "imagem-perfil")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var userName: UILabel = {
        let label           = UILabel()
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
    
    
    func setupViewContact(contact:Contact) {
        setUserName(userName: contact.nome ?? "")
    }
    
    func setupViewConversation(conversation:Conversation) {
        setUserNameAttributedText(conversation)
    }
    
    
    func setUserNameAttributedText(_ conversation: Conversation){
        let attributedText = NSMutableAttributedString(string:"\(conversation.nome ?? "")" , attributes:[NSAttributedString.Key.font: UIFont(name:CustomFont.poppinsMedium, size: 16) ?? UIFont(),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        attributedText.append(NSAttributedString(string: "\n\(conversation.ultimaMensagem ?? "")" , attributes:[NSAttributedString.Key.font: UIFont(name:CustomFont.poppinsMedium, size: 14) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        self.userName.attributedText = attributedText
    }
    
    
    func setUserName(userName:String){
        let attributText = NSMutableAttributedString(string: userName, attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        
        self.userName.attributedText = attributText
    }
}
