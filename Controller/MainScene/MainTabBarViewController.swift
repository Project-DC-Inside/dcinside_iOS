//
//  MainTabBarViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/16.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let MainNavi = storyboard?.instantiateViewController(withIdentifier: "MainNavi") ?? UIViewController()
        let MainNotice = storyboard?.instantiateViewController(withIdentifier: "MainNoticeNavi") ?? UIViewController()
        MainNotice.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book.fill"))
        let MainSearch = storyboard?.instantiateViewController(withIdentifier: "MainSearchNavi") ?? UIViewController()
        
        viewControllers = [MainNavi, MainNotice, MainSearch]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
