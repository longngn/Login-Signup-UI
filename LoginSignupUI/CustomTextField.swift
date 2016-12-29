//
//  CustomTextField.swift
//  LoginSignupUI
//
//  Created by Nguyen Le Vu Long on 12/29/16.
//  Copyright © 2016 Nguyen Le Vu Long. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? CustomTextField {
            textField.showLabel()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? CustomTextField {
            textField.dismissLabel()
        }
    }
}

class CustomTextField: UITextField {
    var labelText: String?
    let localDelegate = TextFieldDelegate()
    let purple = UIColor(red:0.59, green:0.41, blue:0.82, alpha:1.0)
    var label: UILabel!
    
    private func commonInit() {
        labelText = text
        text = nil
        delegate = localDelegate
        
        // Add bottom border
        borderStyle = .none
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = purple.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width:  frame.size.width, height: frame.size.height)
        
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
    func showLabel() {
        let view = superview
        label = UILabel(frame: CGRect(x: frame.origin.x, y: frame.origin.y-20, width: frame.width, height: 20))
        label.text = labelText
        label.textColor = purple
        label.font = UIFont(name: "Comfortaa-Light", size: 14)
        view?.addSubview(label)
    }
    func dismissLabel() {
        label.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

}
