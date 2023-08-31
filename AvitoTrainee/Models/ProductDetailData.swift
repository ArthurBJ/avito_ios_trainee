//
//  ProductDetailData.swift
//  AvitoTrainee
//
//  Created by Артур Байбиков on 30.08.2023.
//

import Foundation

struct DetailProductResponse: Codable {
    let product: ProductDetailData
}

struct ProductDetailData: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: String?
    let created_date: String
    let description: String
    let email: String
    let phone_number: String
    let address: String
}
