//
//  RequestsVC.swift
//  A4
//
//  Created by Sonja Wong on 4/12/2024.
//

import Foundation
import UIKit

class RequestsVC: UIViewController, CreateRequestDelegate, FoundDelegate {
    func didUpdateProfile(with num: Int) {
        itemNumLabel.text = "No. of items: " + String(num)
    }
    

    // MARK: - Properties (view)
    private var requestsCollectionView: UICollectionView!
    private var foundCollectionView: UICollectionView!
    private var headerView: UIView!
    private var foundHeaderView: UIView!
    private let itemNumLabel = UILabel()
    
    // MARK: - Properties (data)
    private var posts = Post.dummyData
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.white

        
        self.tabBarItem.title = "Requests"
        setupRequestHeadings()
        setuprequestsCollectionView()
        setupFoundHeadings()
        setupFoundCollectionView()

    }
    
    //MARK: set up views
    
    
    private func setupRequestHeadings() {
        // Create a view to hold the headings
        headerView = UIView()
        
        let headLabel = UILabel()
        headLabel.text = "Requests"
        headLabel.textAlignment = .center
        headLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Create labels for the headings
        let statusLabel = UILabel()
        statusLabel.text = "Status"
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let dateLabel = UILabel()
        dateLabel.text = "Date"
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Add labels to the header view
        headerView.addSubview(statusLabel)
        headerView.addSubview(dateLabel)
        headerView.addSubview(descriptionLabel)
        headerView.addSubview(headLabel)
        
        view.addSubview(headerView)
        
        // Layout the labels using Auto Layout
        headerView.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Header view constraints (top position)
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            headerView.heightAnchor.constraint(equalToConstant: 70),
            
            //headlabel
            headLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headLabel.heightAnchor.constraint(equalToConstant: 30),
            headLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            
            // Status label constraints
            statusLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant:0),
            statusLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 15),
            statusLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 90),
            
            // Date label constraints
            dateLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant:10),
            dateLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 15),
            dateLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 40),
            
            // Description label constraints
            descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 65),
            descriptionLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 15),
            descriptionLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
//            descriptionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
        ])
        
        // Add header view to the main view after constraints
        
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
            requestsCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            requestsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(posts.count*35))
            ])
    }
    
    
    private func setupFoundHeadings() {
        // Create a view to hold the headings
        foundHeaderView = UIView()
        
        let headLabel = UILabel()
        headLabel.text = "Items Found"
        headLabel.textAlignment = .center
        headLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Create labels for the headings
        let statusLabel = UILabel()
        statusLabel.text = "Status"
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let dateLabel = UILabel()
        dateLabel.text = "Date"
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Add labels to the header view
        foundHeaderView.addSubview(headLabel)
        foundHeaderView.addSubview(statusLabel)
        foundHeaderView.addSubview(dateLabel)
        foundHeaderView.addSubview(descriptionLabel)
        
        
        view.addSubview(foundHeaderView)
        
        // Layout the labels using Auto Layout
        foundHeaderView.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Header view constraints (top position)
            foundHeaderView.topAnchor.constraint(equalTo: requestsCollectionView.bottomAnchor, constant: 40),
            foundHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            foundHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            foundHeaderView.heightAnchor.constraint(equalToConstant: 80),
            
            
            //headlabel
            headLabel.leadingAnchor.constraint(equalTo: foundHeaderView.leadingAnchor),
            headLabel.topAnchor.constraint(equalTo: foundHeaderView.topAnchor),
            headLabel.heightAnchor.constraint(equalToConstant: 30),
            headLabel.centerXAnchor.constraint(equalTo: foundHeaderView.centerXAnchor),
            
            

            // Status label constraints
            statusLabel.leadingAnchor.constraint(equalTo: foundHeaderView.leadingAnchor, constant:0),
            statusLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 15),
            statusLabel.bottomAnchor.constraint(equalTo: foundHeaderView.bottomAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 90),
            
            // Date label constraints
            dateLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant:10),
            dateLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 15),
            dateLabel.bottomAnchor.constraint(equalTo: foundHeaderView.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 40),
            
            // Description label constraints
            descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 65),
            descriptionLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 15),
            descriptionLabel.bottomAnchor.constraint(equalTo: foundHeaderView.bottomAnchor),
//            descriptionLabel.trailingAnchor.constraint(equalTo: foundHeaderView.trailingAnchor),
        ])
        
    }
    
    private func setupFoundCollectionView() {
        let padding = 20
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        
        // Initialize CollectionView with the layout
        foundCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        foundCollectionView.register(RequestsCollectionViewCell.self, forCellWithReuseIdentifier: RequestsCollectionViewCell.reuse)
        foundCollectionView.delegate = self
        foundCollectionView.dataSource = self
        foundCollectionView.backgroundColor = UIColor.white
        
        foundCollectionView.alwaysBounceVertical = true
        
        view.addSubview(foundCollectionView)
        
        // Enable Auto Layout
        foundCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints to position the collection view below the header view
        NSLayoutConstraint.activate([
            foundCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(padding)),
            foundCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-padding)),
            foundCollectionView.topAnchor.constraint(equalTo: foundHeaderView.bottomAnchor),
            foundCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(posts.count*35))
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
extension RequestsVC: UICollectionViewDataSource {
    
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
        } else if collectionView == self.foundCollectionView{
            print("found")
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestsCollectionViewCell.reuse, for: indexPath) as? RequestsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(post: self.posts[indexPath.row])
        return cell
        
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension RequestsVC: UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedPost = posts[indexPath.row]
            
            // Check the status of the selected post
            if selectedPost.status == "matched" {
                // If the status is "Matched", navigate to MatchedVC
                let matchedVC = MatchedVC()
                matchedVC.post = selectedPost // Pass the post object or index if needed
                navigationController?.pushViewController(matchedVC, animated: true)
            } else if selectedPost.status == "pending" {
                // If the status is "Found", navigate to RequestDetailsVC
                let requestDetailVC = RequestDetailVC()
                requestDetailVC.post = selectedPost // Pass the post object or index if needed
                navigationController?.pushViewController(requestDetailVC, animated: true)
            }
        }
    

}


