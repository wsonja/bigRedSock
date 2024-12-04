//
//  RequestsCollectionViewCell.swift
//  A4
//
//  Created by Sonja Wong on 4/12/2024.
//


import Foundation
import UIKit
import SwiftUI


class RequestsCollectionViewCell: UICollectionViewCell {
    
//MARK: - Properties (views)
    private let requestStatusLabel = UILabel()
    private let requestDateLabel = UILabel()
    private let requestDescriptionLabel = UILabel()
    
//MARK: - Properties (Data)
    static let reuse: String = "RequestsCollectionViewReuseIdentifier"
    
    
//MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // contentView.backgroundColor = UIColor.a4.white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - configure
    func configure(post: Post){
        requestStatusLabel.text = post.status
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: post.date)
        requestDateLabel.text = dateString
        
        requestDescriptionLabel.text = post.description
    }
    
//MARK: - setup views
    private func setupUI(){

        requestStatusLabel.font = .systemFont(ofSize: 16, weight: .medium)
        requestStatusLabel.textColor = .darkGray
        
        requestDateLabel.font = .systemFont(ofSize: 16, weight: .medium)
        requestDateLabel.textColor = .darkGray
        
        requestDescriptionLabel.font = .systemFont(ofSize: 16, weight: .medium)
        requestDescriptionLabel.textColor = .darkGray
        
        // Set up a horizontal stack view to hold the three labels side by side
        let stackView = UIStackView(arrangedSubviews: [requestStatusLabel, requestDateLabel, requestDescriptionLabel])
        stackView.axis = .horizontal
        stackView.spacing = 16 // Space between labels
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        // Add constraints to make the stack view fill the content of the cell
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
