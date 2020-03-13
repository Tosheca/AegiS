//
//  ClientsViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class ClientsViewController: UIViewController {

    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = []
        
        backgroundImage.frame.size = self.view.frame.size
        backgroundImage.contentMode = .scaleAspectFill
        
        self.view.addSubview(backgroundImage)
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
