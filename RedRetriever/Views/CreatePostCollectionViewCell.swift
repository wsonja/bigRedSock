//
//  CreatePostCollectionViewCell.swift
//  A4
//
//  Created by Ethan Seiz on 12/1/24.
//

import UIKit

class CreatePostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    private let postFindButton = UIButton()
    private let postFoundButton = UIButton()
    private let titleLabel = UILabel()
    
    // MARK: - Properties (data)
    static let reuse: String = "CreatePostCollectionViewCellReuseIdentifier"
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.a4.offWhite
        layer.cornerRadius = 16
        
        setupTitleLabel()
        setupPostFindButton()
        // setupPostFoundButton()
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views
    private func setupTitleLabel() {
        titleLabel.text = "Lost an Item?"
            titleLabel.textColor = UIColor.a4.black
            titleLabel.font = .systemFont(ofSize: 20, weight: .medium)

            contentView.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            ])
        }
    
    private func setupPostFindButton() {
            postFindButton.backgroundColor = UIColor.a4.ruby
            postFindButton.layer.cornerRadius = 4
            postFindButton.setTitle("Submit a Lost Ticket ->", for: .normal)
            postFindButton.setTitleColor(UIColor.a4.white, for: .normal)
            postFindButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            // postButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
            
            contentView.addSubview(postFindButton)
            postFindButton.translatesAutoresizingMaskIntoConstraints = false
            
            // let sidePadding: CGFloat = 10
            NSLayoutConstraint.activate([
                postFindButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
                postFindButton.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0),
                postFindButton.widthAnchor.constraint(equalToConstant: 175),
                postFindButton.heightAnchor.constraint(equalToConstant: 32),
            ])
        }
    
    private func setupPostFoundButton() {
            postFoundButton.backgroundColor = UIColor.a4.ruby
            postFoundButton.layer.cornerRadius = 4
            postFoundButton.setTitle("Submit a Found Item ->", for: .normal)
            postFoundButton.setTitleColor(UIColor.a4.white, for: .normal)
            postFoundButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            // postButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
            
            contentView.addSubview(postFoundButton)
            postFoundButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                postFoundButton.topAnchor.constraint(equalTo: postFindButton.bottomAnchor, constant: 5),
                postFoundButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                postFoundButton.widthAnchor.constraint(equalToConstant: 175),
                postFoundButton.heightAnchor.constraint(equalToConstant: 32),
            ])
        }
    
}
