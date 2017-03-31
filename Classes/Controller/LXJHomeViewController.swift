//
//  LXJHomeViewController.swift
//  LXJView_Swift
//
//  Created by xiaojuan on 17/3/29.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

import UIKit

class LXJHomeViewController: UIViewController {

    var headerView : LXJHeaderView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.title = ""
        
        headerView = LXJHeaderView.init(frame: CGRect(x:(SCREEN_W-80)/2, y:12, width:40, height:40))
        headerView.basicVc = self
        self.navigationItem.titleView = headerView
        
        print(NSHomeDirectory())
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
