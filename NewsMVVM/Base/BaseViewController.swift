//
//  BaseViewController.swift
//  NewsMVVM
//
//  Created by Phincon on 09/07/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(with alerts: DefaultAlert){
        let alert = UIAlertController(title: alerts.title, message: alerts.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alerts.actionButton.title, style: .default, handler: { (_) in
            alerts.actionButton.handler?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
