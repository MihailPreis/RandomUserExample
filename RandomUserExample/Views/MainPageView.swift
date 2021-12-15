//
//  MainView.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import SwiftUI

struct MainPageView: View {
    @ObservedObject var viewModel = MainViewModel()

    var body: some View {
        switch viewModel.error {
        case .common:
            ErrorView(reason: nil) {
                viewModel.tryLoad()
            }

        case .message(let reason):
            ErrorView(reason: reason) {
                viewModel.tryLoad()
            }

        case .none:
            NavigationView {
                List {
                    ForEach(viewModel.users, id: \.login.uuid) { user in
                        NavigationLink(destination: UserDetailsView(user: user)) {
                            UserListView(user: user)
                                .onAppear {
                                    guard viewModel.users.last == user else { return }
                                    viewModel.loadMore()
                                }
                        }
                    }

                    if viewModel.isLoading {
                        ProgressView()
                            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                    }
                }
                .navigationBarTitle("main-title")
                .onAppear { viewModel.reload() }
                .refreshable { viewModel.reload(withUpdateSeed: true) }
            }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
