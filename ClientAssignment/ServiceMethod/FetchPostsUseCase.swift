//
//  FetchPostsUseCase.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 10/01/2026.
//

import RxSwift

class FetchPostsUseCase {

    private let repository: PostRepositoryProtocol

    init(repository: PostRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> Observable<[Post]> {
        repository.fetchPosts()
    }
}
