//
//  TaxRepository.swift
//  oonishiReonKadai12
//
//  Created by 大西玲音 on 2021/07/30.
//

import RxSwift

// 何を保存するのかを明記する
// 非同期も扱えるように
protocol TaxRepositoryProtocol: AnyObject {
    func save(consumptionTax: Int) -> Completable
    func loadConsumptionTax() -> Single<Int>
}

final class TaxRepository: TaxRepositoryProtocol {
    
    private let dataStore: TaxDataStoreProtocol
    
    init(dataStore: TaxDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func save(consumptionTax: Int) -> Completable {
        dataStore.save(consumptionTax: consumptionTax)
        return Completable.empty()
    }
    
    func loadConsumptionTax() -> Single<Int> {
        return .just(dataStore.loadConsumptionTax())
    }
    
}
