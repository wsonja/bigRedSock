//
//  RequestDetailVC.swift
//  A4
//
//  Created by Sonja Wong on 5/12/2024.
//
//
//  CreateRequestVC.swift
//  A4
//
//  Created by Sonja Wong on 2/12/2024.
//

import Foundation
import UIKit

class RequestDetailVC: UIViewController {

    // MARK: - Properties (view)
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let descriptionContent = UILabel()
    
    private let rescindButton = UIButton()
    
    
    // MARK: - Properties (data)
    private var name = String()
    private var email = String()
    private var phone = String()
    private var date = Date()
    private var location = String()
    private var desc = String()
    let posts = Post.dummyData
    var post: Post?
    
    weak var delegate: FoundDelegate?
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Item Found"
        view.backgroundColor = UIColor.white
        setupUI()
        if let post = post {
            configure(with: post)
        } else{
            configure(with: posts[0])
        }
        
        
        
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left", withConfiguration: config), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.backButtonTitle = ""

    }
    
    // MARK: - Set Up Views
    private func setupUI() {
        // Configure the labels
        nameLabel.text = "Name: "
        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        nameLabel.textColor = UIColor.black
        
        emailLabel.text = "Email: "
        emailLabel.font = .systemFont(ofSize: 20, weight: .medium)
        emailLabel.textColor = UIColor.black
        
        phoneLabel.text = "Phone: "
        phoneLabel.font = .systemFont(ofSize: 20, weight: .medium)
        phoneLabel.textColor = UIColor.black
        
        
        dateLabel.text = "Date: "
        dateLabel.font = .systemFont(ofSize: 20, weight: .medium)
        dateLabel.textColor = UIColor.black
        
        locationLabel.text = "Location: "
        locationLabel.font = .systemFont(ofSize: 20, weight: .medium)
        locationLabel.textColor = UIColor.black
        
        descriptionLabel.text = "Description: "
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .medium)
        descriptionLabel.textColor = UIColor.black
        
        descriptionContent.font = .systemFont(ofSize: 18, weight: .medium)
        descriptionContent.textColor = UIColor.darkGray

        rescindButton.setTitle("Rescind", for: .normal)
        rescindButton.backgroundColor = UIColor.a4.ruby
        rescindButton.layer.cornerRadius = 8
        rescindButton.setTitleColor(.white, for: .normal)

        // Create a vertical stack view to arrange all pairs
        let mainStackView = UIStackView(arrangedSubviews: [
            nameLabel,
            emailLabel,
            phoneLabel,
            dateLabel,
            locationLabel,
            descriptionLabel,
        
        ])
        
        
        // Configure the main stack view (vertical stack view)
        mainStackView.axis = .vertical
        mainStackView.spacing = 26 // Space between each horizontal pair
        mainStackView.alignment = .leading
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the main stack view to the view
        view.addSubview(mainStackView)
        
        // Add constraints for the main stack view
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
        ])
        
        view.addSubview(descriptionContent)
        descriptionContent.translatesAutoresizingMaskIntoConstraints = false
        descriptionContent.numberOfLines = 0
        descriptionContent.lineBreakMode = .byWordWrapping
        

        NSLayoutConstraint.activate([
            descriptionContent.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant:10),
            descriptionContent.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            descriptionContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            
        ])
        
        // Add constraints for the submit button
        rescindButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rescindButton)
        NSLayoutConstraint.activate([
            rescindButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            rescindButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rescindButton.widthAnchor.constraint(equalToConstant: 200),
            rescindButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
        rescindButton.addTarget(self, action: #selector(rescindTapped), for: .touchUpInside)    }

    // Helper function to create a horizontal stack view for each label and text field
    private func createStackView(label: UILabel, textField: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .horizontal
        stackView.spacing = 8 // Space between label and textField
        stackView.alignment = .center
        stackView.distribution = .fill // Ensures text field takes up remaining space
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(lessThanOrEqualToConstant: 40).isActive = true
//        stackView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: -20).isActive = true
//        NSLayoutConstraint.activate([
//            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
//        ])

        return stackView
    }
    
    
    
    
    
    @objc func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(post: Post) {
           self.post = post
           super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func rescindTapped() {
        // do some API stuff - delete??
        let alert = UIAlertController(title: "Ok!", message: "Request successfully rescinded.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
//        delegate?.didUpdateProfile(with: 1)
//        navigationController?.popViewController(animated: true)
    }
    
    func configure(with post: Post) {
        // Create an attributed string for the nameLabel
        let nameText = "Name: \(post.title)"
        let nameAttributedString = NSMutableAttributedString(string: nameText)
        let nameValueRange = (nameText as NSString).range(of: post.title)  // Actual name part
        nameAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 19), range: nameValueRange) // smaller font
        nameAttributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: nameValueRange)  //  dark gray
        nameLabel.attributedText = nameAttributedString
        
        let emailText = "Email: \(post.email)"
        let emailAttributedString = NSMutableAttributedString(string: emailText)
        let emailValueRange = (emailText as NSString).range(of: post.email)  // Actual name part
        emailAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 19), range: emailValueRange) // smaller font
        emailAttributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: emailValueRange)  //  dark gray
        emailLabel.attributedText = emailAttributedString
        
        let phoneText = "Phone: \(post.phone)"
        let phoneAttributedString = NSMutableAttributedString(string: phoneText)
        let phoneValueRange = (phoneText as NSString).range(of: post.phone)  // Actual name part
        phoneAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 19), range: phoneValueRange) // smaller font
        phoneAttributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: phoneValueRange)  //  dark gray
        phoneLabel.attributedText = phoneAttributedString
    
        
        // Create an attributed string for the descriptionLabel
        let descriptionText = post.description
        let descriptionAttributedString = NSMutableAttributedString(string: descriptionText)
        let descriptionValueRange = (descriptionText as NSString).range(of: post.description)
        descriptionAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 19), range: descriptionValueRange)
        descriptionAttributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: descriptionValueRange)
        descriptionContent.attributedText = descriptionAttributedString
        
        // Format the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: post.date)
        let dateText = "Date: \(dateString)"
        let dateAttributedString = NSMutableAttributedString(string: dateText)
        let dateValueRange = (dateText as NSString).range(of: dateString)
        dateAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 19), range: dateValueRange)
        dateAttributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: dateValueRange)
        dateLabel.attributedText = dateAttributedString
        
        // Create an attributed string for the locationLabel
        let locationText = "Location: \(post.location)"
        let locationAttributedString = NSMutableAttributedString(string: locationText)
        let locationValueRange = (locationText as NSString).range(of: post.location)
        locationAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 19), range: locationValueRange)
        locationAttributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: locationValueRange)
        locationLabel.attributedText = locationAttributedString
    }


    
    
}

//// MARK: - UICollectionView DataSource
//extension CreateRequestVC: UICollectionViewDataSource {
//}
//
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension CreateRequestVC: UICollectionViewDelegateFlowLayout {
//
//
//}
