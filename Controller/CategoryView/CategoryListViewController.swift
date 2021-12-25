//
//  PostViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/04.
//

import UIKit

class CategoryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var galleryCategory: [GalleryCategory] = [
        GalleryCategory(opened: false, title: "섹션1", cells: []),
        GalleryCategory(opened: false, title: "갤러리 종류", cells: [GalleryCell(galleryTitle: "갤러리1", url: "1"), GalleryCell(galleryTitle: "갤러리2", url: "2") ])
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "CategoryListTableViewCell")
        
        ConfigNav()
        activityIndicator.startAnimating()
        // Do any additional setup after loading the view.
    }

}

extension CategoryListViewController {
    func FetchingData() {
        // escaping Closure 이후,
        // activityIndicator Animating 종료
        // activityIndicator alpha값 조정해서 지우기..
    }
    
    func ConfigNav() {
        navigationItem.title = "GalleryList"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(DidTapButton))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func DidTapButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CategoryListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return galleryCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if galleryCategory[section].opened == true {
            // tableView Section이 열려있으면 Section Cell 하나에 sectionData 개수만큼 추가해줘야 함
            return galleryCategory[section].cells.count + 1
        } else {
            // tableView Section이 닫혀있을 경우에는 Section Cell 하나만 보여주면 됨
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListTableViewCell", for: indexPath)
                    as? TableViewCell else { return UITableViewCell() }
            cell.configureUI()
            cell.tableLabel.text = galleryCategory[indexPath.section].title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListTableViewCell", for: indexPath)
                    as? TableViewCell else { return UITableViewCell() }
            cell.configureUI()
            cell.tableLabel.text = galleryCategory[indexPath.section].cells[indexPath.row - 1].galleryTitle
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        print(indexPath.row, indexPath.section)
        if indexPath.row == 0 {
            galleryCategory[indexPath.section].opened = !galleryCategory[indexPath.section].opened
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            print("이건 sectionData 선택한 거야")
        }
        print([indexPath.section], [indexPath.row])
    }
}

extension CategoryListViewController : UITableViewDelegate {
    
}
