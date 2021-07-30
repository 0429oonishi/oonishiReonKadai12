//
//  TaxUserDefaultsDataStore.swift
//  oonishiReonKadai12
//
//  Created by 大西玲音 on 2021/07/30.
//

import Foundation

protocol DataStoreProtocol: AnyObject {
    func save(num: Int)
    func get() -> Int
}

final class TaxUserDefaultsDataStore: DataStoreProtocol {
    
    private let saveKey = "saveKey"
    
    func save(num: Int) {
        UserDefaults.standard.set(num, forKey: saveKey)
    }
    
    func get() -> Int {
        return UserDefaults.standard.integer(forKey: saveKey)
    }
    
}
