//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import CoreML
import UIKit
import SwifteriOS
import SwiftyJSON

class ViewController: UIViewController {
    
    let swifter = Swifter(consumerKey: TWITTER_CONSUMER_KEY, consumerSecret: TWITTER_CONSUMER_SECRET)
    let sentimentClassifier = TweetSentimentClassifier()
    
    var predictionInput = [TweetSentimentClassifierInput]()
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let testPrediction = try! sentimentClassifier.prediction(text: "@Apple I don't need three cameras!")
//        print(testPrediction.label)
        
        swifter.searchTweet(using: "@POTUS", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            
            guard let numberOfResults = results.array?.count else { return }
            for i in 0 ..< numberOfResults {
                if let tweetText = results[i]["full_text"].string {
                    
                    print(tweetText)
                    let tweetForPrediction = TweetSentimentClassifierInput(text: tweetText)
                    self.predictionInput.append(tweetForPrediction)
                }
            }
            
            do {
                let predictionResult = try self.sentimentClassifier.predictions(inputs: self.predictionInput)
                
                for element in predictionResult {
                    print("PredictionResult result: \(element.label)")
                }
                
            } catch {
                print("Prediction error: \(error.localizedDescription)")
            }
                
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

