//
//  MatchedVC.swift
//  A4
//
//  Created by Sonja Wong on 5/12/2024.
//

import Foundation
import UIKit

class MatchedVC: UIViewController {

    // MARK: - Properties (view)
    private let subheadLabel = UILabel()
    private let imageView = UIImageView()
    private let dateFound = UILabel()
    private let locationLabel = UILabel()
    
    private let yesButton = UIButton()
    private let noButton = UIButton()
    
    weak var delegate: MatchedDelegate?

    
    // MARK: - Properties (data)
    private var posts = Post.dummyData
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "We found a match!"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.white
        
        setupUI()
        configure(post: posts[0])

    }
    
    //MARK: set up views
    
    
    private func setupUI() {
        subheadLabel.text = "Is this your item?"
        subheadLabel.font = .systemFont(ofSize: 20, weight:.medium)
        subheadLabel.textColor = UIColor.black
        
        view.addSubview(subheadLabel)
        subheadLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subheadLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            subheadLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        
        imageView.sd_setImage(with: URL(string: "https://i.scdn.co/image/ab6761610000e5eb10e83b0ca558533d0f3c376c"), placeholderImage: UIImage(systemName: "photo"))
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: subheadLabel.bottomAnchor, constant: 32),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        dateFound.text = "Date:"
        dateFound.font = .systemFont(ofSize: 20, weight:.semibold)
        dateFound.textColor = UIColor.black
        
        view.addSubview(dateFound)
        dateFound.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateFound.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            dateFound.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
        ])
        
        locationLabel.text = "Location:"
        locationLabel.font = .systemFont(ofSize: 20, weight:.semibold)
        locationLabel.textColor = UIColor.black
        
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: dateFound.bottomAnchor, constant: 32),
            locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
        ])
        
        yesButton.setTitle("yes", for: .normal)
        yesButton.backgroundColor = UIColor.a4.ruby
        yesButton.layer.cornerRadius = 8
        yesButton.setTitleColor(.white, for: .normal)
        
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yesButton)
        NSLayoutConstraint.activate([
            yesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            yesButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            yesButton.widthAnchor.constraint(equalToConstant: 130),
            yesButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
        yesButton.addTarget(self, action: #selector(yesTapped), for: .touchUpInside)
        
        noButton.setTitle("no", for: .normal)
        noButton.backgroundColor = UIColor.a4.ruby
        noButton.layer.cornerRadius = 8
        noButton.setTitleColor(.white, for: .normal)
        
        noButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noButton)
        NSLayoutConstraint.activate([
            noButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            noButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            noButton.widthAnchor.constraint(equalToConstant: 130),
            noButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
        noButton.addTarget(self, action: #selector(noTapped), for: .touchUpInside)
        
    }
    
    @objc func yesTapped() {
        // do some API stuff - delete?? change to found???
        let alert = UIAlertController(title: "Great!", message: "Please go to \(posts[0].location) to pick up your item.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
//        delegate?.didUpdateProfile(with: 1)
//        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func noTapped() {
        // do some API stuff - delete?? change to not found
        let alert = UIAlertController(title: "Sorry :(", message: "We'll keep looking for it.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
//        delegate?.didUpdateProfile(with: 0)
//        navigationController?.popViewController(animated: true)
    }
    
    func configure(post: Post){
        // Format the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: post.date)
        let dateText = "Date: \(dateString)"
        let dateAttributedString = NSMutableAttributedString(string: dateText)
        let dateValueRange = (dateText as NSString).range(of: dateString)
        dateAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 19), range: dateValueRange)
        dateAttributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: dateValueRange)
        dateFound.attributedText = dateAttributedString
        
        // Create an attributed string for the locationLabel
        let locationText = "Location: \(posts[0].location)"
        let locationAttributedString = NSMutableAttributedString(string: locationText)
        let locationValueRange = (locationText as NSString).range(of: post.location)
        locationAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 19), range: locationValueRange)
        locationAttributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: locationValueRange)
        locationLabel.attributedText = locationAttributedString
        
    }

   

    init() {
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}

// MARK: - UICollectionView DataSource
//extension MatchedVC: UICollectionViewDataSource {
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
//extension MatchedVC: UICollectionViewDelegateFlowLayout {
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


