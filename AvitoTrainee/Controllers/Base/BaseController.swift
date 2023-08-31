//
//  BaseController.swift
//  AvitoTrainee
//
//  Created by Артур Байбиков on 26.08.2023.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        configure()
    }
}

@objc extension BaseController {
    
    func setupView() {
        
    }
    
    func setConstraints() {
        
    }
    
    func configure() {
        view.backgroundColor = Resources.Colors.backgroundColor
    }
}
