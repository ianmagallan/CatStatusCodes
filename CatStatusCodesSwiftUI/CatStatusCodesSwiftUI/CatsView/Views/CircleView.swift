//
//  CircleView.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import SwiftUI

struct CircleView: View {
    private let named: String

    init(named: String) {
        self.named = named
    }

    var body: some View {
        Image(named)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.black, lineWidth: 1)
            )
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(named: "imMysteriousCat")
    }
}
