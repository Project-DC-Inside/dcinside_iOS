//
//  GalleryAddScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation
import UIKit

protocol GalleryAddSceneProtocol: AnyObject {
    func setViews()
    func reloadData()
    func setAlert(title: String, content: String, success: Bool)
}

class GalleryAddScenePresenter: NSObject {
    private weak var viewController: GalleryAddSceneProtocol?
    private var presenter: GalleryNamePresenter? = nil
    
    init(viewController: GalleryAddSceneProtocol?) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setViews()
    }
    
    func viewWillAppear() {
        viewController?.reloadData()
    }
    
    func didTappedSubmitButton(type: String) {
        guard let text = presenter?.getContents() else { return }
        print("TEXT",text, type)
        let gallery = GalleryRequest(type: type.uppercased(), name: text)
        APIService.shared.submitNewGallery(gallery: gallery) { [weak self] res in
            switch res {
            case .success(let galleryInfo):
                if galleryInfo.success {
                    self?.viewController?.setAlert(title: "성공!", content: "갤러리가 생성되었습니다!", success: galleryInfo.success)
                } else {
                    self?.viewController?.setAlert(title: "실패", content: galleryInfo.error?.message ?? "", success: galleryInfo.success)
                }
            case .failure(let error):
                self?.viewController?.setAlert(title: "실패", content: "Network 에러", success: false)
                print(error.localizedDescription)
            }
        }
    }
}

extension GalleryAddScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryNameCells", for: IndexPath(row: 0, section: 0)) as! GalleryNameCells
        presenter = GalleryNamePresenter(tableViewCell: cell)
        cell.basicSetting(presenter: presenter!)
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
