//
//  PostViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/04.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension PostViewController {
    func FetchingData() {
        // escaping Closure 이후,
        // activityIndicator Animating 종료
        // activityIndicator alpha값 조정해서 지우기..
    }
    
    func ConfigureFetching(completion: @escaping () -> ()) {
        
        
    }
    
    
}
