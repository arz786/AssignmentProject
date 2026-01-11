//
//  ToggleFavoriteUseCase.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 10/01/2026.
//

class ToggleFavoriteUseCase {

    private let repository: PostRepositoryProtocol

    init(repository: PostRepositoryProtocol) {
        self.repository = repository
    }

    func execute(postId: Int) {
        repository.toggleFavorite(postId: postId)
    }
}
