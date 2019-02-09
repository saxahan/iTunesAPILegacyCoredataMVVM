//
//  AlertManager.swift
//  iTunesAPILegacy
//
//  Created by Yunus Alkan on 10.02.2019.
//  Copyright © 2019 Yunus Alkan. All rights reserved.
//

import UIKit

class AlertManager {

    static let shared = AlertManager()

    // MARK: Enums

    enum AlertType {
        case Info
        case Warning
        case Error
        case Success
    }

    enum AlertButtonType: String {
        case ok
        case cancel
        case yes
        case no

        var localized: String {
            return self.rawValue.uppercased().localized
        }
    }

    // MARK: Private getting top most
    
    fileprivate func topMostController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            return topController
        }

        return nil
    }

    // MARK - Alert

    func showAlert(withType alertType: AlertType? = .Info, title: String? = "", message: String, buttons: [String]? = nil, completion: ((Int) -> Void)! = nil) {
        let alertTitle = title!
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)

        if buttons == nil {
            alertController.addAction(UIAlertAction(title: AlertButtonType.ok.localized, style: .default, handler: { (action) in
                completion?(0)
            }))
        }
        else {

            for i in 0..<(buttons?.count)! {
                let alertAction = UIAlertAction(title: buttons?[i], style: .default, handler: { (action) in
                    completion?(i)
                })

                alertController.addAction(alertAction)

            }
        }

        if let topVc = topMostController() {
            alertController.view.center = topVc.view.center
            topVc.present(alertController, animated: true, completion: nil)
        }
    }

    func showAreYouSure(_ message: String, _ completion: @escaping () -> Void) {
        showAlert(message: message, buttons: [AlertManager.AlertButtonType.yes.localized, AlertManager.AlertButtonType.no.localized]) { (index) in
            if index == 0 {
                completion()
            }
        }
    }
}
