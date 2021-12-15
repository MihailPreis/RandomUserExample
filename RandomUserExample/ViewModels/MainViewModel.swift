//
//  MainViewModel.swift
//  RandomUserExample
//
//  Created by Mike Price on 15.12.2021.
//

import Combine
import Foundation

final class MainViewModel: ObservableObject {

    enum ErrorState {
        case none
        case common
        case message(String)
    }

    private let pageSize: Int = 30
    private var page: Int = 1
    private var bag: Set<AnyCancellable> = []
    private var usersSeed = UUID().uuidString

    @Published private(set) var error: ErrorState = .none
    @Published private(set) var users: [UserModel] = []
    @Published private(set) var isLoading: Bool = false

    func reload(withUpdateSeed: Bool = false) {
        if withUpdateSeed {
            usersSeed = UUID().uuidString
        }
        page = 1
        load(isAppend: false)
    }

    func loadMore() {
        page += 1
        load(isAppend: true)
    }

    func tryLoad() {
        load(isAppend: page > 1)
    }

    private func load(isAppend: Bool) {
        guard !isLoading else { return }
        error = .none
        isLoading = true
        NetworkClient.shared
            .run(.getUsers(page: page, size: pageSize, usersSeed: usersSeed))
            .sink { [weak self] state in
                defer { self?.isLoading = false }
                guard case .failure = state else { return }
                self?.error = .common
            } receiveValue: { [weak self] value in
                switch value.result {
                case .success(let model):
                    self?.page = model.info.page
                    if isAppend {
                        self?.users.append(contentsOf: model.results)
                    } else {
                        self?.users = model.results
                    }
                case .failure(let error):
                    self?.error = .message(error.localizedDescription)
                }
            }
            .store(in: &bag)
    }

}
