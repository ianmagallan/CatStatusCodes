//
//  CatRow.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import CatStatusCodesModels
import SwiftUI

struct CatRow: View {
    @ObservedObject private var viewModel: CatRowViewModel
    @State private var isShowingDetails = false

    init(cat: Cat, lastSeenDate: Date?) {
        viewModel = .init(cat: cat, lastSeenDate: lastSeenDate)
    }

    var body: some View {
        HStack(alignment: .center) {
            CircleView(named: viewModel.catImageName)
                .frame(
                    width: Constants.imageWidth,
                    height: Constants.imageWidth
                )
            VStack(alignment: .leading) {
                Text(viewModel.title)
                Text(viewModel.lastSeen)
                    .foregroundColor(Constants.lastSeenTextColor)
                    .font(.system(size: Constants.fontSize))
            }
        }
    }
}

struct CatRow_Previews: PreviewProvider {
    private static let cat = Cat(statusCode: 200, description: "Happy cat")

    static var previews: some View {
        CatRow(cat: cat, lastSeenDate: Date())
    }
}

extension CatRow {
    private enum Constants {
        static let imageWidth = 50.0
        static let fontSize = 14.0
        static let lastSeenTextColor = Color("lightGrey")
    }
}
