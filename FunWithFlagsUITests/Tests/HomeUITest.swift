//
//  HomeUITest.swift
//  FunWithFlagsUITests
//
//  Created by Salena Gagneja on 12/12/23.
//

//import Foundation
import XCTest

class HomeUITest : XCTestCase {
    
    override func setUp(){
        super.setUp()
        continueAfterFailure = false
        UIView.setAnimationsEnabled(false)
        XCUIApplication().launch()
    }
    
    override func tearDown(){
        //
    }
    //-------------------------------------------------------------------------------------
    // Description : Search a Valid Country
    // Input Data : Utils -> TestData.json
    //-------------------------------------------------------------------------------------
    func testsearch_validCountry() {
        //Reading Country name from Util-> TestData.json
        //addscreenshot(name: "T : Country Not Found" + country + "Details")
        let datasource = Utils.loadData(filename: "TestData")
        for iteration in datasource {
            guard let user = iteration as? [String: Any] else { return }
            let country = user["valid_country"] as! String
            let country_searchResult = HomePage().searchCountry(inputCountry: country)
            guard country_searchResult == false
            else{
                addscreenshot(name: "VERIFIED : Country Found" + country + "Details")
                HomePage().verify_countryDetails(inputCountry: country)
                addscreenshot(name: "VERIFIED : Country Details Found" + country + "Details")
                continue
            }
            
            addscreenshot(name: "ERROR : Country Not Found" + country + "Details")
        }
    
    }
    //-------------------------------------------------------------------------------------
    // Description : Search a Valid Country
    // Input Data : Utils -> TestData.json
    //-------------------------------------------------------------------------------------
    func testsearch_invalidCountry() {
        //Reading Country name from Util-> TestData.json
        let datasource = Utils.loadData(filename: "TestData")
        for iteration in datasource {
            guard let user = iteration as? [String: Any] else { return }
            let country = user["invalid_country"] as! String
        //let country_searchResult =
            let country_search = HomePage().searchCountry(inputCountry: country)
            guard country_search == false
            else{
                XCTFail("Country found, when not supposed to be found")
                addscreenshot(name: "Foundcountry:"+country)
                continue
            }
            
            addscreenshot(name: "Verified Country: " + country + "does not exist")
            //addscreenshot(name: country + "Verified is not present")
        }

        
    
    }
    //-------------------------------------------------------------------------------------
    // Description : Search a Valid Country
    // Input Data : Utils -> TestData.json
    //-------------------------------------------------------------------------------------
    

    func addscreenshot(name: String){
        let now = NSDate()
        print(now)
             // I save this dateToday as Key in Firebase
        //dateToday = nowTimeStamp
        let fullScreenshot = XCUIScreen.main.screenshot()
        //let screenshots = XCTAttachment(screenshot:fullScreenshot)
        let screenshot = XCTAttachment(uniformTypeIdentifier: "public.png", name: "Screenshot-\(name).png", payload: fullScreenshot.pngRepresentation, userInfo: nil)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }


    
}
