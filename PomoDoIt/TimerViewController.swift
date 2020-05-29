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
        case future = "What are you going to work on?"
    }
    
    // MARK: Outlets
    @IBOutlet weak var phaseLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var btnTimer: UIButton!
    @IBOutlet weak var btnDoneList: UIButton!
    
    // MARK: Properties
    var phase: Phase = .work
    var timerBtnState: TimerButtonState = .start
    var questionCase: QuestionCase = .future
    var timerModel: TimerModel = TimerModel(duration: 25*60)
    var timer:Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // May need to set these to something else (ex. loading app while timer is running)
//        phase = .work
//        timerBtnState = .start
//        questionCase = .future
//        timerModel = TimerModel(duration: 25*60)
        
        phaseLabel.text = phase.rawValue
        questionLabel.text = questionCase.rawValue
        btnTimer.setTitle(timerBtnState.rawValue, for: .normal)
        updateTimerDisplay()
    }
    
    @IBAction func timerButtonPress(_ sender: UIButton) {
        switch timerBtnState {
        case .start:
            print("start button press")
            timerBtnState = .pause
            timerStart()
            timerModel.start()
        case .pause:
            print("pause button press")
            timerBtnState = .resume
            updateTimerDisplay()
            timerModel.pause()
            timerStop()
        case .resume:
            print("resume button press")
            timerBtnState = .pause
            updateTimerDisplay()
            timerModel.resume()
            timerStart()
//        case .none:
//            fatalError("Unexpected button state: \(String(describing: timerBtnState))")
        }
        btnTimer.setTitle(timerBtnState.rawValue, for: .normal)
    }
    
    // MARK: Private Methods
    func timerStart() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        timer?.tolerance = 0.1
    }
    
    func timerStop() {
        timer?.invalidate()
    }
    
    func updateTimerDisplay() {
        timerLabel.text = timerModel.getTimerString()
    }
    
    @objc func timerTick() {
        updateTimerDisplay()
    }
}

