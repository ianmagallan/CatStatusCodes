//
//  CatsViewModel.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import Foundation

final class CatsViewModel {
    let cats = CatFactory.makeCats()
    
    func makeFullDescription(forRow index: Int) -> String {
        let cat = cats[index]
        return "\(cat.statusCode) \(cat.description)"
    }
}
