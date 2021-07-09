//
//  ViewController.swift
//  NewsMVVM
//
//  Created by Phincon on 08/07/21.
//

import UIKit

class NewsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = NewsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindView()
        registerTableView()
    }

    private func bindView(){
        
        viewModel.results.bind { [weak self](_) in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        viewModel.showErrors.bind { [weak self](error) in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(with: error)
            }
        }
        
        viewModel.fetchApi(with: "")
    }
    
    private func registerTableView(){
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.value?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let content = viewModel.results.value
        if content != nil {
            cell.setContent(with: (content?[indexPath.row])!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
