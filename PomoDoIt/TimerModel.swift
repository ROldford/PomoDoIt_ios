//
//  TimerModel.swift
//  PomoDoIt
//
//  Created by Ryan Oldford on 2020-05-19.
//  Copyright © 2020 Ryan Oldford. All rights reserved.
//

import Foundation

class TimerModel: NSObject {
    // MARK: Properties
    private(set) var timerDuration: TimeInterval!
    private(set) var isTimerStarted: Bool!
    private(set) var isTimerPaused: Bool!
    private var timerElapsed: TimeInterval!
    private var timerStartTime: Date?
    
    init(duration: TimeInterval) {
        super.init()
        reset(duration: duration)
    }
    
    // MARK: Data Access
    
    func getTimerString() -> String {
        if (isTimerStarted) {
            let timeRemaining: TimeInterval
            if (isTimerPaused) {
                timeRemaining = timerDuration - timerElapsed
            } else {
                let timeSoFar: TimeInterval = timerElapsed + DateInterval(start: timerStartTime!, end: Date()).duration
                timeRemaining = timerDuration - timeSoFar
            }
            return formatTimerString(remaining: timeRemaining)
        } else {
            return formatTimerString(remaining: timerDuration)
        }
    }
    
    
    // MARK: Timer Controls
    
    func start() {
        isTimerStarted = true
        timerStartTime = Date()
    }
    
    func pause() {
        isTimerPaused = true
        timerElapsed += DateInterval(start: timerStartTime!, end: Date()).duration
    }
    
    func resume() {
        isTimerPaused = false
        timerStartTime = Date()
    }
    
    func reset(duration: TimeInterval) {
        timerDuration = duration
        timerElapsed = 0
        timerStartTime = nil
        isTimerStarted = false
        isTimerPaused = false
    }
    
    // MARK: Private Methods
    private func formatTimerString(remaining: TimeInterval) -> String {
        let minutes: Int = Int(remaining / 60)
        let seconds: Int = Int(remaining.truncatingRemainder(dividingBy: 60))
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        let minutesString = formatter.string(from: NSNumber(value: minutes))
        let secondsString = formatter.string(from: NSNumber(value: seconds))
        return "\(minutesString ?? "??"):\(secondsString ?? "??")"
    }
}
