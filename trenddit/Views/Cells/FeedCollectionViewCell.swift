//
//  FeedCollectionViewCell.swift
//  trenddit
//
//  Created by Clint M on 1/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol FeedCellDelegate: class {
    func upVotePressed(post: Post)
    func downVotePressed(post: Post)
    func userNamePressed()
    func categoryPressed()
    func titlePressed()
    func profileImagePressed()
    func postImagePressed()
    func commentPressed(post: Post)
    func optionsPressed()
    func shareButtonPressed()
    func flagUser()
    func flagPost()
}

class FeedCollectionViewCell: UICollectionViewCell {
    
    var post: Post!
    
    // MARK: - Outlets
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = self.bounds.width * 0.15 * 0.5
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        return imageView
    }()
    
    lazy var userNameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Stylesheet.Colors.White
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.red, for: .selected)
        button.setTitle("username", for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Light, size: 14)
        button.addTarget(self, action: #selector(segueToProfile), for: .touchUpInside)
        return button
    }()
    
    lazy var postCategoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Stylesheet.Colors.White
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.red, for: .selected)
        button.setTitle("category", for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Thin, size: 12)
        button.addTarget(self, action: #selector(changeFeedToCategory), for: .touchUpInside)
        return button
    }()
    
    lazy var postOptionsButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setImage(#imageLiteral(resourceName: "more"), for: .normal)
        button.addTarget(self, action: #selector(displayOptionsbuttonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Stylesheet.Colors.White
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.red, for: .selected)
        button.setTitle("this is the post header", for: .normal)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = UIFont(name: Stylesheet.Fonts.Bold, size: 16)
        button.addTarget(self, action: #selector(replyToPostButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "feedPlaceHolder")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(postImageTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        return imageView
    }()
    
    lazy var upVoteButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setImage(#imageLiteral(resourceName: "up-arrow"), for: .normal)
        button.addTarget(self, action: #selector(upVoteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var totalVotesLabel: UILabel = {
        let label = UILabel()
        label.text = "13.1k"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 9, weight: .regular)
        
        return label
    }()
    
    lazy var downVoteButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)
        button.addTarget(self, action: #selector(downVoteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var replyToPostButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setImage(#imageLiteral(resourceName: "chat"), for: .normal)
        button.addTarget(self, action: #selector(replyToPostButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var totalRepliesLabel: UILabel = {
        let label = UILabel()
        label.text = "253"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 9, weight: .regular)
        return label
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.addTarget(self, action: #selector(shareOptionsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var shareLabel: UILabel = {
        let label = UILabel()
        label.text = "Share"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 9, weight: .regular)
        return label
    }()
    
    weak var delegate: FeedCellDelegate?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        addSubviews()
        setupViews()
    }

    
