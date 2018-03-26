//
//  ViewController.swift
//  BullsEye
//
//  Created by Larissa Barra Conde on 26/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    var currentValue: Int = 50
    var targetValue: Int = 0
    var roundCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSliderMove(_ sender: UISlider) {
        print("slider value: \(sender.value)")
        currentValue = lroundf(sender.value)
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        print("button pressed")
        print("final slider value: \(currentValue)")
        print("target value: \(targetValue)")
        
        let alert = UIAlertController(title: "Hello World", message: "my first app", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: ({_ in
                self.startNewRound()
            })
        )
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func startNewRound() {
        resetTarget()
        
        resetSlider()
        
        incrementRoundCount()
        
        print("new target value: \(targetValue)")
        print("round: \(roundCount)")
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
}

