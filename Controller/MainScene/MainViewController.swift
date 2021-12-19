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
        
        //let nibName = UINib(nibName: "MainTableViewCell", bundle: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        super.viewDidLoad()
        // tableView.register(nibName, forCellReuseIdentifier: "MainCell")
        // Do any additional setup after loading the view.
    }
    
    func fetch() {// 게시글 패칭용
        // How To Make ?
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewTableViewCell", for: indexPath) as! MainViewTableViewCell
        cell.mainTableTitleLabel.text = "반갑다"
        cell.mainTableDescriptLabel.text = "조회수 + Date Info"
        cell.mianTableThumbnail.image = UIImage(systemName: "star.fill")
        cell.mianTableThumbnail.snp.makeConstraints {
            $0.size.height.equalTo(90)
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newVC = self.storyboard?.instantiateViewController(withIdentifier: "SubTabBarController") else { return }
        //
        
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true)
    }
}
