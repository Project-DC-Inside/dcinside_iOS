//
//  PostViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/20.
//

import UIKit

class PostViewController: UIViewController {
    var titleText: String?
    var urlInfo: String?
    
    lazy var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChangePostInfo()
        self.navigationItem.titleView = label
    }
    
    @IBAction func DissmissPost(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func ChangePostInfos(info: TitleInfo) {
        self.titleText = info.title
        self.urlInfo = info.url
    }
    
    func ChangePostInfo() {
        guard let title = self.titleText else { return }
        guard let url = self.urlInfo else { return }
        let tap = UITapGestureRecognizer(target: self, action: #selector(GoToGallery))
        self.label.text = title
        self.label.isUserInteractionEnabled = true
        self.label.addGestureRecognizer(tap)
        //self.navigationItem.titleView =
    }
    
    @objc func GoToGallery() {
        guard let newVC = self.storyboard?.instantiateViewController(withIdentifier: "SubTabBarController") else { return }
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true)
    }
    
}
