//
//  BaseErrorModel.swift
//  NewsMVVM
//
//  Created by Phincon on 08/07/21.
//

import Foundation

struct BaseErrorModel: Codable {
    let message: String?
    let status_code: Int?
}
