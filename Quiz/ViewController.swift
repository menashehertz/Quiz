//
//  ViewController.swift
//  Quiz
//
//  Created by Christopher Ching on 2016-10-18.
//  Copyright © 2016 CodeWithChris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerStackView: UIStackView!
    
    let model = QuizModel()
    var questions = [Question]()
    
    // the question that is being worked on
    var currentQuestion:Question?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Call get questions
        questions = model.getQuestions()
        
        if questions.count > 0 {
            currentQuestion = questions[0]
            displayCurrentQuestion()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayCurrentQuestion()  {
        
        guard (currentQuestion != nil) else { return }
        questionLabel.text = currentQuestion?.questionText
        
        // setup answer buttons
        
    }

}

