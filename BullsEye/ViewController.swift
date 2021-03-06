//
//  ViewController.swift
//  BullsEye
//
//  Created by Larissa Barra Conde on 26/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//
import QuartzCore
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    var score: Int = 0
    var currentValue: Int = 50
    var targetValue: Int = 0
    var roundCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        styleSlider()
        startNewGame()
    }

    @IBAction func onSliderMove(_ sender: UISlider) {
        currentValue = lroundf(sender.value)
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        let points = calculateRoundScore()
        
        let alert = UIAlertController(title: "Hello World", message: "You hit \(currentValue).\nThat's \(points) points on this round!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: ({_ in
                self.startNewRound()
            })
        )
        alert.addAction(action)
        
        score += points
        scoreLabel.text = String(score)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        startNewGame()
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func calculateRoundScore() -> Int {
        let difference = abs(targetValue - currentValue)
        return (100 - difference)
    }
    
    func startNewGame() {
        roundCount = 0
        score = 0
        displayScore()
        startNewRound()
    }
    
    func startNewRound() {
        resetTarget()
        
        resetSlider()
        
        incrementRoundCount()
    }
    
    fileprivate func displayScore() {
        scoreLabel.text = String(score)
    }
    
    fileprivate func resetTarget() {
        targetValue = 1 + Int(arc4random_uniform(100))
        targetLabel.text = String(targetValue)
    }
    
    fileprivate func resetSlider() {
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    fileprivate func incrementRoundCount() {
        roundCount += 1
        roundLabel.text = String(roundCount)
    }
    
    fileprivate func styleSlider() {
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
}

