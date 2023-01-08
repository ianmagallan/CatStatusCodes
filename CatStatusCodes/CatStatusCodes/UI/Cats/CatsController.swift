//
//  CatsController.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import Combine
import UIKit

final class CatsTableViewController: UITableViewController {
    // MARK: - Properties -

    private let viewModel = CatsViewModel()
    private var cancellableBag = Set<AnyCancellable>()

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        registerCells()
        bindViewModel()
    }

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
    }

    private func registerCells() {
        tableView.register(
            UINib(nibName: String(describing: CatTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: CatTableViewCell.reuseIdentifier
        )
    }

    private func bindViewModel() {
        viewModel.didUpdateCats.sink { [weak self] in
            self?.tableView?.reloadData()
        }.store(in: &cancellableBag)
        
        viewModel.start()
    }
}

// MARK: - TableView lifecycle -

extension CatsTableViewController {
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.cats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatTableViewCell.reuseIdentifier) as! CatTableViewCell
        let lastSeenString = viewModel.lastSeen(forRow: indexPath.row)
        cell.theImageView.image = lastSeenString == nil ? UIImage(named: "imMysteriousCat") : UIImage(named: "imCheckmarkCat")
        cell.descriptionLabel.text = viewModel.makeFullDescription(forRow: indexPath.row)
        cell.lastSeenLabel.text = lastSeenString
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Bundle.main.loadNibNamed(
            String(describing: CatDetailsController.self),
            owner: self,
            options: nil
        )?.first as! CatDetailsController
        vc.statusCode = viewModel.cats[indexPath.row].statusCode
        present(vc, animated: true) { [weak self] in
            self?.viewModel.updateLastSeenDate(forRow: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}
