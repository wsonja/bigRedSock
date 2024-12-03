//
//  CreatePostCollectionViewCell.swift
//  A4
//
//  Created by Ethan Seiz on 12/1/24.
//

import UIKit

class CreatePostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    private let postButton = UIButton()
    
    // MARK: - Properties (data)
    static let reuse: String = "CreatePostCollectionViewCellReuse"
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.a4.offWhite
        layer.cornerRadius = 16
        
        setupPostButton()
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views
    private func setupPostButton() {
            postButton.backgroundColor = UIColor.a4.ruby
            postButton.layer.cornerRadius = 4
            postButton.setTitle("Create Post", for: .normal)
            postButton.setTitleColor(UIColor.a4.white, for: .normal)
            postButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            // postButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
            
            contentView.addSubview(postButton)
            postButton.translatesAutoresizingMaskIntoConstraints = false
            
            let sidePadding: CGFloat = 24
            NSLayoutConstraint.activate([
//                postButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
//                postButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -sidePadding),
                postButton.widthAnchor.constraint(equalToConstant: 96),
                postButton.heightAnchor.constraint(equalToConstant: 32),
                // postButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32)
                postButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), 
                postButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                
            ])
        }
    
}
