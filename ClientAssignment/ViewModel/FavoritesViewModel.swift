//
//  FavoritesViewModel.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 10/01/2026.
//

import RxSwift
import RxCocoa

class FavoritesViewModel {

    let favorites = BehaviorRelay<[Post]>(value: [])

    private let fetchFavoritesUseCase: FetchFavoritesUseCase
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase

    init(repository: PostRepositoryProtocol) {
        self.fetchFavoritesUseCase = FetchFavoritesUseCase(repository: repository)
        self.toggleFavoriteUseCase = ToggleFavoriteUseCase(repository: repository)
    }

    func loadFavorites() {
        fetchFavoritesUseCase.execute()
            .bind(to: favorites)
            .disposed(by: DisposeBag())
    }
    // Remove post from favorites
        func removeFavorite(postId: Post) {
            toggleFavoriteUseCase.execute(postId: postId.id)
            loadFavorites()
        }
}
