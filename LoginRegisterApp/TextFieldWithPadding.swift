//
//  TextFieldWithPadding.swift
//  LoginRegisterApp
//
//  Created by Акбала Тлеугалиева on 4/19/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import Foundation
import UIKit

class TextFieldWithPadding: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 16);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
