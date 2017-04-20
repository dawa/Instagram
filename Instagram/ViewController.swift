//
//  ViewController.swift
//  Instagram
//
//  Created by Davis Wamola on 4/19/17.
//  Copyright © 2017 Davis Wamola. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

  @IBOutlet weak var trayView: UIView!

  @IBOutlet weak var arrowView: UIImageView!

  var trayOriginalCenter: CGPoint!
  var trayDown: CGPoint!
  var trayUp: CGPoint!
  var trayDownOffset: CGFloat!
  //let translation = CGPoint(x: 0.0, y: -145.0)

  var newlyCreatedFace: UIImageView!
  var newlyCreatedFaceCenter: CGPoint!

  override func viewDidLoad() {
    super.viewDidLoad()
    trayDownOffset = 145
    trayOriginalCenter = trayView.center
    trayUp = trayOriginalCenter
    trayDown =  CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y - trayDownOffset)
    trayDownOffset = 145
    newlyCreatedFaceCenter = trayOriginalCenter

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
    //let point = sender.location(in: view)
    //let translation = sender.translation(in: view)
    //print("translation \(translation)")

    if sender.state == .began {
      //print("Gesture began at: \(point)")
      trayOriginalCenter = trayView.center
    } else if sender.state == .changed {
      //print("Gesture changed at: \(point)")
      let velocity = sender.velocity(in: view)
      if velocity.y > 0 {
          // Panning up
          UIView.animate(withDuration: 0.3) {
            self.trayView.center = self.trayUp
            self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(0 * Double.pi / 180))
          }
      }
      else {
//        UIView.animate(withDuration: 0.3) {
//          self.trayView.center = self.trayDown
//        }

        // Animation with bounce effect
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.trayView.center = self.trayDown
                        self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(180 * Double.pi / 180))
        }, completion: nil)
      }
    } else if sender.state == .ended {
      //print("Gesture ended at: \(point)")
    }
  }

  @IBAction func onTapFaceGestureRecognizer(_ sender: UIPanGestureRecognizer) {
    let point = sender.location(in: view)

    if sender.state == .began {
      // Gesture recognizers know the view they are attached to
      let imageView = sender.view as! UIImageView

      // Create a new image view that has the same image as the one currently panning
      newlyCreatedFace = UIImageView(image: imageView.image)

      // Add the new face to the tray's parent view.
      view.addSubview(newlyCreatedFace)

      // Initialize the position of the new face.
      newlyCreatedFace.center = imageView.center

      // Since the original face is in the tray, but the new face is in the
      // main view, you have to offset the coordinates
      newlyCreatedFace.center.y += trayView.frame.origin.y

      // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
      let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
      let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(sender:)))

      // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
      newlyCreatedFace.isUserInteractionEnabled = true
      newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
      newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)

      pinchGestureRecognizer.delegate = self;
    } else if sender.state == .changed {
        self.newlyCreatedFace.center = point
    } else if sender.state == .ended {
    }
  }

  func didPan(sender: UIPanGestureRecognizer) {
    let location = sender.location(in: view)
    let translation = sender.translation(in: view)
    let imageView = sender.view as! UIImageView
    imageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    //    sender.translation = 0

    if sender.state == .began {
      print("didPan Gesture began at: \(location)")
    } else if sender.state == .changed {

    } else if sender.state == .ended {

    }
  }

  func didPinch(sender: UIPinchGestureRecognizer) {
    // get the scale value from the pinch gesture recognizer
    let scale = sender.scale
    let imageView = sender.view as! UIImageView
    imageView.transform = imageView.transform.scaledBy(x: scale, y: scale)
    sender.scale = 1
  }

  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

