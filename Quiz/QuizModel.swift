//
//  QuizModel.swift
//  Quiz
//

import UIKit

class QuizModel: NSObject {

//    func getQuestions() -> [Question] {
//        
//        var questions = [Question]()
//        
//        // Get array of dictionaries from JSON file
//        let array = getLocalJsonFile()
//        
//        // Parse dictionaries into Question objects
//        for dict in array {
//            
//            // Create question object
//            let q = Question()
//            
//            // Assign question properties
//            q.questionText = dict["question"] as! String
//            q.answers = dict["answers"] as! [String]
//            q.correctAnswerIndex = dict["correctIndex"] as! Int
//            q.module = dict["module"] as! Int
//            q.lesson = dict["lesson"] as! Int
//            q.feedback = dict["feedback"] as! String
//            
//            // Add the question object into the array
//            questions += [q]
//        }
//        
//        // Return the list of question objects
//        return questions
//    }
    
    func getQuestions() -> [Question] {
        
        // get the json data in the format of [String: Any]
        let allJsonQuestion = getLocalJsonFile()
        
        
        /* Now we are ready to do the processing */
        
        //  create the array that will be returned
        var questionArray = [Question]()
        
        // loop through the array and create the array of question objects
        for  jsonQuestion in allJsonQuestion {
            
            // instantiate the question object
            let myQ = Question()
            
            // update the question object form the dictionary
            
            myQ.questionText = jsonQuestion["question"] as! String
            
            myQ.answers = jsonQuestion["answers"] as! [String]
            myQ.correctAnswerIndex = jsonQuestion["correctIndex"] as! Int
            myQ.module = jsonQuestion["module"] as! Int
            myQ.lesson = jsonQuestion["lesson"] as! Int
            myQ.feedback = jsonQuestion["feedback"] as! String
            
            
            // append the question object to the question object array
            questionArray.append(myQ)
        }
        
        return questionArray
        
    }
    
    func getLocalJsonFilex() -> [[String:Any]] {
        
        do {
        
            // Get path to json file in bundle
            let bundlePath = Bundle.main.path(forResource: "QuestionData", ofType: "json")
            
            if let actualBundlePath = bundlePath {
                
                // Create url object
                let url = URL(fileURLWithPath: actualBundlePath)
                
                // Create data object
                let data = try Data(contentsOf: url)
                
                // Use JsonSerialization to turn data into array of dictionaries
                let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String:Any]]

                return array
                
            }
        }
        catch {
            // Something wrong happened
        }
        return [[String:Any]]()
    }
    
    func getLocalJsonFile() -> [[String:Any]] {
        
        // get the url
        guard let fileURL = Bundle.main.url(forResource: "QuestionData", withExtension: "json") else {fatalError("could not get jsonData")}
        
        do {
            // instantiate a Data object from Json file
            let data = try Data(contentsOf: fileURL)
            
            // convert the json data into a swift dictionary
            let jsonSwiftQuestionArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String:Any]]
            
            return jsonSwiftQuestionArray
        } catch {
            print("there was an error converting the json to swift dictionary")
        }
       return  [[String:Any]]()
    }
    
}
