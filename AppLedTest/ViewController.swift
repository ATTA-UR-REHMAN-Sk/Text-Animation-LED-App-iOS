//
//  ViewController.swift
//  AppLedTest
//
//  Created by apple on 14/04/2023.
//

import UIKit

class ViewController: UIViewController {
        let label = UILabel()
        var timer: Timer?
        var yPos: CGFloat = 500 // starting position of label
        
        override func viewDidLoad() {
            super.viewDidLoad()
            label.frame = CGRect(x: 0, y: yPos, width: 50, height: view.bounds.height)
            label.text = "Initial text"
            label.font = .systemFont(ofSize: 40)
            label.textColor = .blue
            label.shadowColor = .orange
            //label.shadowOffset = .init(width: 40, height: 20)
            label.textAlignment = .center
            label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
            view.addSubview(label)
            
            startAnimation()
            startBlinking()
            startGlowing()
        }
    
  //   Create the glowing animation
       func startGlowing() {
           let animation = CABasicAnimation(keyPath: "shadowOpacity")
           animation.fromValue = 0.0
           animation.toValue = 1.0
           animation.duration = 0.5
           animation.repeatCount = .infinity
           animation.autoreverses = true
           animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
           label.layer.add(animation, forKey: "glowingAnimation")
       }
    
    // Create the blinking animation
      func startBlinking() {
          UIView.animate(withDuration: 0.8, delay: 0, options: [.autoreverse, .repeat], animations: {
              self.label.alpha = 0
          }, completion: nil)
  
          // Animate label
          repeat {
              UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                  self.label.center = CGPoint(x: self.view.bottomAnchor.accessibilityActivationPoint.y, y: self.view.bounds.height - self.label.bounds.height)
              }, completion: nil)
          } while(label.alpha == 10)
      }
    
        func startAnimation() {
            if yPos == -500 {
                yPos = 500
                timer = nil
                timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
            } else {
                timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
            }
        }
        
        @objc func updateLabel() {
            yPos -= 2 // adjust this value to change the speed of animation
            
            if yPos <= -500 { // stop animation when label reaches top of screen
                startAnimation()
                //timer?.invalidate()
                
            } else {
                label.frame = CGRect(x: 200, y: yPos, width: 50, height: view.bounds.height)
                label.text = "New text"
            }
        }
    }

