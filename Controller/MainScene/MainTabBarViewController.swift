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
    
}
