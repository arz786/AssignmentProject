//
//  PostViewModel.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 09/01/2026.
//

import RxSwift
import RxCocoa

 class PostsViewModel {

    private let repository: PostRepositoryProtocol
        let posts = BehaviorRelay<[Post]>(value: [])
        private let disposeBag = DisposeBag()
     
        init(repository: PostRepositoryProtocol) {
            self.repository = repository
        }

        func loadPosts() {
            repository.fetchPosts()
                .bind(to: posts)
                .disposed(by: disposeBag)
        }

        func toggleFavorite(post: Post) {
            repository.toggleFavorite(postId: post.id)
        }
}
