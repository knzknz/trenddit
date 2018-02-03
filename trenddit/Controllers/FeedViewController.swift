//
//  FeedViewController.swift
//  trenddit
//
//  Created by Clint M on 1/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    // TODO: complete camera function and complete configureTabBar function.
    
    // MARK: - Constants
    let feedView = FeedView()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        self.view.backgroundColor = Stylesheet.Colors.UltraLightGray
        self.feedView.feedCollectionView.dataSource = self
        self.feedView.feedCollectionView.delegate = self
        self.feedView.categoryCollectionView.dataSource = self
        self.feedView.categoryCollectionView.delegate = self
        addSubView()
        setupView()
        configureTabBar()
//        configureNavBar()
    }
    
    // MARK: - Functions
//    private func configureNavBar() {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
//        let navItem = UINavigationItem(title: "trenddit")
//        navBar.prefersLargeTitles = true
//        let cameraButton = UIBarButtonItem(image: #imageLiteral(resourceName: "photo-camera"), style: .plain, target: self, action: #selector(cameraButtonClicked))
//        navItem.rightBarButtonItem = cameraButton
//        navBar.setItems([navItem], animated: false)
//        self.view.addSubview(navBar)
//
//    }
    
    // TODO: complete camera function
//    @objc func cameraButtonClicked() {
//        print("camera button pressed")
//    }
    
    // TODO : input correct tag etc
    private func configureTabBar() {
        self.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "houses"), tag: 1)
    }
    
    private func addSubView() {
        self.view.addSubview(feedView)
    }
    
    private func setupView() {
        setupFeedView()
    }
    
    private func setupFeedView() {
        feedView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
//    func setNavigationBar() {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
//        let navItem = UINavigationItem(title: "")
//        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(done))
//        navItem.rightBarButtonItem = doneItem
//        navBar.setItems([navItem], animated: false)
//        self.view.addSubview(navBar)
//    }
//
    @objc func done() { // remove @objc for Swift 3
        
    }
    
}

// MARK: - CollectionView Data Source
extension FeedViewController: UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard collectionView == self.feedView.categoryCollectionView else { return 10 }
        return 10 // return count for categoryCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == self.feedView.categoryCollectionView else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedView.postCellID, for: indexPath) as! FeedCollectionViewCell
            // TODO: complete init
            //            cell.configureFeedCell(with: <#T##String#>, and: <#T##UIImage#>)
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedView.categoryCellID, for: indexPath) as! CategoryCollectionViewCell
//        cell.configureCell()

        
        // TODO: complete init
        //        cell.configureCategoryCell(with: <#T##String#>, and: <#T##UIImage#>)
        
        return cell
    }
}

//MARK: CollectionView Delegate method
extension FeedViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard collectionView == self.feedView.categoryCollectionView else {
            let sized = CGSize(width: collectionView.frame.size.width , height: collectionView.frame.size.height / 1.85)
            return sized
        }
        
        let sized = CGSize(width: collectionView.frame.size.width / 4.15, height: collectionView.frame.size.height )
        return sized
    }
}

