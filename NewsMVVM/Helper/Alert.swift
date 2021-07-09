//
//  Alert.swift
//  NewsMVVM
//
//  Created by Phincon on 08/07/21.
//

import Foundation

struct CustomAlert {
    var title: String
    var message: String
    var action: CustomAlertAction
}

struct CustomAlertAction {
    var title: String
    var action : (() -> Void)?
}

struct DefaultAlert {
    let title: String
    let message: String
    let actionButton: DefaultAlertAction
}

struct DefaultAlertAction {
    let title: String
    let handler: (() -> Void)?
}
