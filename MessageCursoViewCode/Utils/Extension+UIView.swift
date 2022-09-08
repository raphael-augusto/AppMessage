//
//  UIView.swift
//  MessageCursoViewCode
//
//  Created by Raphael Augusto on 17/08/22.
//

import UIKit

extension UIView {
    func pin(to superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
}
