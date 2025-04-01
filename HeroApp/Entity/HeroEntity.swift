//
//  HeroEntity.swift
//  HeroApp
//
//  Created by Aziza Gilash on 01.04.2025.
//

import Foundation

struct HeroEntity: Decodable {
    let id: Int
    let name: String
    let appearance: Appearance
    let images: HeroImage
    var heroImageUrl: URL? {
        URL(string: images.sm)
    }

    struct Appearance: Decodable {
        let race: String?
    }

    struct HeroImage: Decodable {
        let sm: String
        let md: String
    }
}

