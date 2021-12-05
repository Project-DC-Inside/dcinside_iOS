//
//  MainViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/04.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
        
    override func viewDidLoad() {
        tableView.tableHeaderView = searchBar
        //tableView.addSubview(searchBar)
        let nibName = UINib(nibName: "MainTableViewCell", bundle: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        super.viewDidLoad()
        tableView.register(nibName, forCellReuseIdentifier: "MainCell")
        // Do any additional setup after loading the view.
    }
    
    func fetch() {// 게시글 패칭용
        // How To Make ?
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        
        cell.title.text = "반갑다!"
        cell.imageView?.image = UIImage(systemName: "pencil.slash")
        cell.info.text = "조회수 + Date 정보"
        cell.sizeToFit()
        
        return cell
    }
        
    
    
}
