//
//  ViewController.swift
//  AvitoTrainee
//
//  Created by Артур Байбиков on 26.08.2023.
//

import UIKit

class MainPageViewController: BaseController {
    
    private let productManager: ProductManagerProtocol = ProductManager()
    
    private var products: [Advertisements] = []
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.alwaysBounceVertical = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ProductCell.self, forCellWithReuseIdentifier: Resources.Keys.cellIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        
        initData()
    }
    
    func initData() {
        productManager.getAllProducts(completion: { result in
            switch result {
            case .success(let response):
                self.products = response.advertisements ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: .alert)
                    alert.addAction(.init(title: "Cancel", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        })
    }
}



// MARK: - Setup Views And Set Constraints


extension MainPageViewController {
     override func setupView() {
         view.addSubview(collectionView)
    }

     override func setConstraints() {
         NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         ])
    }
    
    override func configure() {
        super.configure()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate


extension MainPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.productID = products[indexPath.item].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDataSource


extension MainPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Keys.cellIdentifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.item]
        cell.configure(with: product)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout


extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 272)
    }
}

