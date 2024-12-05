//
//  CreateRequestVC.swift
//  A4
//
//  Created by Sonja Wong on 2/12/2024.
//

import Foundation
import UIKit

class FoundVC: UIViewController {

    // MARK: - Properties (view)
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    
    private let dateLabel = UILabel()
    private let dateField = UIDatePicker()
    
    private let locationLabel = UILabel()
    private let locationTextField = UITextField()
    
    private let descriptionLabel = UILabel()
    private let descriptionTextField = PaddedTextField()
    
    private let uploadLabel = UILabel()
    private let uploadButton = UIButton()
    
    private let submitButton = UIButton()
    
    
    // MARK: - Properties (data)
    private var name = String()
    private var date = Date()
    private var location = String()
    private var desc = String()
    
    weak var delegate: FoundDelegate?
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "Item Found"
        view.backgroundColor = UIColor(red: 246/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1)
        setupUI()
        
        
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
       
        dateLabel.text = "Date: "
        dateLabel.font = .systemFont(ofSize: 20, weight: .medium)
        dateLabel.textColor = UIColor.black
        
        locationLabel.text = "Location: "
        locationLabel.font = .systemFont(ofSize: 20, weight: .medium)
        locationLabel.textColor = UIColor.black
        
        descriptionLabel.text = "Description: "
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .medium)
        descriptionLabel.textColor = UIColor.black
        
        // Configure text fields
        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.font = .systemFont(ofSize: 16, weight: .medium)
        nameTextField.backgroundColor = UIColor(red: 246/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1)
       
        locationTextField.placeholder = "Enter your location"
        locationTextField.borderStyle = .roundedRect
        locationTextField.font = .systemFont(ofSize: 16, weight: .medium)
        locationTextField.backgroundColor = UIColor(red: 246/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1)
        
        descriptionTextField.placeholder = "Enter description"
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.font = .systemFont(ofSize: 16, weight: .medium)
        descriptionTextField.backgroundColor = UIColor(red: 246/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1)
        
        // Configure date picker
        dateField.datePickerMode = .date

        for subview in dateField.subviews {
                    if let label = subview as? UILabel {
                        label.font = UIFont.systemFont(ofSize: 10) // Adjust font size
                    }
                }
        
        uploadLabel.text = "Please upload an image of the item."
        uploadLabel.font = .systemFont(ofSize: 18, weight: .medium)
        uploadLabel.textColor = UIColor.black
        
    
        
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.backgroundColor = UIColor(red: 246/255.0, green: 244/255.0, blue: 241/255.0, alpha: 1)
        uploadButton.layer.cornerRadius = 8
        uploadButton.layer.borderWidth = 2
        uploadButton.layer.borderColor = UIColor(red: 0/255.0, green: 76/255.0, blue: 178/255.0, alpha: 1).cgColor
        uploadButton.setTitleColor(UIColor(red: 0/255.0, green: 76/255.0, blue: 178/255.0, alpha: 1), for: .normal)
        uploadButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor(red: 0/255.0, green: 76/255.0, blue: 178/255.0, alpha: 1)
        submitButton.layer.cornerRadius = 8
        submitButton.setTitleColor(.white, for: .normal)
        
        // Create a UIStackView for each label and text field pair
        let nameStackView = createStackView(label: nameLabel, textField: nameTextField)
        let dateStackView = createStackView(label: dateLabel, textField: dateField)
        let locationStackView = createStackView(label: locationLabel, textField: locationTextField)
//        let descriptionStackView = createStackView(label: descriptionLabel, textField: descriptionTextField)
        
        // Create a vertical stack view to arrange all pairs
        let mainStackView = UIStackView(arrangedSubviews: [
            nameStackView,
            dateStackView,
            locationStackView,
//            descriptionStackView
        ])
        
        
        dateField.widthAnchor.constraint(lessThanOrEqualToConstant: 150).isActive = true
        
        // Configure the main stack view (vertical stack view)
        mainStackView.axis = .vertical
        mainStackView.spacing = 26 // Space between each horizontal pair
        mainStackView.alignment = .leading
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the main stack view to the view
        view.addSubview(mainStackView)
        
        // Add constraints for the main stack view
        NSLayoutConstraint.activate([
            dateStackView.heightAnchor.constraint(equalToConstant: 40),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
        ])
        
        
        
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextField)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.contentVerticalAlignment = .top

        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 26),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 250),
            descriptionTextField.widthAnchor.constraint(equalToConstant: 335),
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            descriptionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)
            
        ])
        
        view.addSubview(uploadLabel)
        view.addSubview(uploadButton)
        
        uploadLabel.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        
       
        
        NSLayoutConstraint.activate([
            uploadLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 26),
            uploadLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            uploadButton.topAnchor.constraint(equalTo: uploadLabel.bottomAnchor, constant: 10),
            uploadButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            uploadButton.widthAnchor.constraint(equalToConstant: 100),
            uploadButton.heightAnchor.constraint(equalToConstant: 30),
            
        ])
        
        // Add constraints for the submit button
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)    }

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
    
    init(name: String, date: Date, location: String, desc: String) {
        self.name = name
        self.date = date
        self.location = location
        self.desc = desc
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func submitTapped() {
        delegate?.didUpdateProfile(with: 1)
        navigationController?.popViewController(animated: true)
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
