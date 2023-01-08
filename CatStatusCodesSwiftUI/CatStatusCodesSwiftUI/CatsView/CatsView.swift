//
//  CatsView.swift
//  CatStatusCodesSwiftUI
//
//  Created by Ian Magallan on 8/1/23.
//

import SwiftUI

struct CatsView: View {
    @ObservedObject var viewModel = CatsViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.cats, id: \.statusCode) { cat in
                NavigationLink(destination: makeDetailsView(statusCode: cat.statusCode)) {
                    CatRow(
                        cat: cat,
                        lastSeenDate: viewModel.makeLastSeenDate(cat: cat)
                    )
                }
            }
            .listStyle(PlainListStyle())
            .navigationViewStyle(.stack)
        }
        .onAppear {
            viewModel.start()
        }
    }

    private func makeDetailsView(statusCode: Int) -> some View {
        CatDetailsView(statusCode: statusCode).onAppear {
            viewModel.updateLastSeenDate(statusCode: statusCode)
        }
    }
}

struct CatsView_Previews: PreviewProvider {
    static var previews: some View {
        CatsView()
    }
}
