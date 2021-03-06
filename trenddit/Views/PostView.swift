//
//  PostView.swift
//  trenddit
//
//  Created by C4Q on 1/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class PostView: UIView {
    
    //set up the objects
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        //imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = self.bounds.width * 0.20 * 0.5
        return imageView
    }()
    
    lazy var userNameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear //for testing
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.red, for: .selected)
        button.setTitle("username", for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Bold, size: 18)//button.titleLabel?.font.withSize(18)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing = UIScreen.main.bounds.width * 0.02
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = numberOfCells + 1
        layout.itemSize = CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) * 0.25 / numberOfCells, height: screenHeight * 0.12)
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "category cell" )
        return collectionView
    }()
    
    
    lazy var createPostTF: UITextField = {
        var tf = UITextField()
        tf.borderStyle = .none
        tf.placeholder = "Post text here ..."
        tf.textColor = .black
        tf.backgroundColor = UIColor.white
        tf.font = UIFont(name: Stylesheet.Fonts.Light, size: 14)
        //TODO: How to make it wrap and limit charaters?
        return tf
    }()
    
    lazy var addImgButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addImage2"), for: .normal)
        //button.backgroundColor = .blue
        //button.setImage(#imageLiteral(resourceName: "photo-picker"), for: .normal)
        button.alpha = 0.15
        return button
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton()
        button.setTitle("POST", for: .normal)
        button.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Light, size: 20)
        button.backgroundColor = Stylesheet.Colors.Blue
        button.setTitleShadowColor(.magenta, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        return button
    }()
    
    //Required Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setViews()
        backgroundColor = .white
        
    }
    
    //Constraining Objects using SnapKit
    func setViews(){
        setCategoryCollectionView()
        setUserProfileImage()
        setUsernameButton()
        setTextField()
        setAddImageButton()
        setPostButton()
    }
    
    private func setCategoryCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(30)
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.05)//0.15
        }
    }
    
    private func setUserProfileImage() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints{ make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.left.equalTo(snp.left).offset(10)
            make.size.equalTo(self.snp.width).multipliedBy(0.2)

        }
    }
    
    private func setUsernameButton() {
        addSubview(userNameButton)
        userNameButton.snp.makeConstraints{(make) in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(10)
//            make.height.equalTo(self).multipliedBy(0.05)
            make.width.equalTo(self.snp.width).multipliedBy(0.30)
        }
    }
    
    private func setTextField() {
        addSubview(createPostTF)
        createPostTF.snp.makeConstraints{(make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).dividedBy(14)
            make.centerX.equalTo(self.snp.centerX)
       }
    }
    
    private func setAddImageButton() {
        addSubview(addImgButton)
        addImgButton.snp.makeConstraints{(make) in
            make.size.equalTo(250)
            make.bottom.equalTo(snp.bottom).offset(-180)
            make.centerX.equalTo(snp.centerX)
        //        addImgButton.snp.makeConstraints{(make) in
        //            make.top.equalTo(createPostTF.snp.bottom)
        //            make.size.equalTo(self.snp.width).multipliedBy(0.15)//0.9
        //            make.centerX.equalTo(snp.centerX)
        //        }
            //            make.centerY.equalTo(snp.centerY)
        }
    }
    
    private func setPostButton() {
        addSubview(postButton)
        postButton.snp.makeConstraints{(make) in
            make.bottom.equalTo(snp.bottom).offset(-90)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)//0.1
            make.centerX.equalTo(self.snp.centerX)
        }
//        postButton.snp.makeConstraints{(make) in
//            make.bottom.equalTo(snp.bottom)
//            make.width.equalTo(self.snp.width).multipliedBy(0.8)
//            make.height.equalTo(self.snp.height).multipliedBy(0.05)//0.1
//            make.centerX.equalTo(self.snp.centerX)
//        }
    }
    
    
    
    
}



