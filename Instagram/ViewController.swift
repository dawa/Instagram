//
//  ViewController.swift
//  Instagram
//
//  Created by Davis Wamola on 4/19/17.
//  Copyright © 2017 Davis Wamola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var trayView: UIView!

  @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!

  var trayOriginalCenter: CGPoint!
  var trayCenterWhenOpen: CGPoint!
  var trayCenterWhenClosed: CGPoint!
  let translation = CGPoint(x: 0.0, y: -300.0)


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    trayOriginalCenter = trayView.center
    trayCenterWhenClosed = trayView.center
    trayCenterWhenOpen =  CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
    let point = panGestureRecognizer.location(in: view)


    if panGestureRecognizer.state == .began {
      print("Gesture began at: \(point)")
      trayView.center = point
    } else if panGestureRecognizer.state == .changed {
      print("Gesture changed at: \(point)")
      let velocity = panGestureRecognizer.velocity(in: view)
      if velocity.y > 0 {
          // Moving down
//          UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
//             self.trayView.center = CGPoint(x: self.trayCenterWhenOpen.x, y: self.trayCenterWhenOpen.y - self.translation.y)
//          }, completion: { (finished) in
//            print("animation completed!")
//          })


        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
          self.trayView.center = CGPoint(x: self.trayCenterWhenOpen.x, y: self.trayCenterWhenOpen.y - self.translation.y)
        }, completion: { (finished) in
          print("animation completed!")
        })
      }
      else {
         UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
          self.trayView.center = CGPoint(x: self.trayCenterWhenClosed.x, y: self.trayCenterWhenClosed.y + self.translation.y)
        }, completion: { (finished) in
          print("animation completed!")
        })


      }

    } else if panGestureRecognizer.state == .ended {
      print("Gesture ended at: \(point)")
    }
  }
}

