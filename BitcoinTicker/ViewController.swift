//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , UIPickerViewDelegate ,UIPickerViewDataSource{
    
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currencyArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        

        let url = baseURL + currencyArray[row]
        getCurrancyData(URL: url)
        
    }
    

    
    
    
    
    
    
    
    
    
    
    //MARK: - Networking
    /***************************************************************/

      func getCurrancyData(URL: String)
      {
        Alamofire.request(URL)
            .responseJSON { response in
                if response.result.isSuccess {
                    print("Sucess")
                    
                    let json = JSON(response.result.value!)
                    self.updateCurrancyData(Json : json)

                } else {
                 print("error")
                }
            }
    }


//    //MARK: - JSON Parsing
//    /***************************************************************/
//
    func updateCurrancyData(Json : JSON ) {

        if let result = Json["ask"].double
        {
            bitcoinPriceLabel.text = String(result)
        }
        
        
    }





}

