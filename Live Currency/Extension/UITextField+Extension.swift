//
//  UITextField+Extension.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

extension UITextField {

    func addDoneButton() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.current?.bounds.width ?? UIScreen.main.bounds.width, height: 44))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(image: .close, style: .done, target: self, action: #selector(doneButtonTapped))
        doneToolbar.items = [flexSpace, doneButton]
        inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonTapped() {
        resignFirstResponder()
    }
}
