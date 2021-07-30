//
//  TaxUseCase.swift
//  oonishiReonKadai12
//
//  Created by 大西玲音 on 2021/07/30.
//

import Foundation

final class TaxUseCase {
    
    private let repository: TaxRepositoryProtocol
    init(repository: TaxRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveTax(num: Int) {
        repository.save(num: num)
    }
    
    func getTaxNum() -> Int {
        return repository.get()
    }
    
}
