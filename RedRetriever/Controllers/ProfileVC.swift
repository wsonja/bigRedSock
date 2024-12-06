//
//  ProfileVC.swift
//  A4
//
//  Created by Sonja Wong on 5/12/2024.
//


import Foundation
import UIKit
import SDWebImage

class ProfileVC: UIViewController {
 

    // MARK: - Properties (view)
    private let nameLabel = UILabel()
    private let profileImageView = UIImageView()
    private let emailLabel = UILabel()
    private let pointsLabel = UILabel()
    
    private let pastFindingsLabel = UILabel()
    private var requestsCollectionView: UICollectionView!
    private var posts = Post.dummyData
    
    
    // MARK: - Properties (data)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.white

        self.tabBarItem.title = "Profile"
        setupUI()
        setuprequestsCollectionView()

    }
    
    //MARK: set up views
    
    
    private func setupUI() {
        profileImageView.sd_setImage(with: URL(string: "https://i.scdn.co/image/ab6761610000e5eb10e83b0ca558533d0f3c376c"), placeholderImage: UIImage(systemName: "photo"))
        profileImageView.layer.cornerRadius = 64
        profileImageView.layer.masksToBounds = true
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 128),
            profileImageView.widthAnchor.constraint(equalToConstant: 128)
        ])
        
        nameLabel.text = "sonja"
        nameLabel.font = .systemFont(ofSize: 32, weight:.semibold)
        nameLabel.textColor = UIColor.black
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        emailLabel.text = "sonja@gmail.com"
        emailLabel.font = .systemFont(ofSize: 16, weight:.medium)
        emailLabel.textColor = UIColor.black
        
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        pointsLabel.text = "12"
        pointsLabel.font = .systemFont(ofSize: 16, weight:.medium)
        pointsLabel.textColor = UIColor.black
        
        view.addSubview(pointsLabel)
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pointsLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            pointsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        
        pastFindingsLabel.text = "Past Findings"
        pastFindingsLabel.font = .systemFont(ofSize: 16, weight:.semibold)
        pastFindingsLabel.textColor = UIColor.black
        
        view.addSubview(pastFindingsLabel)
        pastFindingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pastFindingsLabel.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 32),
            pastFindingsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
        ])
        
        
        
        
    }
        
        
    

    private func setuprequestsCollectionView() {
        let padding = 20
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        
        // Initialize CollectionView with the layout
        requestsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        requestsCollectionView.register(RequestsCollectionViewCell.self, forCellWithReuseIdentifier: RequestsCollectionViewCell.reuse)
        requestsCollectionView.delegate = self
        requestsCollectionView.dataSource = self
        requestsCollectionView.backgroundColor = UIColor.white
        
        requestsCollectionView.alwaysBounceVertical = true
        
        view.addSubview(requestsCollectionView)
        
        // Enable Auto Layout
        requestsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints to position the collection view below the header view
        NSLayoutConstraint.activate([
            requestsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(padding)),
            requestsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-padding)),
            requestsCollectionView.topAnchor.constraint(equalTo: pastFindingsLabel.bottomAnchor, constant: 5),
            requestsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(posts.count*35))
            ])
    }
    
  

    init() {
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}

// MARK: - UICollectionView DataSource
extension ProfileVC: UICollectionViewDataSource {
    
    // MainCollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.requestsCollectionView {
            return posts.count
        }
        return posts.count
        // return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.requestsCollectionView{
            print("hihihi")
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestsCollectionViewCell.reuse, for: indexPath) as? RequestsCollectionViewCell else { return UICollectionViewCell() }

        cell.configure(post: self.posts[indexPath.row])
        return cell
        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createRequestsCollectionViewCell.reuse, for: indexPath) as? createRequestsCollectionViewCell else { return UICollectionViewCell() }
//        return cell
        }
    }


// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("hihi")
//        if collectionView == self.requestsCollectionView {
//            let widthSize = collectionView.frame.width
//            let heightSize = collectionView.frame.height
//            return CGSize(width: widthSize, height: 30)
//        }
        let size = collectionView.frame.width
        return CGSize(width: size, height: 30)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
}


