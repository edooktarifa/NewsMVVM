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
    var title: String
    var message: String
    var actionn: DefaultAlertAction
}

struct DefaultAlertAction {
    var title: String
    var action: (() -> Void)?
}
