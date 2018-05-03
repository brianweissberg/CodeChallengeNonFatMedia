// CODE CHALLENGE: Modify the class such that the client code will not have to poll to find out the current percent complete and write an implementation that uses it. You do not have to implement anything within "DoingTheJob", but explain your approach and why you feel it is appropriate. Also explain any assumptions you make about the class.

// class DoingTheJob {
//
//    func startTheJob() -> Void
//
//    func cancel() -> Void
//
//    func percentComplete() -> Float
// }


// README:
// 1. TIMER: In order to complete this code challenge, I implemented a timer into the DoingTheJob class so that I could have a way to simulate a task being done over a period of time. The timer is customizable.
// 2. DELEGATE: Instead of having a method that will track percentage complete, I implemented a delegate that will broadcast the percentage complete information. All that is needed now is for a delegate to be assigned and the protocol implemented. Instead of implementing a protocol, I just created a print statement that shows the information containted in the delegate.
// 2A: NOTIFICATION: The delegate could easily be replaced with a notification depending on numbers of observers.
// 3: IMPLEMENTATION: I instantiated an instance of the class at the bottom and called the startTheJob function. The function will terminate if the job is completed or if the cancel method is called before completion.

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// This delegate tracks percentage complete of an instance of the DoingTheJob class
protocol DoingTheJobDelegate {
    func percentageCompleteValueDidChange(newValue: Int)
}

class DoingTheJob {
    
    //
    // MARK: - Properties
    //
    
    var timer: Timer?
    var delegate: DoingTheJobDelegate? // Conform to this delegate to get the percentage complete information
    var percentageComplete = 0 {
        didSet {
            delegate?.percentageCompleteValueDidChange(newValue: percentageComplete)
            print("Doing The Job Delegate: \(percentageComplete)")
        }
    } // This variable tracks the percentage complete of a job
    var timeInterval: Double = 1 // This variable controls the number of seconds for each timer iteration
    var percentageCompletePerTimerIteration = 1 // This variable controls the amount completed per timer iteration
    var percentageCompleteAmount = 100 // This variable is the percentage complete amount needed to finish a job. It's default should be set to 100.
    
    //
    // MARK: - Methods
    //
    
    /// This function starts a timer which runs until the percentage variable of the DoingTheJob class reaches 100
    func startTheJob() -> Void {
        
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true ) { _ in
            if self.percentageComplete < self.percentageCompleteAmount {
                self.percentageComplete += self.percentageCompletePerTimerIteration
            } else {
                self.timer?.invalidate()
            }
        }
    }
    
    
    // This function cancels the timer of the DoingTheJob class
    func cancel() -> Void {
        
        guard let timer = timer else { return }
        
        timer.invalidate()
    }
}

// I have instantiated an instance of doing the job class here
let jobOne = DoingTheJob()
jobOne.timeInterval = 1
jobOne.percentageCompletePerTimerIteration = 5
jobOne.startTheJob()




