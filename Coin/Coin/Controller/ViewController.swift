//
//  ViewController.swift
//  Coin
//
//  Created by mac on 1.03.2022.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ManagerDelegate {

    
    
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var miktarLabel: UILabel!
    @IBOutlet weak var paraBirimi: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    
    var manager = Manager()
    var from = ""
    var to = ""
    

  
    let source = ["GBP","AUD","USD","EUR","CAD","NZD","JPY","TRY"]
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         
         // PickerView //
         
         picker.delegate = self
         picker.dataSource = self
         
         manager.delegate = self
     }
     
     func numberOfComponents(in picker: UIPickerView) -> Int {
         return 2
     }
     
     func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return source.count
     }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return source[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            from = source[row]
        }else {
            to = source[row]
        }
        
       
        
        manager.getCoin(fromcurrency: from, tocurrency: to)
    }
    func didUpdateCoin(_ manager: Manager, currency: CoinModel) {
        DispatchQueue.main.async {
            self.miktarLabel.text = "\(currency.amount)"
            print(currency.amount)
            
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    
    
 }




