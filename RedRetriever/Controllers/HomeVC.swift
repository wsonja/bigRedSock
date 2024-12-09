//
//  HomeVC.swift
//  RedRetriever
//
//  Created by Ethan Seiz on 12/1/24.
//

import Foundation
import UIKit

class HomeVC: UIViewController, CreateRequestDelegate, FoundDelegate, MatchedDelegate {
//
//    
//    func didUpdateProfile(with num: Int) {
//        itemNumLabel.text = "No. of items: " + String(num)
//    }
    
    

    // MARK: - Properties (view)
    private var postCollectionView: UICollectionView!
    private var createPostCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    private var titleView: TitleView!
    private let leaderboardTableView = UITableView()
    
    private let createRequestButton = UIButton()
    private let foundButton = UIButton()
    private let requestsButton = UIButton()
    private let requestDetailButton = UIButton()
    private let profileButton = UIButton()
    private let matchedButton = UIButton()
    private let itemNumLabel = UILabel()
    
    private let leaderBoardLabel = UILabel()
    private let matchesLabel = UILabel()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Properties (data)
    // private var requests = Post.dummyData
    private var requests: [Request] = []
    private var items: [Item] = []
    private var users = User.dummyData
    
    @objc private func fetchAllPosts() {
        self.requests = UserManager.shared.requests ?? []
        DispatchQueue.main.async {
            self.postCollectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
//        NetworkManager.shared.fetchAllPosts { [weak self] requests in
//            guard let self = self else { return }
//            print(requests.count)
//            UserManager.shared.requests = requests
//            self.requests = requests
//            
//        }
    }
    
    @objc private func fetchAllItems() {
        // for each request where userid = current user's id
        // go through all the similar items
        // and find in items where similar items contains
        
        // or go thru each item's requests array
        // for each request array go thruech request and checkrequest user id == current
        // if true then
        print(UserManager.shared.requests ?? "huh")
        self.items = []
        var added = false
        if var itemlist = UserManager.shared.items{
            print("uh")
            itemlist = itemlist.filter{$0.status == "unclaimed"}
            for item in itemlist {
                print(item.image)
                for request in item.requests{
                    print(request.id)
                    if let requestlist = UserManager.shared.requests{
                        print(requestlist[0].id)
                        print("um")
                        for ownrequest in requestlist{
                            print(request.id)
                            print(ownrequest.id)
                            print("um")
                            if request.id == ownrequest.id{
                                items.append(item)
                                added = true
                                break
                            }
                            
                        }
                    }
                    if added{break}
                }
            }
        }
        for item in items {
            print("image omg")
            print(item.description, item.image)
        }
            
        
        
//    
//        var unique: Set<Int> = []
//        for request in requests{
//            if request.user_id == UserManager.shared.userID {
//                if let similar_items = request.similar_items{
//                    for id in similar_items {
//                        unique.insert(id)
//                    }
//                }
//            }
//        }
//        self.items = UserManager.shared.items?.filter { unique.contains($0.id)} ?? []
        
        DispatchQueue.main.async {
            self.postCollectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
//        showLoadingIndicator() // Show loading before starting the fetch
//
//        NetworkManager.shared.fetchAllItems { [weak self] items in
//            guard let self = self else { return }
//            self.hideLoadingIndicator()
//            UserManager.shared.items = items
//            self.items = items
//            DispatchQueue.main.async {
//                self.postCollectionView.reloadData()
//                self.refreshControl.endRefreshing()
//            }
//        }
    }
    
    @objc private func fetchAllUsers() {
        self.users = UserManager.shared.users ?? []
        DispatchQueue.main.async {
            self.leaderboardTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
//        NetworkManager.shared.fetchAllUsers { [weak self] users in
//            guard let self = self else { return }
//            UserManager.shared.users = users
//            self.users = users
//            DispatchQueue.main.async {
//                self.leaderboardTableView.reloadData()
//                self.refreshControl.endRefreshing()
//            }
//        }
    }
    
    private func showLoadingIndicator() {
        DispatchQueue.main.async {
                self.activityIndicator.center = self.view.center
                self.activityIndicator.startAnimating()
                self.activityIndicator.hidesWhenStopped = true
                self.view.addSubview(self.activityIndicator)
            }
    }

    @objc private func hideLoadingIndicator() {
        DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            self.fetchAllPosts()
            self.fetchAllItems()
            self.fetchAllUsers()
            
                self.activityIndicator.removeFromSuperview()
            }
        
    }
    
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello")
        self.tabBarItem.title = "Home"
        view.backgroundColor = UIColor.white
        
        
                
                // Check if data is already fetched
        if AppDelegate.shared.isDataFetched {
            print("DATAFETCHED")
            fetchAllItems()
            fetchAllPosts()
            fetchAllUsers()
        } else {
            print("FETCHING")
            showLoadingIndicator()
            NotificationCenter.default.addObserver(self, selector: #selector(hideLoadingIndicator), name: .dataFetched, object: nil)
        }
        
        
        
        setupTitleView()
//        setupcreateRequestButton()
//        setupfoundButton()
        setupImageButtons()
        
        setupLeaderboardLabel()
        setupLeaderboard()
        
//        setupRequestDetailButton()
//        setupMatchedButton()
        
        setupMatchesLabel()
        setupPostCollectionView()
        
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchAllItems()
        fetchAllPosts()
        fetchAllUsers()
    }
    
    // MARK: - Set Up Views
    
    private func setupLeaderboardLabel(){
        leaderBoardLabel.text = "Leaderboard"
        leaderBoardLabel.font = .systemFont(ofSize: 24, weight:.semibold)
        leaderBoardLabel.textColor = UIColor.black
        
        view.addSubview(leaderBoardLabel)
        leaderBoardLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leaderBoardLabel.topAnchor.constraint(equalTo: foundButton.bottomAnchor, constant: 30),
            leaderBoardLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 32),
            leaderBoardLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
        ])
    }
    
    private func setupLeaderboard(){
        
        leaderboardTableView.dataSource = self
        leaderboardTableView.delegate = self
        leaderboardTableView.register(LeaderboardCell.self, forCellReuseIdentifier: "LeaderboardCell")
        print("hi")
        leaderboardTableView.frame = view.bounds
        view.addSubview(leaderboardTableView)
        
        leaderboardTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leaderboardTableView.topAnchor.constraint(equalTo: leaderBoardLabel.bottomAnchor, constant: 10),
            leaderboardTableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 32),
            leaderboardTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            leaderboardTableView.heightAnchor.constraint(equalToConstant: CGFloat(users.count*30+80))
            
        ])
    }
    
    private func setupTitleView() {
        titleView = TitleView(title: "Home", inset: .init(top: -20, left: 32, bottom: 0, right: 0))
        titleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 10) // Adjust the height as needed
        ])
    }
    
    private func setupMatchesLabel(){
        matchesLabel.text = "Matches"
        matchesLabel.font = .systemFont(ofSize: 24, weight:.semibold)
        matchesLabel.textColor = UIColor.black
        
        view.addSubview(matchesLabel)
        matchesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            matchesLabel.topAnchor.constraint(equalTo: leaderboardTableView.bottomAnchor, constant: 30),
            matchesLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 32),
            matchesLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
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
            matchedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -122),
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
    
    private func setupImageButtons() {
        createRequestButton.setImage(UIImage(named: "lostwords"), for: .normal)
        foundButton.setImage(UIImage(named: "foundwords"), for: .normal)
        
        createRequestButton.translatesAutoresizingMaskIntoConstraints = false
        foundButton.translatesAutoresizingMaskIntoConstraints = false

        // StackView to hold buttons side by side
        let stackView = UIStackView(arrangedSubviews: [createRequestButton, foundButton])
        stackView.axis = .horizontal
        stackView.spacing = 20 // Add space between buttons
        stackView.alignment = .center

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            createRequestButton.widthAnchor.constraint(equalToConstant: 160),
            createRequestButton.heightAnchor.constraint(equalToConstant: 160),
            foundButton.widthAnchor.constraint(equalToConstant: 160),
            foundButton.heightAnchor.constraint(equalToConstant: 160),
            stackView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
    
        ])
       
        // Add actions for each button
        createRequestButton.addTarget(self, action: #selector(createRequestTapped), for: .touchUpInside)
        foundButton.addTarget(self, action: #selector(foundTapped), for: .touchUpInside)
    }
        
    @objc func createRequestTapped() {
        let CreateRequestVC = CreateRequestVC()
        CreateRequestVC.delegate = self
        navigationController?.pushViewController(CreateRequestVC, animated: true)
    }
        
    
    
    
    private func setupRequestDetailButton() {
        requestDetailButton.setTitle("Request details", for: .normal)
        requestDetailButton.setTitleColor(UIColor.white, for: .normal)
        requestDetailButton.backgroundColor = UIColor(red: 0.79, green: 0.26, blue: 0.22, alpha: 1.00)
        requestDetailButton.layer.cornerRadius = 16

        view.addSubview(requestDetailButton)
        requestDetailButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            requestDetailButton.topAnchor.constraint(equalTo: leaderboardTableView.bottomAnchor, constant: 20),
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
    
    
    
//    
//    
//    private func setupfoundButton() {
//        foundButton.setTitle("Found Item", for: .normal)
//        foundButton.setTitleColor(UIColor.white, for: .normal)
//        foundButton.backgroundColor = UIColor(red: 0.79, green: 0.26, blue: 0.22, alpha: 1.00)
//        foundButton.layer.cornerRadius = 16
//
//        view.addSubview(foundButton)
//        foundButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            foundButton.topAnchor.constraint(equalTo: createRequestButton.bottomAnchor, constant:20),
//            foundButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
//            foundButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
//            foundButton.heightAnchor.constraint(equalToConstant: 56),
//        ])
//        
//        foundButton.addTarget(self, action: #selector(foundTapped), for: .touchUpInside)
//    }
    
    @objc func foundTapped() {
        let FoundVC = FoundVC(name: "String", date: Date(), location: "String", desc: "String")
        FoundVC.delegate = self
        navigationController?.pushViewController(FoundVC, animated: true)
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
                postCollectionView.topAnchor.constraint(equalTo: matchesLabel.bottomAnchor, constant: 10),
                postCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ])
        }
  
}

