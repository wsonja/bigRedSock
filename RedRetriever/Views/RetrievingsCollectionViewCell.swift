//
//  RetrievingsCollectionViewCell.swift
//  A4
//
//  Created by Ethan Seiz on 12/4/24.
//

import UIKit

class RetrievingsCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties (views)
        private let itemLabel = UILabel()
        
    //MARK: - Properties (Data)
        static let reuse: String = "RetrievingsCollectionViewReuseIdentifier"
        
        
    //MARK: - init
        override init(frame: CGRect) {
            super.init(frame: frame)
            // contentView.backgroundColor = UIColor.a4.ruby
            
            setupItemLabel()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    //MARK: - configure
        func configure(item: Item){
            itemLabel.text = "\(item.name)  • • • • •  +\(item.points)"
        }
        
    //MARK: - setup views
        private func setupItemLabel() {
            itemLabel.textColor = .label
            itemLabel.font = .systemFont(ofSize: 16, weight: .medium)

            contentView.addSubview(itemLabel)
            itemLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
                itemLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            ])
        }
}
