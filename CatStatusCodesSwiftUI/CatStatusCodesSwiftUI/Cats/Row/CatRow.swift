//
//  CatRow.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import SwiftUI

struct CatRow: View {
    private let title: String
    private let lastSeen: String
    
    var body: some View {
        HStack(alignment: .center) {
            CircleView(named: "imMysteriousCat")
                .frame(
                    width: Constants.imageWidth,
                    height: Constants.imageWidth
                )
            VStack(alignment: .leading) {
                Text("200 Cat code")
                Text("Last seen: XXXXX")
            }
        }
    }
}

struct CatRow_Previews: PreviewProvider {
    static var previews: some View {
        CatRow()
    }
}

extension CatRow {
    private enum Constants {
        static let imageWidth = 50.0
    }
}
