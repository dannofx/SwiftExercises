//
//  MVVCAlarmExampleTests.swift
//  MVVCAlarmExampleTests
//
//  Created by Danno on 3/7/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import XCTest
@testable import MVVCAlarmExample

class AlarmViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization() {
        let alarm = Alarm()
        let alarmViewModel = AlarmViewModel(alarm: alarm)
        XCTAssertNotNil(alarmViewModel, "The alarm view model should not be nil.")
        XCTAssertTrue(alarmViewModel.alarm == alarm, "The alarm should be equal to the alarm property in the view model.")
    }
    
    func testTimeStrng() {
        let alarm = Alarm()
        let alarmViewModel = AlarmViewModel(alarm: alarm)
        let date = Date(timeIntervalSinceReferenceDate: 0)
        alarmViewModel.updateTime(date)
        XCTAssertEqual(alarmViewModel.stringTime, "31/12/2000 18:00", "The time was not represented correctly: \(alarmViewModel.stringTime)")
    }
    
    func testTimeUpdate() {
        let alarm = Alarm()
        let alarmViewModel = AlarmViewModel(alarm: alarm)
        let date = Date(timeIntervalSinceReferenceDate: 0)
        XCTAssert(!alarmViewModel.isTimeSet, "The time should not be set at this point.")
        XCTAssertEqual(alarmViewModel.stringTime, "(No time set)", "Incorrect string for a not set view model: \(alarmViewModel.stringTime)")
        alarmViewModel.updateTime(date)
        XCTAssert(alarmViewModel.isTimeSet, "The time should be set at this point.")
        XCTAssertNotEqual(alarmViewModel.stringTime, "(No time set)", "Incorrect string for a set view model: \(alarmViewModel.stringTime)")
    }
    
    func testSoundUpdate() {
        let alarm = Alarm()
        let alarmViewModel = AlarmViewModel(alarm: alarm)
        guard let soundName = alarmViewModel.possibleSounds.first else {
            XCTFail("No possible sounds available in the alarm view model")
            return
        }
        XCTAssert(!alarmViewModel.isSoundSet, "The sound should not be set at this point.")
        XCTAssertEqual(alarmViewModel.soundName, "(No sound set)", "Incorrect string for a not set view model: \(alarmViewModel.soundName)")
        alarmViewModel.updateSound(soundName)
        XCTAssert(alarmViewModel.isSoundSet, "The time should be set at this point.")
        XCTAssertNotEqual(alarmViewModel.soundName, "(No time set)", "Incorrect string for a set view model: \(alarmViewModel.soundName)")
    }
}
