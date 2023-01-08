//
//  Cats.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import SwiftUI

struct Cats: View {
    @ObservedObject var viewModel = CatsViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Cats_Previews: PreviewProvider {
    static var previews: some View {
        Cats()
    }
}
