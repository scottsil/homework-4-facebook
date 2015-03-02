//
//  RequestsViewController.swift
//  homework-4-facebook
//
//  Created by Scott Silverman on 2/26/15.
//  Copyright (c) 2015 Scott Silverman. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {

    @IBOutlet weak var requestsScrollView: UIScrollView!
    @IBOutlet weak var requestsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        requestsScrollView.contentSize = requestsImageView.frame.size
        requestsScrollView.backgroundColor = UIColor(red:0.953, green:0.957, blue:0.961, alpha: 1)
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
