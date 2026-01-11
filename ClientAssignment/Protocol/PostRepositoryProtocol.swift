//
//  Untitled.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 10/01/2026.
//

import RxSwift

protocol PostRepositoryProtocol {
    func fetchPosts() -> Observable<[Post]>
    func fetchFavorites() -> Observable<[Post]>
    func toggleFavorite(postId: Int)
}
