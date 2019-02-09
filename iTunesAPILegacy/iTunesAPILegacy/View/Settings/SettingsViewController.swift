//
//  SettingsViewController.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 6.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController, ViewModelBased {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: SettingsViewModel!

    override func setup() {
        super.setup()

        tableView.register(SettingsTableViewCell.self)
        bindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchHistories()
    }

    func bindings() {
        viewModel.dataSource.addObserver { [weak self] (_, _) in
            self?.tableView.reloadData()
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.value.0.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.value.0[section].cells.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.dataSource.value.0[section].title
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.backgroundView?.cornerRadius = 5
            header.textLabel?.textAlignment = .center
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
        cell.setup(viewModel.dataSource.value.0[indexPath.section].cells[indexPath.row])
        cell.setNeedsDisplay()
        cell.layoutIfNeeded()

        return cell
    }
}
