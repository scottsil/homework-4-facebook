//
//  PhotoViewController.swift
//  homework-4-facebook
//
//  Created by Scott Silverman on 2/27/15.
//  Copyright (c) 2015 Scott Silverman. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var photoActions: UIImageView!
    @IBOutlet var photoView: UIView!
    
    var photo: UIImage!
    var scrollOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailScrollView.contentSize = detailImageView.frame.size
        
        imageView.image = photo
        
        detailScrollView.delegate = self
        
        println("view did load")
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

    @IBAction func doneButtonDidPress(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){ // any offset changes
        scrollOffset = detailScrollView.contentOffset.y
        println("scrolling: \(scrollOffset)")
        var backgroundAlpha = 1 - abs(scrollOffset)/100
        photoView.backgroundColor = UIColor(white:0, alpha: backgroundAlpha)
        
    }
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.doneButton.alpha = 0
            self.photoActions.alpha = 0
        })
    }
    
    
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (abs(scrollOffset) > 80) {
            delay(0.05, { () -> () in
                self.detailScrollView.hidden = true
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.doneButton.alpha = 1
                self.photoActions.alpha = 1
            })
        }
    }
    
    
    
    
}
