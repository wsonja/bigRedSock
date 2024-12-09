//
//  LoginVC.swift
//  A4
//
//  Created by Ethan Seiz on 12/1/24.
//

import Foundation
import UIKit
import SDWebImage
import GoogleSignIn
import GoogleSignInSwift

class LoginVC: UIViewController {
 

    // MARK: - Properties (view)
    private let nameLabel = UILabel()
    private let profileImageView = UIImageView()
    private let signInButton = UIButton(type: .system)
    
    
    // MARK: - Properties (data)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.white

        title = ""
        setupUI()

    }
    
    //MARK: set up views
    
    
    private func setupUI() {
        profileImageView.image = UIImage(named: "found")
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
        
        nameLabel.text = "Red Retrievers"
        nameLabel.font = .systemFont(ofSize: 32, weight:.semibold)
        nameLabel.textColor = UIColor.black
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        signInButton.setTitle("Sign in with Google", for: .normal)
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signInButton.center = view.center
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 100),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        
    }
    
    @IBAction func signIn(sender: Any) {
      GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
        guard error == nil else { return }
          guard let signInResult = signInResult else { return }
          let user = signInResult.user
          let emailAddress = user.profile?.email
          let fullName = user.profile?.name
          let givenName = user.profile?.givenName
          let familyName = user.profile?.familyName
          let profilePicUrl = user.profile?.imageURL(withDimension: 320)
          UserManager.shared.email = emailAddress
          UserManager.shared.profileName = fullName
          UserManager.shared.firstName = givenName
          UserManager.shared.lastName = familyName
          UserManager.shared.profilePicURL = profilePicUrl
          NetworkManager.shared.fetchAllPosts { [weak self] requests in
              guard let self = self else { return }
              // Assign the fetched requests to UserManager.shared.requests
              UserManager.shared.requests = requests
              print(UserManager.shared.requests![0].description)
              print(UserManager.shared.requests!.count)
          }
          NetworkManager.shared.fetchAllItems { [weak self] items in
              guard let self = self else { return }
              // Assign the fetched requests to UserManager.shared.requests
              UserManager.shared.items = items
              print(UserManager.shared.items![0].description)
              print(UserManager.shared.items!.count)
          }
          NetworkManager.shared.fetchAllUsers { [weak self] users in
              guard let self = self else { return }
              // Assign the fetched requests to UserManager.shared.requests
              UserManager.shared.users = users
              print(UserManager.shared.users![0].name)
              print(UserManager.shared.users!.count)
              for user in users {
                  if (UserManager.shared.email == user.email){
                      UserManager.shared.userID = user.id
                      UserManager.shared.points = user.points
                      print("user found!!")
                  }
                  
              }
          }
         
      }
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()


        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let mainTabBarController = MainTabBarController()
                sceneDelegate.window?.rootViewController = mainTabBarController
            }
    }
   

    init() {
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}

// MARK: - UICollectionView DataSource
//extension ProfileVC: UICollectionViewDataSource {
//    
//    // MainCollectionView
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.requestsCollectionView {
//            return posts.count
//        }
//        return posts.count
//        // return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == self.requestsCollectionView{
//            print("hihihi")
//        }
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestsCollectionViewCell.reuse, for: indexPath) as? RequestsCollectionViewCell else { return UICollectionViewCell() }
//
//        cell.configure(post: self.posts[indexPath.row])
//        return cell
//        
////        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createRequestsCollectionViewCell.reuse, for: indexPath) as? createRequestsCollectionViewCell else { return UICollectionViewCell() }
////        return cell
//        }
//    }
//
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension ProfileVC: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print("hihi")
////        if collectionView == self.requestsCollectionView {
////            let widthSize = collectionView.frame.width
////            let heightSize = collectionView.frame.height
////            return CGSize(width: widthSize, height: 30)
////        }
//        let size = collectionView.frame.width
//        return CGSize(width: size, height: 30)
//    }
//    
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////    }
//}


