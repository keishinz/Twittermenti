import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/keishin/Documents/WorkSpace/Udemy/Twittermenti-iOS13/twitter-sanders-apple3.csv"))

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

//let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let evaluationAccuracy = (1 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "keishin", shortDescription: "Udemy tweetsentiment demo", license: nil, version: "1.0", additional: nil)

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/keishin/Documents/WorkSpace/Udemy/Twittermenti-iOS13/TweetSentimentClassifier.mlmodel"))