// MARK: - UICollectionView DataSource
extension HomeVC: UICollectionViewDataSource {
    
    // MainCollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuse, for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }

        cell.configure(item: self.items[indexPath.row])
        return cell
        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreatePostCollectionViewCell.reuse, for: indexPath) as? CreatePostCollectionViewCell else { return UICollectionViewCell() }
//        return cell
        }
    }

//
// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.createPostCollectionView {
            let widthSize = collectionView.frame.width
            let heightSize = collectionView.frame.height
            return CGSize(width: widthSize, height: heightSize)
        }
        let size = collectionView.frame.width / 2 - 14
        return CGSize(width: size, height: size+5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == self.postCollectionView {
                let viewItemVC = MatchedVC()
                viewItemVC.configure(item: self.items[indexPath.row])
                navigationController?.pushViewController(viewItemVC, animated: true)
                collectionView.reloadData()
            }
        }
    
        
       
}


extension HomeVC: UITableViewDataSource {
    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("hihi")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as? LeaderboardCell else {
                return UITableViewCell()
            }
            
            let user = users[indexPath.row]
            print(user.name)
            
            // Configure cell
            cell.rankLabel.text = "\(indexPath.row + 1)"
            cell.nameLabel.text = user.name
            cell.pointsLabel.text = "\(user.points) points"
            
