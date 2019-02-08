//
//  ChoicePopup.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class ChoicePopup<T: SectionViewModel<FilterRowViewModel>>: Popup, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectButton: HoldableButton!

    var completionBlock: PopupCompletion<T>?
    var allowsMultiSelection: Bool = false
    var filters: [T]!

    override func setup() {
        super.setup()

        tableView.register(ChoiceTableViewCell.self)
        tableView.allowsMultipleSelection = allowsMultiSelection

        DispatchQueue.main.async { [unowned self] in
            if let row = self.filters[0].selected?.row {
                self.tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .bottom)
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return filters.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChoiceTableViewCell.identifier, for: indexPath) as! ChoiceTableViewCell
        cell.setup(filters[indexPath.section].cells[indexPath.row])
        cell.setNeedsDisplay()
        cell.layoutIfNeeded()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filters[0].selected?.section = indexPath.section
        self.filters[0].selected?.row = indexPath.row
    }

    // MARK: Actions
    @IBAction func okTapped(_ sender: Any) {
        dismiss { [weak self] in
            self?.completionBlock?(self?.filters[0])
        }
    }
}

extension ChoicePopup {
    class func create(_ filters: [T], allowsMultiSelection: Bool = false, completion: PopupCompletion<T>? = nil) -> ChoicePopup {
        let popup = ChoicePopup.initFromNib(name: "ChoicePopup")
        popup.allowsMultiSelection = allowsMultiSelection
        popup.filters = filters
        popup.completionBlock = completion
        return popup
    }
}
