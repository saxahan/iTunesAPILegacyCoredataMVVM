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

    override func setup() {
        super.setup()
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
