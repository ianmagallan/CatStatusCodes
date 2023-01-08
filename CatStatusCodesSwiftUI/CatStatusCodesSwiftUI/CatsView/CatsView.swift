//
//  CatsView.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import SwiftUI

struct CatsView: View {
    @ObservedObject var viewModel = CatsViewModel()
    @State private var isShowingDetails = false

    var body: some View {
        NavigationView {
            List(viewModel.cats, id: \.statusCode) { cat in
                NavigationLink(destination: makeCatDetailsView(statusCode: cat.statusCode)) {
                    CatRow(
                        cat: cat,
                        lastSeenDate: viewModel.makeLastSeenDate(cat: cat)
                    ).listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
        }
        .onAppear {
            viewModel.start()
        }
    }
    
    @ViewBuilder
    private func makeCatDetailsView(statusCode: Int) -> some View {
        CatDetailsView(statusCode: statusCode)
            .onAppear {
                viewModel.updateLastSeenDate(statusCode: statusCode)
            }
    }
}

struct CatsView_Previews: PreviewProvider {
    static var previews: some View {
        CatsView()
    }
}
