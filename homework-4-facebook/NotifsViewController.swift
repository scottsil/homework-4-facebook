//
//  NotifsViewController.swift
//  homework-4-facebook
//
//  Created by Scott Silverman on 2/27/15.
//  Copyright (c) 2015 Scott Silverman. All rights reserved.
//

import UIKit

class NotifsViewController: UIViewController {

    @IBOutlet weak var notificationsScrollView: UIScrollView!
    @IBOutlet weak var notificationsImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        notificationsScrollView.contentSize = notificationsImageView.frame.size
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
