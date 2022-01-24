//
//  CharacterModel.swift
//  MVVMSkeleton
//
//  Created by user on 24.01.2022.
//

import Foundation

struct CharacterModel: Decodable {
    let gender: String
    let name: String
    let image: URL
    let species: String
    let status: String
    
    init(gender: String, name: String, image: URL,
         species: String, status: String) {
        
        self.gender = gender
        self.name = name
        self.image = image
        self.species = species
        self.status = status
    }
}
