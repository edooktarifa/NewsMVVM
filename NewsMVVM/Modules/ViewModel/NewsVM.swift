//
//  NewsVM.swift
//  NewsMVVM
//
//  Created by Phincon on 08/07/21.
//

import Foundation
import UIKit
import Alamofire

class NewsVM {
    
    var results : Bindable<[Articles]?> = Bindable([])
    var isLoading = Bindable(false)
    
    
    // MARK: handle error with clousure
    var showError : ((_ error: DefaultAlert) -> Void)?
    
    //MARK: handle error with observable
    var showErrors : Bindable<DefaultAlert?> = Bindable(nil)
    
    func fetchApi(with nation: String){
        isLoading.value = true
        APIServices.shared.request(url: "\(Constant.baseURL)top-headlines?country=id&apiKey=c766e9bd546f46f096873d6b0d53e471", method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { [weak self](result: NewsModel?, errorModel: BaseErrorModel?, error) in
        
            guard let self = self else { return }
            
            self.isLoading.value = false
            
            if let _ = error {
                let showErrorNetwork = DefaultAlert(title: "Error", message: "Please Check Your Internet Connection", actionButton: DefaultAlertAction(title: "OK", handler: {
                    print("selected")
                }))
//                self.showError?(showErrorNetwork)
                self.showErrors.value = showErrorNetwork
                
            } else if let errorModel = errorModel {
                
            } else {
                guard let result = result else { return }
        
                self.results.value = result.articles ?? []
                
            }
        }
    }
}
