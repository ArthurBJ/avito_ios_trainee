//
//  ProductCell.swift
//  AvitoTrainee
//
//  Created by Артур Байбиков on 26.08.2023.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .label
        view.startAnimating()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var productName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var price: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var location: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 7, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var date: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 7, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productName)
        contentView.addSubview(image)
        image.addSubview(activityIndicator)
        contentView.addSubview(price)
        contentView.addSubview(location)
        contentView.addSubview(date)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Constraints
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 156),
            image.heightAnchor.constraint(equalToConstant: 185),
            
            productName.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 5),
            productName.leadingAnchor.constraint(equalTo: self.image.leadingAnchor),
            productName.widthAnchor.constraint(equalToConstant: 156),
            
            price.topAnchor.constraint(equalTo: self.productName.bottomAnchor, constant: 5),
            price.leadingAnchor.constraint(equalTo: self.image.leadingAnchor),
            price.widthAnchor.constraint(equalToConstant: 156),
            
            location.topAnchor.constraint(equalTo: self.price.bottomAnchor, constant: 5),
            location.leadingAnchor.constraint(equalTo: self.image.leadingAnchor),
            location.widthAnchor.constraint(equalToConstant: 156),
            
            date.topAnchor.constraint(equalTo: self.location.bottomAnchor, constant: 2),
            date.leadingAnchor.constraint(equalTo: self.image.leadingAnchor),
            date.widthAnchor.constraint(equalToConstant: 156),
            
            activityIndicator.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: image.centerYAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productName.text = nil
        price.text = nil
        location.text = nil
        date.text = nil
        image.image = nil
    }
    
    // MARK: - Configure the cell
    
    func configure(with product: Advertisements) {
        self.productName.text = product.title
        self.price.text = product.price
        self.location.text = product.location
        self.date.text = product.created_date
        
        if let url = URL(string: product.image_url ?? "") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.image.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
