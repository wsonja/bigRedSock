//
//  PostVC.swift
//  A4
//
//  Created by Ethan Seiz on 12/3/24.
//

import Foundation
import UIKit
import SDWebImage

class ItemVC: UIViewController {
    
    // MARK: - Properties (view)
    private let postImage = UIImageView()
    private let postTitle = UILabel()
    private let postDescription = UILabel()
    private let postLocation = UILabel()
    private let postTime = UILabel()
    private let postQuestion = UILabel()
    private let yesButton = UIButton()
    private let noButton = UIButton()
    
    // MARK: - Properties (data)
    private var posts: [Post] = Post.dummyData
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "We found a match!"
        view.backgroundColor = UIColor.white
        
        // navigationController?.navigationBar.prefersLargeTitles = false
        
//        self.navigationController?.navigationBar.titleTextAttributes = [
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold), // Adjust size and style as needed
//                NSAttributedString.Key.foregroundColor: UIColor.black // Adjust color if necessary
//            ]
//
        setupPostQuestion()
        setupPostImage()
        setupPostTitle()
        setupPostTime()
        setupPostLocation()
        // setupPostDescription()
        setupYesButton()
        setupNoButton()
    }
    
    
    // MARK: - configure
    
    func configure(post: Post) {
        postImage.image = UIImage(named: post.image)
        postTitle.text = post.title
        postDescription.text = "Item Description " + post.description
        postLocation.text = "Location Found: " + post.location
        postTime.text = "Date Found: " + post.time
    }
    
    
    // MARK: - Set Up Views
    private func setupPostQuestion() {
        postQuestion.text = "Is this your item?"
        postQuestion.textColor = .label
        postQuestion.font = .systemFont(ofSize: 18, weight: .light)
        
        view.addSubview(postQuestion)
        postQuestion.translatesAutoresizingMaskIntoConstraints = false
        
        // 5. Set Up Constraints
        NSLayoutConstraint.activate([
            postQuestion.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            postQuestion.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupPostImage() {
        postImage.contentMode = .scaleAspectFit
        postImage.clipsToBounds = true
        postImage.layer.cornerRadius = 20
        postImage.layer.masksToBounds = true
        
        view.addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: postQuestion.bottomAnchor, constant: 20),
            postImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 20),
            postImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: -20),
            postImage.heightAnchor.constraint(equalToConstant: 303),
            postImage.widthAnchor.constraint(equalToConstant: 303),
        ])
    }
    
    private func setupPostTitle() {
        postTitle.textColor = .label
        postTitle.font = .systemFont(ofSize: 24, weight: .medium)
        // postTitle.lineBreakMode = .byWordWrapping
        // postTitle.numberOfLines = 10
        
        view.addSubview(postTitle)
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        
        // 5. Set Up Constraints
        NSLayoutConstraint.activate([
            postTitle.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 20),
            postTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupPostTime() {
        postTime.textColor = .label
        postTime.font = .systemFont(ofSize: 18, weight: .medium)
        
        view.addSubview(postTime)
        postTime.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postTime.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 35),
            postTime.leadingAnchor.constraint(equalTo: postImage.leadingAnchor, constant: 70)
        ])
    }
    
    private func setupPostLocation() {
        postLocation.textColor = .label
        postLocation.font = .systemFont(ofSize: 18, weight: .medium)

        view.addSubview(postLocation)
        postLocation.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postLocation.topAnchor.constraint(equalTo: postTime.bottomAnchor, constant: 20),
            postLocation.leftAnchor.constraint(equalTo: postTime.leftAnchor, constant: 0)
        ])
    }
    
    private func setupYesButton() {
            yesButton.backgroundColor = UIColor.a4.ruby
            yesButton.layer.cornerRadius = 4
            yesButton.setTitle("Yes", for: .normal)
            yesButton.setTitleColor(UIColor.a4.white, for: .normal)
            yesButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            // postButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
            
            view.addSubview(yesButton)
            yesButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                yesButton.topAnchor.constraint(equalTo: postLocation.topAnchor, constant: 40),
                yesButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
                yesButton.widthAnchor.constraint(equalToConstant: 100),
                yesButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        }
    
    private func setupNoButton() {
            noButton.backgroundColor = UIColor.a4.ruby
            noButton.layer.cornerRadius = 4
            noButton.setTitle("No", for: .normal)
            noButton.setTitleColor(UIColor.a4.white, for: .normal)
            noButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            // postButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
            
            view.addSubview(noButton)
            noButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                noButton.topAnchor.constraint(equalTo: postLocation.topAnchor, constant: 40),
                noButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
                noButton.widthAnchor.constraint(equalToConstant: 100),
                noButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        }
}

