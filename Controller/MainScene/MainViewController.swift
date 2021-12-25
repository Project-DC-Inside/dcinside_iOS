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
        super.viewDidLoad()
        tableView.tableHeaderView = searchBar
        tableView.delegate = self
        tableView.dataSource = self
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
        //let postVC = PostViewController()
        guard let postVC = storyboard?.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController else { return }
        postVC.ChangePostInfos(info: TitleInfo(title: "POST@@@", url: "Not Yet"))
        let postNVC = UINavigationController(rootViewController: postVC)
        postNVC.modalTransitionStyle = .coverVertical
        postNVC.modalPresentationStyle = .fullScreen
        self.present(postNVC, animated: true, completion: nil)
    }
}
