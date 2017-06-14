//
//  AnswerButton.swift
//  Quiz
//
//  Created by Steven Hertz on 6/6/17.
//  Copyright © 2017 CodeWithChris. All rights reserved.
//

import UIKit

class AnswerButton: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var numberStackView = UIStackView()
    var answerStackview = UIStackView()
    
    var numberLabel = UILabel()
    var answerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        
        // configure number label
        numberLabel.textAlignment = .center
        numberLabel.textColor = UIColor.white
        numberLabel.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.50)
        let heightConstraintNumber = NSLayoutConstraint(item: numberLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        numberLabel.addConstraint(heightConstraintNumber)

        // setNumberText()
        
        // configure  the number stackview
        numberStackView.addArrangedSubview(numberLabel)
        numberStackView.alignment = .center
        let widthConstraint = NSLayoutConstraint(item: numberStackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        numberStackView.addConstraint(widthConstraint)
        addArrangedSubview(numberStackView)
        
        // configure the answerLabel
        answerLabel.textAlignment = .center
        answerLabel.numberOfLines = 0
        answerLabel.textColor = UIColor.white
        answerLabel.backgroundColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 0.50)
        let heightConstraint = NSLayoutConstraint(item: answerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        answerLabel.addConstraint(heightConstraint)

        
        
        // setup the answer stackview by loading the answer label into it
        answerStackview.addArrangedSubview(answerLabel)
        answerStackview.alignment = .center
        addArrangedSubview(answerStackview)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnswerText(answerText: String)  {
        answerLabel.text = answerText
    }
    
    func setNumberText(answerNumber: Int) -> Void {
        numberLabel.text = String(answerNumber)
    }

}
