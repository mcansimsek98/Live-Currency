//
//  UIAlertController+AlertController.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

extension UIAlertController {
    
    static func showCustomAlert(title: String?, message: String?, 
                                hasSubtitles: Bool = false,
                                items: [AlertData],
                                height: CGFloat = 300,
                                selectedItems: [String],
                                presentingViewController: UIViewController,
                                completion: ((String?, Int) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.overrideUserInterfaceStyle = .dark
        
        let customTableViewController = CustomAlertTableViewWithCompletion()
        customTableViewController.items = items
        customTableViewController.hasSubtitle = hasSubtitles
        customTableViewController.selectedItems = selectedItems
        
        let customView = customTableViewController.view!
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        customTableViewController.didSelectItemHandler = { selectedItem, index in
            completion?(selectedItem, index)
        }
        
        alert.setValue(customTableViewController, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        presentingViewController.present(alert, animated: true, completion: nil)
    }
}
