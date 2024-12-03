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
        // contentView.backgroundColor = UIColor.a4.white
        
        setupPostImageView()
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
        
        postImageView.image = UIImage(named: post.image)
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.description
        postLocationLabel.text = post.location
        postTimeLabel.text = post.time
    }
    
//MARK: - setup views
    private func setupPostImageView(){

        postImageView.contentMode = .scaleAspectFit
        // test the corner radius
        // postImageView.layer.cornerRadius = 15.0
        postImageView.clipsToBounds = true

        //add to subview
        contentView.addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false

        //constraint
        NSLayoutConstraint.activate([
            postImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            postImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 156),
            postImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupPostTitleLabel() {
        postTitleLabel.textColor = .label
        postTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
//        postTitleLabel.lineBreakMode = .byWordWrapping
//        postTitleLabel.numberOfLines = 2

        contentView.addSubview(postTitleLabel)
        postTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postTitleLabel.centerXAnchor.constraint(equalTo: postImageView.centerXAnchor, constant: 0),
            postTitleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
        ])
    }
}
