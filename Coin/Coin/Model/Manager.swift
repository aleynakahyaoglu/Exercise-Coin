//
//  Manager.swift
//  Coin
//
//  Created by mac on 2.03.2022.
//

import Foundation


// PROTOKOL OLUŞTURMA

protocol ManagerDelegate{
    func didUpdateCoin(_ manager: Manager, currency: CoinModel)
    func didFailWithError(error: Error)
}
 // API EKLEME

struct Manager {
    
    var delegate: ManagerDelegate?
    
    let Url = "https://api.fastforex.io"
    let apiKey = "6507a3d7a5-04542f5cfa-r843hz"
    let key = "fetch-multi?from=USD&to=EUR,GBP,CHF"
  
    
    
    let source = ["GBP","AUD","USD","EUR","CAD","NZD","JPY"]
    

// URL
 
func getCoin(fromcurrency: String, tocurrency: String) {

    let urlString = "\(Url)/convert?from=\(fromcurrency)&to=\(tocurrency)&amount=1.00&api_key=\(apiKey)"
    print(urlString)
    
    if let url = URL(string: urlString) {
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data {
                if let ccoin = self.parseJSON(data:safeData) {
                    self.delegate?.didUpdateCoin(self, currency: ccoin)
                }
            }
        }
        task.resume()
    }
}
    
//JSON

func parseJSON(data: Data)-> CoinModel? {
    let decoder = JSONDecoder()
    do {
        var birim = 0.0
        let decodedData = try decoder.decode(CoinData.self, from: data)
        
        if (decodedData.result.GBP != nil){
            birim = decodedData.result.GBP!
        }
        else if (decodedData.result.AUD != nil){
            birim = decodedData.result.AUD!
        }
        else if (decodedData.result.CAD != nil){
            birim = decodedData.result.CAD!
            
        }else if (decodedData.result.EUR != nil){
            birim = decodedData.result.EUR!
            
        }else if (decodedData.result.JPY != nil){
            birim = decodedData.result.JPY!
            
        }else if (decodedData.result.NZD != nil){
            birim = decodedData.result.NZD!
            
        }else if (decodedData.result.USD != nil){
            birim = decodedData.result.USD!
            
        }else if (decodedData.result.TRY != nil){
            birim = decodedData.result.TRY!
            
        }
      
        let currency = CoinModel(amount:birim)
        return currency
    }catch {
        delegate?.didFailWithError(error: error)
        return nil
    }
}
    
}



