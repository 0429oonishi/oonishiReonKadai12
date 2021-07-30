//
//  TaxRepository.swift
//  oonishiReonKadai12
//
//  Created by 大西玲音 on 2021/07/30.
//

import Foundation

protocol TaxRepositoryProtocol: AnyObject {
    func save(num: Int)
    func get() -> Int
}

final class TaxRepository: TaxRepositoryProtocol {
    
    private let dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func save(num: Int) {
        dataStore.save(num: num)
    }
    
    func get() -> Int {
        return dataStore.get()
    }
    
}
