//
//  BaseVC.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

class BaseVC: UIViewController {
    func presentAlert(with title: String? = "Error",
                      message: String? = nil,
                      alertStyle: UIAlertController.Style = .actionSheet,
                      okBtnTitle: String? = "Cancel",
                      buttonAction:(()->Void)? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: alertStyle)
        
        let cancelAction = UIAlertAction(title: okBtnTitle, style: alertStyle == .actionSheet ? .cancel : .default) { (action:UIAlertAction) in
            if let act = buttonAction {
                act()
            }
        }
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func goBackAction() {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
}
