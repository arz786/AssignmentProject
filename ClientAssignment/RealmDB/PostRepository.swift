//
//  PostDataOperation.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 09/01/2026.
//

import RealmSwift

final class RealmPostStorage {

    private let realm: Realm

    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }

    // Save posts from API
    func save(posts: [Post]) {
        let entities = posts.map { post in
            let entity = PostRealmEntity()
            entity.id = post.id
            entity.title = post.title
            entity.body = post.body
           // entity.isFavorite = post.isFavorite
            return entity
        }

        try? realm.write {
            realm.add(entities, update: .modified)
        }
    }

    // Fetch all posts
    func fetchPosts() -> [Post] {
        realm.objects(PostRealmEntity.self).map {
            Post(
                id: $0.id,
                title: $0.title,
                body: $0.body,
                //isFavorite: $0.isFavorite
            )
        }
    }

    // Fetch favorites
    func fetchFavorites() -> [Post] {
        realm.objects(PostRealmEntity.self)
            .where { $0.isFavorite == true }
            .map {
                Post(
                    id: $0.id,
                    title: $0.title,
                    body: $0.body,
                  //  isFavorite: $0.isFavorite
                )
            }
    }

    // Toggle favorite
    func toggleFavorite(postId: Int) {
        guard let post = realm.object(
            ofType: PostRealmEntity.self,
            forPrimaryKey: postId
        ) else { return }

        try? realm.write {
            post.isFavorite.toggle()
        }
    }

    // Delete favorite
    func deleteFavorite(postId: Int) {
        guard let post = realm.object(
            ofType: PostRealmEntity.self,
            forPrimaryKey: postId
        ) else { return }

        try? realm.write {
            post.isFavorite = false
        }
    }
}
