//
//  PostCollectionViewCell.swift
//  RedRetriever
//
//  Created by Ethan Seiz on 12/1/24.
//

import Foundation
import UIKit
import SwiftUI


class PostCollectionViewCell: UICollectionViewCell {
    
//MARK: - Properties (views)
    private let postImageView = UIImageView()
    private let postTitleLabel = UILabel()
    private let postDescriptionLabel = UILabel()
    private let postLocationLabel = UILabel()
    private let postTimeLabel = UILabel()
    
//MARK: - Properties (Data)
    static let reuse: String = "PostCollectionViewReuseIdentifier"
    
    
//MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.a4.white
        
//        setupPostImageView()
        setupPostTitleLabel()
//        setupPostDescriptionLabel()
//        setupPostLocationLabel()
//        setupPostTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - configure
    func configure(post: Post){
        
        // postImageView
        postTimeLabel.text = post.title
        postDescriptionLabel.text = post.description
        postLocationLabel.text = post.location
        postTimeLabel.text = post.time
    }
    
//MARK: - setup views
//    func setupPostImageView(){
//
//        recipeImageView.contentMode = .scaleAspectFit
//        // test the corner radius
//        recipeImageView.layer.cornerRadius = 15.0
//        recipeImageView.clipsToBounds = true
//
//        //add to subview
//        contentView.addSubview(recipeImageView)
//
//        //constraint
//        recipeImageView.snp.makeConstraints{ make in
//            make.top.leading.trailing.equalToSuperview()
//            make.height.equalTo(148)
//        }
//    }
    
    private func setupPostTitleLabel() {
        postTitleLabel.textColor = .label
        postTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
//        postTitleLabel.lineBreakMode = .byWordWrapping
//        postTitleLabel.numberOfLines = 2

        contentView.addSubview(postTitleLabel)
        postTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            postTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}

