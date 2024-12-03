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
    private var createPostCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Properties (data)
    private var posts = Post.dummyData
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "redretriever"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.white
        
        
        setupCreatePostCollectionView()
        setupPostCollectionView()
    }
    
    // MARK: - Set Up Views
    private func setupCreatePostCollectionView() {
        print("setupcreatepostcollectionview")
        let padding = 20
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        // Initialize CollectionView with the layout
        createPostCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        createPostCollectionView.register(CreatePostCollectionViewCell.self, forCellWithReuseIdentifier: CreatePostCollectionViewCell.reuse)
        createPostCollectionView.delegate = self
        createPostCollectionView.dataSource = self
        
        // createPostCollectionView.backgroundColor = .red
        
        // createPostCollectionView.alwaysBounceVertical = true
        
        view.addSubview(createPostCollectionView)
        
        //postCollectionView.refreshControl = refreshControl
        createPostCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createPostCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(padding)),
            createPostCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: CGFloat(-padding)),
            createPostCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(padding)),
            createPostCollectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupPostCollectionView() {
        print("setupPostCollectionView")
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
            postCollectionView.topAnchor.constraint(equalTo: createPostCollectionView.bottomAnchor, constant: 10),
            postCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - UICollectionView DataSource
extension HomeVC: UICollectionViewDataSource {
    
    // MainCollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.createPostCollectionView {
            print("returning 1")
            return 1
        }
        return posts.count
        // return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if collectionView == self.createPostCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreatePostCollectionViewCell.reuse, for: indexPath) as? CreatePostCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
        // CODE FOR PostCollectionViewCell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.postCollectionView {
            let viewItemVC = ItemVC()
            viewItemVC.configure(post: self.posts[indexPath.row])
            navigationController?.pushViewController(viewItemVC, animated: true)
            collectionView.reloadData()
        }
    }
}
