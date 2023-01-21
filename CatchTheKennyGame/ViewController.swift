//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Nazlı on 16.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 5   //sürenin başlangıç değeri
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score \(score)"
        
        //Highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        //images
        kenny1.isUserInteractionEnabled = true //tıklanabilir olması.
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        //fonsiyonu değişkene atadık.
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        //resimlere jest algılayıcı ekledik.
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        
        
        
        slider.minimumValue = 0
        slider.maximumValue = 20
        slider.value = 10
        timeLabel.text = String(Int(slider.value))

        
    
        //Timer
        //counter = Int(slider.value)
        //timeLabel.text = String(counter)
       timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)   //Oyun süresi timer ı
        
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)   //resimlerin görünürlük timer ı
        
        hideKenny()
        
    }
    
    
    @objc func hideKenny(){
        for kenny in kennyArray {
            kenny.isHidden = true  //herşeyden önce hepsini görünmez yapacak.
        }
        
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1))) //indexi kadarı içerisinde random belirler.
        kennyArray[random].isHidden = false   //random gelen indexi görünür yapacak.
        
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        
            slider.value -= 1
            timeLabel.text = String(Int(slider.value))
            
        
        
        if slider.value == 0 {
            timer.invalidate()    //Timer ı sonlandır.
            timeLabel.text = "Game over"
            hideTimer.invalidate()   //timer ı sonlandır.
            
            for kenny in kennyArray {
                kenny.isHidden = true  //oyun bittiğinde tüm kennyler görünmez olacak.
            }
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "HighScore: \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                
                // Replay Function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)   //Oyun süresi timer ı
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)   //resimlerin görünürlük timer ı
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
            
        }
        
        
    }
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        timeLabel.text = Int(sender.value).description
        
        
    }
    
    
    
}
