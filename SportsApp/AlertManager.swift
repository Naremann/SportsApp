//
//  AlertManager.swift
//  SportsApp
//
//  Created by Mostfa Sobaih on 29/04/2024.
//

import Foundation
import UIKit

class AlertManager {
    static func showAlertWithTitle(title: String, message: String, on viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    static func showAlertWithoutTitle(message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    static func showAlertForDeleteConfirmation(message: String, viewController: UIViewController, deleteHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Confirm Deletion", message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            deleteHandler()
        }
        alertController.addAction(yesAction)
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(noAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
