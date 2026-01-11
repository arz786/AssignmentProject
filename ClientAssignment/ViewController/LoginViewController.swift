//
//  LoginViewController.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 08/01/2026.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    private func bindUI() {

        emailTF.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordTF.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        // Enable / Disable submit button
      //  viewModel.isFormValid
           // .bind(to: submitButton.rx.isEnabled)
           // .disposed(by: disposeBag)

        submitButton.rx.tap
            .withLatestFrom(Observable.combineLatest(viewModel.email, viewModel.password))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] email, password in
                guard let self = self else { return }

                //  Invalid email popup
                if !email.isValidEmail {
                    self.showAlert(
                        title: "Invalid Email",
                        message: "Please enter a valid email address."
                    )
                    return
                }

                //  Invalid password popup
                if password.count < 8 || password.count > 15 {
                    self.showAlert(
                        title: "Invalid Password",
                        message: "Password must be between 8 and 15 characters."
                    )
                    return
                }

                //  Valid input → Save & Navigate
                self.viewModel.saveLogin()
                self.navigateToPost()
            })
            .disposed(by: disposeBag)
    }

    private func navigateToPost() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "MainTabBarController"
        ) as? MainTabBarController else {
            assertionFailure("PostViewController not found")
            return
        }

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
