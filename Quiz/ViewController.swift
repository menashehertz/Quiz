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
    
    // the results screen
    @IBOutlet weak var dimView: UIView!
    
    @IBOutlet weak var resultsView: UIView!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    @IBOutlet weak var resultViewTop: NSLayoutConstraint!
    @IBOutlet weak var resultViewBottom: NSLayoutConstraint!

    let model = QuizModel()
    var questions = [Question]()
    
    // the question that is being worked on
    var currentQuestion:Question?
    var questionNbr = 0
    var correctCount = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dimView.alpha = 0
        
        // Call get questions
        questions = model.getQuestions()
        
        // restore the quiz to where it was left of
        restoreState()
        
        if questions.count > 0 {
            currentQuestion = questions[questionNbr]
            displayCurrentQuestion()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCurrentQuestion()  {
        
        // check it isn't nil before we begin
        guard let currentQuestion = currentQuestion else { return }
        
        // save the current state
        saveState()
        
        
        // Remove the answers from the stackView
        for x in answerStackView.arrangedSubviews {
            x.removeFromSuperview()
        }
        
        questionLabel.alpha = 0
        questionLabel.text = currentQuestion.questionText
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: { 
            self.questionLabel.alpha = 1
        }, completion: nil)
        
        
        
        for index in 0...(currentQuestion.answers.count) - 1 {
        
//        for answer in answers! {
            let answer = currentQuestion.answers[index]
            
            
            // create the answer screen object
            let answerScreenObject = AnswerButton()
            answerScreenObject.tag = index
            
            // configure the Object
            answerScreenObject.setAnswerText(answerText: answer)
            answerScreenObject.setNumberText(answerNumber: index)
            
            // add layout constraints
            let heightConstraint = NSLayoutConstraint(item: answerScreenObject, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)

            answerScreenObject.addConstraints([heightConstraint])

            
            // add tapgesture recognizer
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(answerWasTapped(sender:)))
            answerScreenObject.addGestureRecognizer(tapGestureRecognizer)
            
            answerScreenObject.alpha = 0
            // add it to stack subview
            let delay = Double(index) * 0.2
            answerStackView.addArrangedSubview(answerScreenObject)
            UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: {
                answerScreenObject.alpha = 1
            }, completion: nil)
        }
        
        
        
        
        // add size constraints to the answer screen object
        
        //
    }
    
    func answerWasTapped(sender: UITapGestureRecognizer) -> Void {
        
        let answerButton = sender.view as! AnswerButton
 
        if answerButton.tag == (currentQuestion?.correctAnswerIndex)! {
            // set the labels and buttons
            resultLabel.text = "Correct"
            correctCount += 1
            
            // set the results view
            resultsView.backgroundColor = UIColor(red: 72/255, green: 161/255, blue: 49/255, alpha: 0.75)
            resultButton.backgroundColor = UIColor(red: 7/255, green: 56/255, blue: 16/255, alpha: 0.75)
            
        } else {
            resultLabel.text = "Incorrect"
            // set the results view
            resultsView.backgroundColor = UIColor(red: 161/255, green: 78/255, blue: 87/255, alpha: 0.75)
            resultButton.backgroundColor = UIColor(red: 121/255, green: 48/255, blue: 46/255, alpha: 0.75)

        }
        feedbackLabel.text = currentQuestion?.feedback
        resultButton.setTitle("Next", for: .normal)
        
        dimView.alpha = 0
        resultViewTop.constant = 1000
        resultViewBottom.constant = -1000
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.dimView.alpha = 1
            self.resultViewBottom.constant = 30
            self.resultViewTop.constant = 30
            self.view.layoutIfNeeded()
        }, completion: nil)

        
    }

   
    @IBAction func resultButton(_ sender: Any) {
        
        // TODO: if the button is in restart mode put in the restart code
        
        guard let buttonTitle = resultButton.title(for: .normal) else {fatalError()}
        
        if buttonTitle == "Restart" {
            restartGame()
            return
        }
        
        // Gets the question number of what is on the screen now
        guard let tempQuestionNbr = questions.index(of: currentQuestion!) else { return }
        
        // if it is at the end of the Quiz
        if tempQuestionNbr >= questions.count - 1{
            print("end of game")
                        /*   Show Final Screen    */
            
            // setup the text and the buttons
            resultButton.setTitle("Restart", for: .normal)
            resultLabel.text = "Your Score"
            feedbackLabel.text = "Your score is \(correctCount)"
            resultsView.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 0.75)
            resultButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.75)
            

        } else {
            
            /* Still in middle of the quiz */
            
            // Get next question
            currentQuestion = questions[tempQuestionNbr + 1]
            displayCurrentQuestion()
            
            // show the screen
            dimView.alpha = 0
            
        }
    }
    
    func restartGame() -> Void {
        
        // delete the state
        deleteState()
        
        // set correct count to zero
        correctCount = 0
        
        // take off the dimmer
        dimView.alpha = 0
        
        // cleanOff answers like always done
        for view in answerStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        // get the first question
        currentQuestion = questions[0]
        displayCurrentQuestion()
        
    }
    
    // - MARK: Save and restore computer state functions
    
    func saveState() -> Void {
        // Gets the question number of what is on the screen now
        guard let currentQuestion = currentQuestion, let tempQuestionNbr = questions.index(of: currentQuestion) else { return }
        
        // saves it
        UserDefaults.standard.set(tempQuestionNbr, forKey: "questionNbr")
    }
    
    func restoreState() -> Void {
        guard let savedquestionNbr = UserDefaults.standard.object(forKey: "questionNbr") as? Int else {return}
        questionNbr = savedquestionNbr
    }
    
    func deleteState() -> Void {
        UserDefaults.standard.removeObject(forKey: "questionNbr")
    }
    
}