//    //Delegate
//    var delegate: Router!
//
//    var post: Post!
    
    // required. Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        addSubviews()
        setupViews()
    }
    
    //MARK: - Functions
    private func commonInit() {
        backgroundColor = Stylesheet.Colors.White
    }
    
    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(userNameButton)
        addSubview(postCategoryButton)
        addSubview(postOptionsButton)
        addSubview(titleButton)
        addSubview(postImageView)
        addSubview(upVoteButton)
        addSubview(totalVotesLabel)
        addSubview(downVoteButton)
        addSubview(replyToPostButton)
        addSubview(totalRepliesLabel)
        addSubview(shareButton)
        addSubview(shareLabel)
    }
    
    private func setupViews() {
        setupProfileImageView()
        setupUserNameButton()
        setupPostCategoryButton()
        setupPostOptionsButton()
        setupTitleButton()
        setupPostImageView()
        setupUpVoteButton()
        setupTotalVotesLabel()
        setupDownVoteButton()
        setupReplyToPostButton()
        setupTotalRepliesLabel()
        setupShareButton()
        setupShareLabel()
    }
    
    // delegates
    @objc private func changeFeedToCategory() {
        delegate?.categoryPressed()
    }
    
    @objc private func segueToProfile() {
        delegate?.profileImagePressed()
        print("segue to profile delegate")
    }
    
    @objc public func profileImageTapped(sender: UIImageView, target:UIViewController) {
        print("profile image delegate")
        delegate?.profileImagePressed()
    }
    
    @objc public func postImageTapped(sender: UIImageView, target:UIViewController) {
        print("post image delegate")
        delegate?.postImagePressed()
    }
    
    @objc private func displayOptionsbuttonPressed() {
        delegate?.optionsPressed()
    }
    
    @objc private func upVoteButtonPressed() {
        delegate?.upVotePressed(post: post)
    }
    
    @objc private func downVoteButtonPressed() {
        delegate?.downVotePressed(post: post)
    }
    
    @objc private func replyToPostButtonPressed() {
        delegate?.commentPressed(post: post)
//        print("test")

    }
    
    @objc private func shareOptionsButtonPressed() {
        delegate?.shareButtonPressed()
    }
    
    // MARK: - Snapkit constraints
    private func setupProfileImageView() {
        profileImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left).offset(10)
            make.size.equalTo(self.snp.width).multipliedBy(0.15)
        }
    }
    
    private func setupUserNameButton() {
        userNameButton.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.top).offset(2)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.height.equalTo(profileImageView.snp.height).multipliedBy(0.3)
            make.width.equalTo(self).multipliedBy(0.3)
        }
    }
    
    private func setupPostCategoryButton() {
        postCategoryButton.snp.makeConstraints { (make) in
            make.top.equalTo(userNameButton.snp.bottom).offset(5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.height.equalTo(profileImageView.snp.height).multipliedBy(0.3)
            make.width.equalTo(self).multipliedBy(0.3)
        }
    }
    
    private func setupPostOptionsButton() {
        postOptionsButton.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.top)
            make.trailing.equalTo(snp.trailing).inset(5)
            make.width.equalTo(self).multipliedBy(0.05)
            make.height.equalTo(self).multipliedBy(0.08)
        }
    }
    
    private func setupTitleButton() {
        titleButton.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(2)
            make.leading.equalTo(profileImageView.snp.leading).offset(13)
            make.trailing.equalTo(self)
        }
    }
    
    private func setupPostImageView() {
        postImageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleButton.snp.bottom).offset(3)
            make.size.equalTo(self.snp.size).multipliedBy(0.5)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupUpVoteButton() {
        upVoteButton.snp.makeConstraints { (make) in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.leading.equalTo(titleButton.snp.leading)
            make.height.width.equalTo(snp.height).multipliedBy(0.05)
        }
    }
    
    private func setupTotalVotesLabel() {
        totalVotesLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(upVoteButton.snp.centerY)
            make.leading.equalTo(upVoteButton.snp.trailing).offset(8)
            make.height.equalTo(upVoteButton).multipliedBy(0.8)
        }
    }
    
    private func setupDownVoteButton() {
        downVoteButton.snp.makeConstraints { (make) in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.leading.equalTo(totalVotesLabel.snp.trailing).offset(8)
            make.height.width.equalTo(snp.height).multipliedBy(0.05)
        }
    }
    
    private func setupReplyToPostButton() {
        replyToPostButton.snp.makeConstraints { (make) in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.leading.equalTo(snp.centerX).inset(-10)
            make.height.equalTo(self).multipliedBy(0.05)
            make.width.equalTo(self).multipliedBy(0.037)
        }
    }
    
    private func setupTotalRepliesLabel() {
        totalRepliesLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(upVoteButton.snp.centerY)
            make.leading.equalTo(replyToPostButton.snp.trailing).offset(8)
            make.height.equalTo(upVoteButton).multipliedBy(0.8)
        }
    }
    
    private func setupShareButton() {
        shareButton.snp.makeConstraints { (make) in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.trailing.equalTo(shareLabel.snp.leading).inset(-10)
            make.height.equalTo(self).multipliedBy(0.05)
            make.width.equalTo(self).multipliedBy(0.037)
        }
    }
    
    private func setupShareLabel() {
        shareLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(upVoteButton.snp.centerY)
            make.leading.equalTo(self.snp.trailing).inset(40)
            make.height.equalTo(upVoteButton).multipliedBy(0.8)
        }
    }
    
        // function for configuring cell from viewController
        public func configureFeedCell(with postInfo: Post) {
            if let photoUrl = URL(string: postInfo.userPhotoURL) {
                profileImageView.kf.setImage(with: photoUrl)
            }
            postImageView.kf.setImage(with: URL(string: postInfo.image!), placeholder: #imageLiteral(resourceName: "feedPlaceHolder"))
            userNameButton.setTitle(postInfo.creator, for: .normal)
            titleButton.setTitle(postInfo.title, for: .normal)
            postCategoryButton.setTitle(postInfo.category.reduce("", {$0 + $1 + " "}), for: .normal)
            totalVotesLabel.text = String(postInfo.totalVotes)
            totalRepliesLabel.text = String(postInfo.amountOfComments)
        }
    
}
