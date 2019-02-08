//
//  ChoicePopup.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 8.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class ChoicePopup: Popup {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectButton: HoldableButton!

    class func create(_ daataSource: [CellViewModel], completion: PopupCompletion? = nil) -> ChoicePopup {
        let popup = ChoicePopup.initFromNib()
        popup.completionBlock = completion
        return popup
    }

    override func setup() {
        super.setup()

        tableView.register(ChoiceTableViewCell.self)

    }
}

extension ChoicePopup: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
