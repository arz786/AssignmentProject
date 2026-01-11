//
//  PostService.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 09/01/2026.
//

import Alamofire
import RxSwift

final class PostRepository: PostRepositoryProtocol {

    private let storage = RealmPostStorage()

    func fetchPosts() -> Observable<[Post]> {
        Observable.create { observer in

            AF.request("https://jsonplaceholder.typicode.com/posts")
                .responseDecodable(of: [Post].self) { response in

                    if let dto = response.value {
                        let posts = dto.map {
                            Post(
                                id: $0.id,
                                title: $0.title,
                                body: $0.body,
                               // isFavorite: false
                            )
                        }

                        //  Save to Realm after API success
                        self.storage.save(posts: posts)

                        observer.onNext(posts)
                        observer.onCompleted()

                    } else {
                        // Offline fallback
                        let cachedPosts = self.storage.fetchPosts()
                        observer.onNext(cachedPosts)
                        observer.onCompleted()
                    }
                }

            return Disposables.create()
        }
    }

    func fetchFavorites() -> Observable<[Post]> {
        Observable.just(storage.fetchFavorites())
    }

    func toggleFavorite(postId: Int) {
        storage.toggleFavorite(postId: postId)
    }

    func deleteFavorite(postId: Int) {
        storage.deleteFavorite(postId: postId)
    }
}
