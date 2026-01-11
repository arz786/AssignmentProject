//
//  RealmModel.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 08/01/2026.
//

import RealmSwift

class LoginSession: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var email: String = ""
    @Persisted var isLoggedIn: Bool = false
}
