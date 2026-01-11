//
//  Untitled.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 09/01/2026.
//

import UIKit
import RxSwift
import RxCocoa

class PostsViewController: UIViewController {

    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    private var viewModel: PostsViewModel

    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = PostsViewModel(repository: PostRepository())
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
        viewModel.loadPosts()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
           view.addSubview(tableView)

           tableView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ])

           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
    }

    private func bindUI() {

        viewModel.posts
            .bind(to: tableView.rx.items(
                cellIdentifier: "PostCell",
                cellType: UITableViewCell.self
            )) { _, post, cell in
                cell.textLabel?.text = post.title
                //cell.accessoryType = post.isFavorite ? .checkmark : .none
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Post.self)
            .subscribe(onNext: { [weak self] post in
                self?.viewModel.toggleFavorite(post: post)
                self?.navigateToFavorites()
            })
            .disposed(by: disposeBag)
    }

    private func navigateToFavorites() {
        tabBarController?.selectedIndex = 1
    }
}
