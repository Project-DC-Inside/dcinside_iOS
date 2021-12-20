//
//  PostViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/04.
//

import UIKit

class GalleryListViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        activityIndicator.startAnimating()
        ConfigureFetching {
            var x = 0
            while x < 100000 {
                x += 1
            }
            self.activityIndicator.stopAnimating()
        }
        // Do any additional setup after loading the view.
    }

}

extension GalleryListViewController {
    func FetchingData() {
        // escaping Closure 이후,
        // activityIndicator Animating 종료
        // activityIndicator alpha값 조정해서 지우기..
    }
    
    func ConfigureFetching(completion: @escaping () -> ()) {
        
        
    }
    
    func configNav() {
        navigationItem.title = "GalleryList"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func didTapBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
