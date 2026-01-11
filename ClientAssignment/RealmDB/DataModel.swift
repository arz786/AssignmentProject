//
//  DataModel.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 09/01/2026.
//

import RealmSwift

class PostRealmEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var isFavorite: Bool
}

