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
    
    func fetchApi(with nation: String){
        isLoading.value = true
        APIServices.shared.request(url: "\(Constant.baseURL)top-headlines?country=id&apiKey=c766e9bd546f46f096873d6b0d53e471", method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { [weak self](result: NewsModel?, errorModel: BaseErrorModel?, error) in
        
            guard let self = self else { return }
            
            self.isLoading.value = false
            
            if let error = error {
                
            } else if let errorModel = errorModel {
                
            } else {
                guard let result = result else { return }
        
                self.results.value = result.articles ?? []
                
            }
        }
    }
}
