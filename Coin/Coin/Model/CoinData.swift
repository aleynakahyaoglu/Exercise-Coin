//
//  Data.swift
//  Coin
//
//  Created by mac on 2.03.2022.
//

import Foundation

struct CoinData: Decodable {
    let base: String
    let result: ResultModel
    let amount : Double
    let ms: Int
  
}

struct ResultModel: Codable {
    let GBP : Double?
    let AUD: Double?
    let TRY : Double?
    let CAD: Double?
    let EUR : Double?
    let USD : Double?
    let NZD: Double?
    let JPY:Double?
    
    let rate: Double
    
}
