//
//  FavoritesViewController.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 10/01/2026.
//
import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {

    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    private let viewModel: FavoritesViewModel

    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = FavoritesViewModel(repository: PostRepository())
        super.init(coder: coder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadFavorites()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavCell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    private func bindUI() {

        viewModel.favorites
            .bind(to: tableView.rx.items(
                cellIdentifier: "FavCell",
                cellType: UITableViewCell.self
            )) { _, post, cell in
                cell.textLabel?.text = post.title
            }
            .disposed(by: disposeBag)

        // Swipe to delete
        tableView.rx.itemDeleted
            .withLatestFrom(viewModel.favorites) { indexPath, posts in
                posts[indexPath.row]
            }
            .subscribe(onNext: { [weak self] post in
                self?.viewModel.removeFavorite(postId: post)
            })
            .disposed(by: disposeBag)
    }
}
