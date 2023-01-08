//
//  CatDetailsView.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import SpriteKit
import SwiftUI

struct CatDetailsView: View {
    @ObservedObject var viewModel: CatDetailsViewModel

    init(statusCode: Int) {
        viewModel = .init(statusCode: statusCode)
    }

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                makeHeaderImageView()
                makeTextView()
            }.edgesIgnoringSafeArea(.bottom)
                .coordinateSpace(name: Constants.coordinateNameSpace)

            if viewModel.isRaining {
                SpriteView(scene: Rain(), options: [.allowsTransparency])
                    .allowsHitTesting(false)
            }
        }
    }

    // MARK: - Header image -

    private func makeHeaderImageView() -> some View {
        GeometryReader { reader in
            AsyncImage(url: viewModel.fetchCatImageURL()) { phase in
                if let image = phase.image {
                    image
                        .headerImageModifier(frame: reader.frame(in: .named(Constants.coordinateNameSpace)))
                } else if phase.error != nil {
                    Image("imPlaceholderCat")
                        .headerImageModifier(frame: reader.frame(in: .named(Constants.coordinateNameSpace)))
                } else {
                    ProgressView()
                }
            }
        }.frame(height: Constants.geometryReaderFrameHeight)
    }

    // MARK: - Text -

    private func makeTextView() -> some View {
        VStack(alignment: .leading) {
            Text(NSLocalizedString("cat_details.description", comment: ""))
                .foregroundColor(.black)
                .padding(Constants.textPadding)
        }.background(.white)
            .cornerRadius(Constants.textBackgroundCornerRadius)
            .offset(y: Constants.textBackgroundYOffset)
    }
}

// MARK: - Modifiers -

private extension Image {
    func headerImageModifier(frame: CGRect) -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .offset(y: -frame.minY)
            .frame(width: UIScreen.main.bounds.width)
    }
}

// MARK: - Constants -

extension CatDetailsView {
    private enum Constants {
        static let coordinateNameSpace = "scroll"
        static let geometryReaderFrameHeight = 320.0
        static let textPadding = 12.0
        static let textBackgroundCornerRadius = 20.0
        static let textBackgroundYOffset = -20.0
    }
}

// MARK: - Preview -

struct CatDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CatDetailsView(statusCode: 200)
    }
}
