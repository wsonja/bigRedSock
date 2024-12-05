//
//  LoginVC.swift
//  A4
//
//  Created by Ethan Seiz on 12/1/24.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK: - Properties (view)
    private let nameLabel = UILabel()
    private let profileImageView = UIImageView()
    private let bioLabel = UILabel()
    private let emailLabel = UILabel()
    private let pointsLabel = UILabel()
    private let emailImageView = UIImageView()
    private let pointsImageView = UIImageView()
    private let editButton = UIButton()
    private var retrievingsCollectionView: UICollectionView!
    private let retrievingsLabel = UILabel()
    
    // MARK: - Properties (data)
    private var emailText: String = "ezs8@cornell.edu"
    private var pointsText: String = "Total Points: 15"
    private var items = Item.dummyData
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Profile"
        view.backgroundColor = UIColor.white
        
        setupNameLabel()
        setupBioLabel()
        setupProfileImageView()
        setupEmailLabel()
        setupPointsLabel()
        setupEmailImageView()
        setupPointsImageView()
        // setupEditButton()
        setupRetrievingsLabel()
        setupRetrievingsCollectionViewCell()
    }
    
    // MARK: - Set Up Views
//    private func setupEditButton() {
//        editButton.setTitle("Edit Profile", for: .normal)
//        editButton.setTitleColor(.white, for: .normal)
//        editButton.backgroundColor = .systemRed
//        editButton.layer.cornerRadius = 16
//                editButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
//
//        view.addSubview(editButton)
//        editButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
//            editButton.widthAnchor.constraint(equalToConstant: 329),
//            editButton.heightAnchor.constraint(equalToConstant: 56)
//        ])
//    }
    
    private func setupProfileImageView() {
        profileImageView.image = UIImage(named: "ethan_pfp")
        
        profileImageView.layer.cornerRadius = 256/4
        profileImageView.layer.masksToBounds = true
        
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 128),
            profileImageView.widthAnchor.constraint(equalToConstant: 128),
        ])
    }
    
    private func setupNameLabel() {
        // 3. Configure the view's properties
        nameLabel.text = "Ethan Seiz"
        nameLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        nameLabel.textColor = UIColor.black
        
        
        // 4. Add view as a subview and enable auto-layout
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 5. Set Up Constraints
        NSLayoutConstraint.activate([
            //            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 175),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupBioLabel() {
        // 3. Configure the view's properties
        bioLabel.text = "Student at Cornell"
        bioLabel.font = .italicSystemFont(ofSize: 16)
        bioLabel.textColor = UIColor.black
        
        // 4. Add view as a subview and enable auto-layout
        view.addSubview(bioLabel)
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 5. Set Up Constraints
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupEmailLabel() {
        // 3. Configure the view's properties
        emailLabel.text = emailText
        emailLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        emailLabel.textColor = UIColor.black
        
        // 4. Add view as a subview and enable auto-layout
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 5. Set Up Constraints
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 30),
            emailLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 80),
        ])
    }
    
    private func setupPointsLabel() {
        // 3. Configure the view's properties
        pointsLabel.text = pointsText
        pointsLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        pointsLabel.textColor = UIColor.black
        
        // 4. Add view as a subview and enable auto-layout
        view.addSubview(pointsLabel)
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 5. Set Up Constraints
        NSLayoutConstraint.activate([
            pointsLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            pointsLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 80),
        ])
    }
    
    private func setupEmailImageView() {
        emailImageView.image = UIImage(named: "inbox")
        
        
        view.addSubview(emailImageView)
        emailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailImageView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 30),
            emailImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 40),
            emailImageView.heightAnchor.constraint(equalToConstant: 24),
            emailImageView.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func setupPointsImageView() {
        pointsImageView.image = UIImage(named: "Book And Pencil")
        
        
        view.addSubview(pointsImageView)
        pointsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pointsImageView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            pointsImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 40),
            pointsImageView.heightAnchor.constraint(equalToConstant: 24),
            pointsImageView.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func setupRetrievingsLabel() {
        retrievingsLabel.text = "Your Retrievings"
        retrievingsLabel.textColor = UIColor.a4.ruby
        retrievingsLabel.font = .systemFont(ofSize: 18, weight: .medium)
        view.addSubview(retrievingsLabel)
        retrievingsLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            retrievingsLabel.leftAnchor.constraint(equalTo: pointsImageView.leftAnchor, constant: 0),
            retrievingsLabel.topAnchor.constraint(equalTo: pointsImageView.bottomAnchor, constant: 35),
        ])
    }
    
    private func setupRetrievingsCollectionViewCell() {
        let padding = 50
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 50
        
        // Initialize CollectionView with the layout
        retrievingsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        retrievingsCollectionView.register(RetrievingsCollectionViewCell.self, forCellWithReuseIdentifier: RetrievingsCollectionViewCell.reuse)
        retrievingsCollectionView.delegate = self
        retrievingsCollectionView.dataSource = self
        
        retrievingsCollectionView.alwaysBounceVertical = true
        
        view.addSubview(retrievingsCollectionView)
        
        retrievingsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            retrievingsCollectionView.leftAnchor.constraint(equalTo: retrievingsLabel.leftAnchor, constant: 0),
            retrievingsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-padding)),
            retrievingsCollectionView.topAnchor.constraint(equalTo: retrievingsLabel.bottomAnchor, constant: 15),
            retrievingsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - UICollectionView DataSource
extension ProfileVC: UICollectionViewDataSource {
    
    // MainCollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RetrievingsCollectionViewCell.reuse, for: indexPath) as? RetrievingsCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(item: self.items[indexPath.row])
        return cell
        }
    }

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthSize = collectionView.frame.width
        let heightSize = collectionView.frame.height
        return CGSize(width: widthSize, height: 20)
    }
}
