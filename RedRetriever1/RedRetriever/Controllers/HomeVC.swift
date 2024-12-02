//
//  HomeVC.swift
//  RedRetriever
//
//  Created by Ethan Seiz on 12/1/24.
//

import Foundation
import UIKit

class HomeVC: UIViewController {

    // MARK: - Properties (view)
    private var postCollectionView: UICollectionView!
    
    // MARK: - Properties (data)
    private var posts = Post.dummyData
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.white
        
        setupPostCollectionView()
    }
    
    // MARK: - Set Up Views
    private func setupPostCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 70
        layout.minimumInteritemSpacing = 20
        
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
            postCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            postCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            postCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            postCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - UICollectionView DataSource
extension HomeVC: UICollectionViewDataSource {
    
    // MainCollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuse, for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(post: self.posts[indexPath.row])
        return cell
        }
    }


// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 2 - 14
        return CGSize(width: size, height: size)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
}
