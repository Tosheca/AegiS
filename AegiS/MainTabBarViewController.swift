//
//  MainTabBarViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let vc1 = SecuritiesViewController()
        let vc2 = HomeViewController()
        let vc3 = ClientsViewController()
        
        self.viewControllers = [vc1, vc2, vc3]
        self.selectedIndex = 1
        self.selectedViewController = vc2
        
        vc1.title = "Securities"
        let item1 = UITabBarItem()
        //item2.title = "Home"
        item1.image = UIImage(systemName: "chart.bar")?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0))
        item1.selectedImage = UIImage(systemName: "chart.bar.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        vc1.tabBarItem = item1
        
        vc2.title = "Home"
        let item2 = UITabBarItem()
        //item2.title = "Home"
        item2.image = UIImage(systemName: "house")?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        item2.selectedImage = UIImage(systemName: "house.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        vc2.tabBarItem = item2
        
        vc3.title = "Clients"
        let item3 = UITabBarItem()
        //item3.title = "Clients"
        item3.image = UIImage(systemName: "person.3")?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        item3.selectedImage = UIImage(systemName: "person.3.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        vc3.tabBarItem = item3

        self.edgesForExtendedLayout = []
        
        self.tabBar.barStyle = .black
        self.tabBar.tintColor = .white
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
