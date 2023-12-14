//
//  HomePage.swift
//  FunWithFlagsUITests
//
//  Created by Shubham Arora on 12/12/23.
//

import XCTest


public class HomePage : BaseTest {
  //Home Page Elements
    override var rootElement: XCUIElement{
        return app.staticTexts["🇬🇾🇭🇹🇭🇳 Fun with Flags 🇭🇰🇭🇺🇮🇸"]
    }
    lazy var navBar = app.staticTexts["🇬🇾🇭🇹🇭🇳 Fun with Flags 🇭🇰🇭🇺🇮🇸"]

    
    //--------------------------------------------------------------------------------------
    // Description : Searches for the inputCountry from the Search Field
    // Input : inputCountry as a String
    //--------------------------------------------------------------------------------------
    @discardableResult
    func searchCountry(inputCountry: String , completion: Completion = nil) -> Bool {

        //Verify Search Fields exists , taps and inputs the country if true
        let searchField = app.textFields["home_search_text_field"]
        XCTAssert(searchField.exists)
        searchField.tap()
        searchField.typeText(inputCountry)
        app.toolbars["Toolbar"].buttons["Done"].tap()
        sleep(5)
        log("--------------------------")
        log("Verifying Country Found")
        log("--------------------------")
        guard app.tables["Not Found"].staticTexts["Not Found"].exists else{
        let searchedCountry = app.tables.staticTexts[inputCountry]
        XCTAssert(searchedCountry.exists)
        log("--------------------------")
        log(" Country Found")
        log("--------------------------")
        sleep(2)
        //Verify the details of the searched country
        searchedCountry.tap()
            return true
        }
        return false

    }
    //--------------------------------------------------------------------------------------
    // Description : Verifies the values on the Country Detail Page
    // Input : inputCountry as a String
    //--------------------------------------------------------------------------------------
    @discardableResult
    func verify_countryDetails(inputCountry: String) ->Self{
        //Reading data from Utils->CountryDetails.json
        let datasource = Utils.loadData(filename: "CountryDetails")
        for iteration in datasource {
            guard let countryData = iteration as? [String: Any] else { return self}
            //let country = user["valid_country"] as! String
            let region = countryData["region"] as! String
            let subregion = countryData["subregion"] as! String
            let capital = countryData["capital"] as! String
            let demonym = countryData["demonym"] as! String
        
        
            //let elementsQuery = app.scrollViews.otherElements
            //let result = app.staticTexts[region]
            XCTAssert(app.staticTexts[region].exists)
            XCTAssert(app.staticTexts[subregion].exists)
            XCTAssert(app.staticTexts[capital].exists)
            XCTAssert(app.staticTexts[demonym].exists)
            
        }

        return self
    }
    //--------------------------------------------------------------------------------------
    // Description : Verifies the app has been loaded
    //--------------------------------------------------------------------------------------
    @discardableResult
    func appload(completion: Completion = nil) -> Self {
        log("--------------------------")
        let state = UIApplication.shared.applicationState
        log("--------------------------")
        if state == .background || state == .inactive {
            log("App in background")
        } else if state == .active {
            log("App in Active")
        }

        switch UIApplication.shared.applicationState {
            case .background, .inactive:
                log("--------------------------")

            case .active:
                // foreground
                log("--------------------------")

            default:
                break
        }
        return self
    }

    

}

