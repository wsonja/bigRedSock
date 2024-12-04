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
    private var headerView: UIView!
    private let itemNumLabel = UILabel()
    
    // MARK: - Properties (data)
    private var posts = Post.dummyData
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor(red: 246/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1)

        
        title = "Requests"
        setupRequestHeadings()
        setuprequestsCollectionView()

    }
    
    //MARK: set up views
    private func setupRequestHeadings() {
        // Create a view to hold the headings
        headerView = UIView()
        
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
        
        view.addSubview(headerView)
        
        // Layout the labels using Auto Layout
        headerView.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Header view constraints (top position)
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            // Status label constraints
            statusLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 90),
            
            // Date label constraints
            dateLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 120),
            
            // Description label constraints
            descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
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
        requestsCollectionView.backgroundColor = UIColor(red: 246/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1)
        
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
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestsCollectionViewCell.reuse, for: indexPath) as? RequestsCollectionViewCell else { return UICollectionViewCell() }

        cell.configure(post: self.posts[indexPath.row])
        return cell
        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createRequestsCollectionViewCell.reuse, for: indexPath) as? createRequestsCollectionViewCell else { return UICollectionViewCell() }
//        return cell
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
}


