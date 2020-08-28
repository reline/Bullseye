//
//  ViewController.swift
//  Bullseye
//
//  Created by Nathan Reline on 8/27/20.
//  Copyright © 2020 Nathan Reline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    var targetValue = 0
    var round = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }
    
    func generateRandomValue() -> Int {
        return Int.random(in: Int(slider.minimumValue)...Int(slider.maximumValue))
    }

    @IBAction func onHitMeButtonClicked() {
        let sliderValue = Int(slider.value.rounded())
        let diff = abs(targetValue - sliderValue)
        let range = slider.maximumValue - slider.minimumValue + 1
        let points = diff == 0 ? Int(slider.maximumValue) * 2 : Int(range) - diff
        score += points
        
        let title: String
        if (diff == 0) {
            title = "Bullseye!"
        } else if (diff < 5) {
            title = "So close!"
        } else if (diff < 10) {
            title = "Almost!"
        } else {
            title = "What are you aiming at?"
        }

        let alert = UIAlertController(title: title, message: "You earned \(points) points", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onStartOverButtonClicked() {
        round = 0
        score = 0
        startNewRound()
    }
    
    @IBAction func onInfoButtonClicked() {
        // todo
    }
    
    func startNewRound() {
        round += 1
        roundLabel.text = String(round)
        scoreLabel.text = String(score)
        targetValue = generateRandomValue()
        targetValueLabel.text = String(targetValue)
        slider.value = slider.maximumValue / 2
    }

}

