//
//  HomeScreen.swift
//  MessageCursoViewCode
//
//  Created by Raphael Augusto on 17/08/22.
//

import UIKit

class HomeScreen: UIView {

    lazy var navView: NavView = {
        let view = NavView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor              = .clear
        collection.delaysContentTouches         = false
        
        let layout:UICollectionViewFlowLayout   = UICollectionViewFlowLayout.init()
        layout.scrollDirection                  = .vertical
        
        collection.setCollectionViewLayout(layout, animated: false)
        
        collection.register(MessageLastCollectionViewCell.self, forCellWithReuseIdentifier: MessageLastCollectionViewCell.identifier)
        collection.register(MessageDetailCollectionViewCell.self, forCellWithReuseIdentifier: MessageDetailCollectionViewCell.identifier)
        
        return collection
    }()
    
    
    public func delegateCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.collectionView.delegate    = delegate
        self.collectionView.dataSource  = dataSource
    }
    
    
    public func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configureSubviews() {
        addSubview(navView)
        addSubview(collectionView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: topAnchor),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 140),
            
            collectionView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
