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
    private var refreshControl = UIRefreshControl()
    
    // MARK: - Properties (data)
    private var requests: [Request] = []
    private var claimed: [Request] = []
    
    @objc private func fetchAllPosts() {
        let allrequests = UserManager.shared.requests ?? []
        for i in allrequests{
            print("ITEMTEST")
            print(i.id, i.name, i.description, i.user_id, i.status)
        }
        print("user",UserManager.shared.userID)
        self.requests = allrequests.filter { $0.user_id == UserManager.shared.userID && $0.status == "unclaimed"}
        self.claimed = allrequests.filter { $0.user_id == UserManager.shared.userID && $0.status != "unclaimed" }
        
        DispatchQueue.main.async{
            self.requestsCollectionView.reloadData()
            print("claimed count: \(self.claimed.count)")
            self.foundCollectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
 
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.white


        self.tabBarItem.title = "Requests"
        fetchAllPosts()
        setupRequestHeadings()
        setuprequestsCollectionView()
        setupFoundHeadings()
        setupFoundCollectionView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchAllPosts()
        print("sungjin")
        print(UserManager.shared.userID)
    }
    
    //MARK: set up views
    
    
    private func setupRequestHeadings() {
        // Create a view to hold the headings
        headerView = UIView()
        
        let headLabel = UILabel()
        headLabel.text = "My Requests"
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
        print("HIHIHI")
        print(UserManager.shared.requests![0])
        // Set constraints to position the collection view below the header view
        NSLayoutConstraint.activate([
            requestsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(padding)),
            requestsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-padding)),
            requestsCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            requestsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 4)
            ])
    }
    
    
    private func setupFoundHeadings() {
        // Create a view to hold the headings
        foundHeaderView = UIView()
        
        let headLabel = UILabel()
        headLabel.text = "Items Claimed"
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
            foundHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            foundHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
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
            foundCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 4)
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
        print("requests or found")

        if collectionView == self.requestsCollectionView {
            print(requests.count, "REQCOUNT")
            return requests.count
        } else if collectionView == self.foundCollectionView {
            print(claimed.count, "CLAIMCOUNT")
            return claimed.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Row: \(indexPath.row)")

        // Dequeue and configure the cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestsCollectionViewCell.reuse, for: indexPath) as? RequestsCollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView == self.requestsCollectionView {
            cell.configure(request: requests[indexPath.row])
        } else if collectionView == self.foundCollectionView {
            cell.configure(request: claimed[indexPath.row])
        }
            
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
        return CGSize(width: size, height: 33)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.requestsCollectionView {
            let selectedPost = requests[indexPath.row]
            let requestDetailVC = RequestDetailVC()
            requestDetailVC.request = selectedPost // Pass the post object or index if needed
            navigationController?.pushViewController(requestDetailVC, animated: true)
            
        }
            
    }
    

}


