//
//  OutgoingTextMessageTableViewCell.swift
//  MessageCursoViewCode
//
//  Created by Raphael Augusto on 27/08/22.
//

import UIKit

class OutgoingTextMessageTableViewCell: UITableViewCell {

    static let identifier:String = "OutgoingTextMessageTableViewCell"
    
    lazy var myMessageView: UIView = {
        let view                 = UIView()
        view.backgroundColor     = CustomColor.appPurple
        view.layer.cornerRadius  = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var messageTextLabel: UILabel = {
        let label           = UILabel()
        label.numberOfLines = 0
        label.textColor     = .white
        label.font          = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components and Constraints
    private func configureSubviews() {
        addSubview(myMessageView)
        myMessageView.addSubview(messageTextLabel)
        
        self.isSelected = false
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            myMessageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            myMessageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            myMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageTextLabel.leadingAnchor.constraint(equalTo: myMessageView.leadingAnchor, constant: 15),
            messageTextLabel.topAnchor.constraint(equalTo: myMessageView.topAnchor, constant: 15),
            messageTextLabel.bottomAnchor.constraint(equalTo: myMessageView.bottomAnchor, constant: -15),
            messageTextLabel.trailingAnchor.constraint(equalTo: myMessageView.trailingAnchor, constant: -15),
        ])
    }
    
    
    public func setupCell(message: Message?) {
        self.messageTextLabel.text = message?.texto ?? ""
    }

}
