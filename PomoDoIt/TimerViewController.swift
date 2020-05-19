//
//  TimerViewController.swift
//  PomoDoIt
//
//  Created by Ryan Oldford on 2020-05-18.
//  Copyright © 2020 Ryan Oldford. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    // MARK: Enumerations
    enum Phase: String {
        case work = "Work"
        case shortBreak = "Short Break"
        case longBreak = "Long Break"
    }
    enum TimerButtonState: String {
        case start = "Start"
        case pause = "Pause"
        case resume = "Resume"
    }
    enum QuestionCase: String {
        case past = "What did you just work on?"
        case present = "What are you working on now?"
    }
    
    // MARK: Outlets
    @IBOutlet weak var phaseLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var btnTimer: UIButton!
    @IBOutlet weak var btnDoneList: UIButton!
    
    // MARK: Properties
    var phase: Phase = Phase.work
    var timerBtnState: TimerButtonState = TimerButtonState.start
    var questionCase: QuestionCase = QuestionCase.present
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        phaseLabel.text = phase.rawValue
        questionLabel.text = questionCase.rawValue
        btnTimer.setTitle(timerBtnState.rawValue, for: .normal)
        
    }
    
    @IBAction func timerButtonPress(_ sender: UIButton) {
        switch timerBtnState {
        case .start:
            timerBtnState = .pause
        case .pause:
            timerBtnState = .resume
        case .resume:
            timerBtnState = .pause
//        default:
//            fatalError("Unexpected button state: \(timerBtnState)")
        }
        btnTimer.setTitle(timerBtnState.rawValue, for: .normal)
    }
    
}

