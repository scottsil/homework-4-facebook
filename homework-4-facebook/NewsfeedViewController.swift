//
//  NewsfeedViewController.swift
//  homework-4-facebook
//
//  Created by Scott Silverman on 2/26/15.
//  Copyright (c) 2015 Scott Silverman. All rights reserved.
//

import UIKit

class NewsfeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UIScrollViewDelegate {

    @IBOutlet weak var newsfeedScrollView: UIScrollView!
    @IBOutlet weak var newsfeedImageView: UIImageView!
    
    var isPresenting: Bool = true
    var selectedImageView: UIImageView!
    var imageView: UIImageView!
   var movingImageView: UIImageView!
    var scrollOffset: CGFloat! = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        newsfeedScrollView.backgroundColor = UIColor(red:0.827, green:0.839, blue:0.859, alpha: 1)
        newsfeedScrollView.contentSize = newsfeedImageView.frame.size
        newsfeedScrollView.frame.size = CGSize(width: 320, height: 455)
        newsfeedScrollView.delegate = self
        
        println("newsfeed view did load")
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

    @IBAction func didTapPhoto(sender: AnyObject) {
        
        // Gets the image view from the sender (the tapped photo) and then performs the identified segue
        imageView = sender.view as UIImageView
        selectedImageView = imageView
        performSegueWithIdentifier("detailPhotoSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Creates a reference to a destination view controller and casts it as PhotoViewController
        var destinationVC = segue.destinationViewController as PhotoViewController
        
        // Sets the photo variable in the destination VC as the selected image
        destinationVC.photo = selectedImageView.image
        
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollOffset = newsfeedScrollView.contentOffset.y
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            
            movingImageView = UIImageView(image: selectedImageView.image)
            movingImageView.contentMode = selectedImageView.contentMode
            movingImageView.clipsToBounds = selectedImageView.clipsToBounds
            
            println("initial frame | x:\(selectedImageView.frame)")

            var window = UIApplication.sharedApplication().keyWindow!
            window.addSubview(movingImageView)

            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            var photoViewController = toViewController as PhotoViewController
            
            var frame = containerView.convertRect(selectedImageView.frame, fromView: newsfeedScrollView)
            movingImageView.frame = frame
            
            var height = (320 * selectedImageView.image!.size.height) / selectedImageView.image!.size.width
            var endFrame = CGRect(x: 0, y: (view.frame.size.height - height) / 2, width: 320, height: height)
            photoViewController.imageView.frame = endFrame
            
            photoViewController.imageView.hidden = true
            
            // var finalImageView = photoViewController.imageView
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                println("before moving image view: \(self.movingImageView.frame)")
                self.movingImageView.frame = photoViewController.imageView.frame
                println("after moving image view: \(self.movingImageView.frame)")
                }) { (finished: Bool) -> Void in
                    photoViewController.imageView.hidden = false
                    self.movingImageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
         
        } else {
            var window = UIApplication.sharedApplication().keyWindow!
            window.addSubview(movingImageView)
            println("end 1 moving image view: \(movingImageView.frame)")
            
            var frame = containerView.convertRect(selectedImageView.frame, fromView: newsfeedScrollView)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                self.movingImageView.frame = frame
                }) { (finished: Bool) -> Void in
                    self.movingImageView.removeFromSuperview()
                    println("end moving image view: \(self.movingImageView.frame)")
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
        
    }
    
}
