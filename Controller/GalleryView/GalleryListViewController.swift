//
//  GalleryListViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/26.
//

import UIKit

class GalleryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension GalleryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //dummy data
        return 10
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension GalleryListViewController: UITableViewDelegate {
    
}
