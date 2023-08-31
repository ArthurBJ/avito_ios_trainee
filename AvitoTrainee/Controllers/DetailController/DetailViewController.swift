//
//  DetailViewController.swift
//  AvitoTrainee
//
//  Created by Артур Байбиков on 26.08.2023.
//

import UIKit

class DetailViewController: BaseController {
    
    var productID: String?
    private let productManager: ProductManagerProtocol = ProductManager()
    private var product: ProductDetailData!
    
    private lazy var itemImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        
        productManager.getProduct(id: productID ?? "") { result in
            switch result {
            case .success(let response):
                self.product = response
                self.configure(product: self.product)
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: .alert)
                    alert.addAction(.init(title: "Cancel", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func configure(product: ProductDetailData) {
        priceLabel.text = product.price
        titleLabel.text = product.title
        cityLabel.text = product.location
        createdLabel.text = product.created_date
        descriptionLabel.text = product.description
        emailLabel.text = product.email
        phoneLabel.text = product.phone_number
        addressLabel.text = product.address
        
        if let url = URL(string: product.image_url ?? "") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.itemImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

// MARK: - Setup Views And Set Constraints


extension DetailViewController {
    override func setupView() {
        view.addSubview(itemImageView)
        view.addSubview(priceLabel)
        view.addSubview(titleLabel)
        view.addSubview(cityLabel)
        view.addSubview(createdLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(addressLabel)
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            
            itemImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 300),
            
            priceLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            createdLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            createdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            descriptionLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            emailLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            addressLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
    }
}
