//
//  BasTest.swift
//  FunWithFlagsUITests
//
//  Created by Shubham Arora on 12/12/23.
//

//import Foundation

import XCTest


class Logger {
    func log(_ mlog: String) {
        NSLog(mlog)
    }

}

public class BaseTest {
    typealias Completion = (() -> Void)?
    let app = XCUIApplication()
    let log = Logger().log
    //let attach_screenshot = Logger().attach_screenshot
    required init(timeout: TimeInterval = 10, completion: Completion = nil){
        log("waiting \(timeout)s for \(String(describing: self)) existence")
        XCTAssert(rootElement.waitForExistence(timeout: timeout),
                  "Page \(String(describing: self)) waited , but not loaded")
        completion?()
    }
    
    var rootElement : XCUIElement {
        fatalError("subclass should override rootElement")
    }
    
    //Button
    func button(_ name:String) -> XCUIElement {
        return app.buttons[name]
    }
    
    //Navigation Bar
    func navBar(_ name:String) -> XCUIElement {
        return app.navigationBars[name]
    }
    //Text Field Bar
    func textField(_ name:String) -> XCUIElement {
        return app.textFields[name]
    }
    //Text Bar
    func text(_ name:String) -> XCUIElement {
        return app.staticTexts[name]
    }

}
