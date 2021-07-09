//
//  ViewController.swift
//  NewsMVVM
//
//  Created by Phincon on 08/07/21.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = NewsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindView()
        registerTableView()
    }

    private func bindView(){
        viewModel.isLoading.bind { (visible) in
            self.tableView.visibleCells.forEach { $0.showSkeleton() }
        }
        
        viewModel.results.bind { (_) in
            self.tableView.reloadData()
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
