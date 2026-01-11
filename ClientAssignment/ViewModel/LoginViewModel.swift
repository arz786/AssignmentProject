//
//  LoginViewModel.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 08/01/2026.
//

import RxSwift
import RealmSwift
import RxCocoa

class LoginViewModel {

    // Inputs
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    // Outputs
    var isFormValid: Observable<Bool> {
        Observable.combineLatest(email, password) { email, password in
            return email.isValidEmail &&
                   password.count >= 8 &&
                   password.count <= 15
        }
    }

    func saveLogin() {
        let realm = try! Realm()
        let session = LoginSession()
        session.id = 0
        session.email = email.value
        session.isLoggedIn = true

        try! realm.write {
            realm.add(session, update: .modified)
        }
    }
}