            return cell
    }
    
}

extension HomeVC: UITableViewDelegate{
    // UITableViewDelegate (optional for customization)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        print("Selected: \(user.name) with \(user.points) points")
    }
    
    
    
}

protocol CreateRequestDelegate: AnyObject {
//    func didUpdateProfile(with num: Int)
}

protocol FoundDelegate: AnyObject {
//    func didUpdateProfile(with num: Int)
}

protocol MatchedDelegate: AnyObject {
//    func didUpdateProfile(with num: Int)
}

class TitleView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.a4.slateBlue
        return label
    }()

    var title: String? {
        get { return label.text }
        set { label.text = newValue }
    }

    convenience init(title: String, inset: UIEdgeInsets) {
        self.init()

        label.text = title

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor, constant: inset.top).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left).isActive = true
        bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: inset.bottom).isActive = true
        trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: inset.right).isActive = true
        
        backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class LeaderboardCell: UITableViewCell {
    let rankLabel = UILabel()
    let nameLabel = UILabel()
    let pointsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configure rankLabel
        rankLabel.font = UIFont.boldSystemFont(ofSize: 16)
        rankLabel.textAlignment = .center
        contentView.addSubview(rankLabel)
        
        // Configure nameLabel
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(nameLabel)
        
        // Configure pointsLabel
        pointsLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.textAlignment = .right
        contentView.addSubview(pointsLabel)
        
        // Layout
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            rankLabel.widthAnchor.constraint(equalToConstant: 30),
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
