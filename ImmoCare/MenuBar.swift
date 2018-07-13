//
//  MenuBar.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 17/05/2018.
//  Copyright © 2018 ImmoCare. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuBar: UIView, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    let cellId = "cellId"
    let imageNames = ["registerIcon", "usernameIcon","mailIcon","registerIcon", "usernameIcon"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    
        collectionView.isScrollEnabled = false
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 5, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuCell : BaseCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithFormat("H:[v0(28)]", views: imageView)
        addConstraintsWithFormat("V:[v0(28)]", views: imageView)
        
        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
    }
}
