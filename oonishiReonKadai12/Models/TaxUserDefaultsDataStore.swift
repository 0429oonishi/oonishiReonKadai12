//
//  TaxUserDefaultsDataStore.swift
//  oonishiReonKadai12
//
//  Created by 大西玲音 on 2021/07/30.
//

import Foundation

// Taxを扱うプロトコルであることを明記する
protocol TaxDataStoreProtocol: AnyObject {
    // 何を保存するのかを明記
    func save(consumptionTax: Int)
    // 何を読み込むのかを明記
    func loadConsumptionTax() -> Int
}

final class TaxUserDefaultsDataStore: TaxDataStoreProtocol {
    
    private let saveKey = "saveKey"
    
    func save(consumptionTax: Int) {
        UserDefaults.standard.set(consumptionTax, forKey: saveKey)
    }
    
    func loadConsumptionTax() -> Int {
        return UserDefaults.standard.integer(forKey: saveKey)
    }
    
}
