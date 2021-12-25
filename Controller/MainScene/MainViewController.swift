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
        
        APIService.shared.RefreshAPI { response in
            switch response {
            case .success(let tokenInfo) :
                guard let token = tokenInfo as? TokenInfo else { return }
                let useToken = try? PropertyListEncoder().encode(token)
                UserDefaults.standard.set(useToken, forKey: "token")
            case .failure(let err):
                UserDefaults.standard.removeObject(forKey: "token")
                self.ErrMessage(error: err as! ErrInfo)
            case .networkErr:
                self.NetworkFailure()
            }
            
        }
    }
    
    func fetch() {// 게시글 패칭용
        // How To Make ?
    }
    private func NetworkFailure() {
        let alert = UIAlertController(title: "Network 실패!", message: "네트워크를 확인하세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    private func ErrMessage(error: ErrInfo) {
        let alert = UIAlertController(title: "세션 만료!", message: error.message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
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
