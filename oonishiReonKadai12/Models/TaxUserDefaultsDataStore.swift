//
//  TaxUserDefaultsDataStore.swift
//  oonishiReonKadai12
//
//  Created by 大西玲音 on 2021/07/30.
//

import Foundation

protocol TaxDataStoreProtocol: AnyObject {
    func save(consumptionTax: Int)
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
