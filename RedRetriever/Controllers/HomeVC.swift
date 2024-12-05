//
//  HomeVC.swift
//  RedRetriever
//
//  Created by Ethan Seiz on 12/1/24.
//

import Foundation
import UIKit

class HomeVC: UIViewController, CreateRequestDelegate, FoundDelegate, MatchedDelegate {
    func didUpdateProfile(with num: Int) {
        itemNumLabel.text = "No. of items: " + String(num)
    }
    

    // MARK: - Properties (view)
    private var postCollectionView: UICollectionView!
    private var createPostCollectionView: UICollectionView!
    private let createRequestButton = UIButton()
    private let foundButton = UIButton()
    private let requestsButton = UIButton()
    private let requestDetailButton = UIButton()
    private let profileButton = UIButton()
    private let matchedButton = UIButton()
    private let itemNumLabel = UILabel()
    
    // MARK: - Properties (data)
    private var posts = Post.dummyData
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.white
        
        
        setupPostCollectionView()
        setupcreateRequestButton()
        setupfoundButton()
        setupRequestsButton()
        setupRequestDetailButton()
        setupProfileButton()
        setupMatchedButton()
        // setupCreatePostCollectionView()
    }
    
    // MARK: - Set Up Views
    private func setupPostCollectionView() {
        let padding = 20
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 0
        
        // Initialize CollectionView with the layout
        postCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        postCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.reuse)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        
//        collectionView.backgroundColor = .red
        
        postCollectionView.alwaysBounceVertical = true
        
        view.addSubview(postCollectionView)
        
        //postCollectionView.refreshControl = refreshControl
        
        postCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(padding)),
            postCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-padding)),
            postCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            postCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 300)
        ])
    }
    
    private func setupCreatePostCollectionView() {
        let padding = 20
        let layout = UICollectionViewFlowLayout()
        
        // layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        // Initialize CollectionView with the layout
        createPostCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        createPostCollectionView.register(CreatePostCollectionViewCell.self, forCellWithReuseIdentifier: CreatePostCollectionViewCell.reuse)
        createPostCollectionView.delegate = self
        createPostCollectionView.dataSource = self
        
//        collectionView.backgroundColor = .red
        
        createPostCollectionView.alwaysBounceVertical = true
        
        view.addSubview(createPostCollectionView)
        
        //postCollectionView.refreshControl = refreshControl
        createPostCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createPostCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(padding)),
            createPostCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-padding)),
            createPostCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(padding)),
