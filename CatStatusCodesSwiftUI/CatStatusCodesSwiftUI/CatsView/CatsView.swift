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
        NavigationView {
            List(viewModel.cats, id: \.statusCode) { cat in
                NavigationLink(destination: CatDetailsView(statusCode: cat.statusCode)) {
                    Button(action: {
                        viewModel.updateLastSeenDate(statusCode: cat.statusCode)
                    }) {
                        CatRow(
                            cat: cat,
                            lastSeenDate: viewModel.makeLastSeenDate(cat: cat)
                        )
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .onAppear {
            viewModel.start()
        }
    }
}

struct CatsView_Previews: PreviewProvider {
    static var previews: some View {
        CatsView()
    }
}
