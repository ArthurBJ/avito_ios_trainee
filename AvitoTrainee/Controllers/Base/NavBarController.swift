//
//  NavBarController.swift
//  AvitoTrainee
//
//  Created by Артур Байбиков on 26.08.2023.
//

import UIKit

class NavBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.backgroundColor
        navigationBar.shadowImage = UIImage()
    }
}