//            createPostCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupMatchedButton() {
        matchedButton.setTitle("Match", for: .normal)
        matchedButton.setTitleColor(UIColor.white, for: .normal)
        matchedButton.backgroundColor = UIColor(red: 0.79, green: 0.26, blue: 0.22, alpha: 1.00)
        matchedButton.layer.cornerRadius = 16

        view.addSubview(matchedButton)
        matchedButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            matchedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -422),
            matchedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            matchedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            matchedButton.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        matchedButton.addTarget(self, action: #selector(matchedTapped), for: .touchUpInside)
    }
    
    @objc func matchedTapped() {
        let MatchedVC = MatchedVC()
        navigationController?.pushViewController(MatchedVC, animated: true)
    }
    
    private func setupProfileButton() {
        profileButton.setTitle("Profile", for: .normal)
        profileButton.setTitleColor(UIColor.white, for: .normal)
        profileButton.backgroundColor = UIColor(red: 0.79, green: 0.26, blue: 0.22, alpha: 1.00)
        profileButton.layer.cornerRadius = 16

        view.addSubview(profileButton)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -422),
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            profileButton.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
    }
    
    @objc func profileTapped() {
        let ProfileVC = ProfileVC()
        navigationController?.pushViewController(ProfileVC, animated: true)
    }
    
    private func setupRequestDetailButton() {
        requestDetailButton.setTitle("Request details", for: .normal)
        requestDetailButton.setTitleColor(UIColor.white, for: .normal)
        requestDetailButton.backgroundColor = UIColor(red: 0.79, green: 0.26, blue: 0.22, alpha: 1.00)
        requestDetailButton.layer.cornerRadius = 16

        view.addSubview(requestDetailButton)
        requestDetailButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            requestDetailButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -332),
            requestDetailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            requestDetailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            requestDetailButton.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        requestDetailButton.addTarget(self, action: #selector(requestDetailTapped), for: .touchUpInside)
    }
    
    @objc func requestDetailTapped() {
        let RequestDetailVC = RequestDetailVC()
        navigationController?.pushViewController(RequestDetailVC, animated: true)
    }
    
    private func setupRequestsButton() {
        requestsButton.setTitle("Your Requests", for: .normal)
        requestsButton.setTitleColor(UIColor.white, for: .normal)
        requestsButton.backgroundColor = UIColor(red: 0.79, green: 0.26, blue: 0.22, alpha: 1.00)
        requestsButton.layer.cornerRadius = 16

        view.addSubview(requestsButton)
        requestsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            requestsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -242),
            requestsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            requestsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            requestsButton.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        requestsButton.addTarget(self, action: #selector(requestsTapped), for: .touchUpInside)
    }
    
    @objc func requestsTapped() {
        let RequestsVC = RequestsVC()
        navigationController?.pushViewController(RequestsVC, animated: true)
    }
    
    
    
    private func setupcreateRequestButton() {
        createRequestButton.setTitle("Create Request", for: .normal)
        createRequestButton.setTitleColor(UIColor.white, for: .normal)
        createRequestButton.backgroundColor = UIColor(red: 0.79, green: 0.26, blue: 0.22, alpha: 1.00)
        createRequestButton.layer.cornerRadius = 16

        view.addSubview(createRequestButton)
        createRequestButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createRequestButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -152),
            createRequestButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            createRequestButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            createRequestButton.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        createRequestButton.addTarget(self, action: #selector(createRequestTapped), for: .touchUpInside)
    }
    
    
    @objc func createRequestTapped() {
        let CreateRequestVC = CreateRequestVC(name: "String", email: "String", phone: "12", date: Date(), location: "String", desc: "String")
        CreateRequestVC.delegate = self
        navigationController?.pushViewController(CreateRequestVC, animated: true)
    }
    
    
    private func setupfoundButton() {
        foundButton.setTitle("Found Item", for: .normal)
        foundButton.setTitleColor(UIColor.white, for: .normal)
        foundButton.backgroundColor = UIColor(red: 0.79, green: 0.26, blue: 0.22, alpha: 1.00)
        foundButton.layer.cornerRadius = 16

        view.addSubview(foundButton)
        foundButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foundButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            foundButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            foundButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            foundButton.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        foundButton.addTarget(self, action: #selector(foundTapped), for: .touchUpInside)
    }
    
    @objc func foundTapped() {
        let FoundVC = FoundVC(name: "String", date: Date(), location: "String", desc: "String")
        FoundVC.delegate = self
        navigationController?.pushViewController(FoundVC, animated: true)
    }
  
}

// MARK: - UICollectionView DataSource
extension HomeVC: UICollectionViewDataSource {
    
    // MainCollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.createPostCollectionView {
            return 1
        }
        return posts.count
        // return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.createPostCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreatePostCollectionViewCell.reuse, for: indexPath) as? CreatePostCollectionViewCell else { return UICollectionViewCell() }
            return cell 
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuse, for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }

        cell.configure(post: self.posts[indexPath.row])
        return cell
        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreatePostCollectionViewCell.reuse, for: indexPath) as? CreatePostCollectionViewCell else { return UICollectionViewCell() }
//        return cell
        }
    }


// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.createPostCollectionView {
            let widthSize = collectionView.frame.width
            let heightSize = collectionView.frame.height
            return CGSize(width: widthSize, height: heightSize)
        }
        let size = collectionView.frame.width / 2 - 14
        return CGSize(width: size, height: size)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
}

protocol CreateRequestDelegate: AnyObject {
    func didUpdateProfile(with num: Int)
}

protocol FoundDelegate: AnyObject {
    func didUpdateProfile(with num: Int)
}

protocol MatchedDelegate: AnyObject {
    func didUpdateProfile(with num: Int)
}
