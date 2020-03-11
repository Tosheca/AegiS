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
        vc1.view.backgroundColor = .blue
        
        vc2.title = "Home"
        vc2.view.backgroundColor = .red
        
        vc3.title = "Clients"
        vc3.view.backgroundColor = .yellow
        
        self.edgesForExtendedLayout = []
        
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
