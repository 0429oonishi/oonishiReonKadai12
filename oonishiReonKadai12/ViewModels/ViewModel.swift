//
//  ViewModel.swift
//  oonishiReonKadai12
//
//  Created by 大西玲音 on 2021/07/28.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelInput {
    func calculateButtonDidTapped(excludingTaxText: String?,
                                  consumptionTaxText: String?)
}

protocol ViewModelOutput: AnyObject {
    var includingTaxText: Driver<String> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

final class ViewModel: ViewModelInput, ViewModelOutput {
    
    func calculateButtonDidTapped(excludingTaxText: String?,
                                  consumptionTaxText: String?) {
        let excludingTaxNum = Int(excludingTaxText ?? "") ?? 0
        let consumptionTaxNum = Int(consumptionTaxText ?? "") ?? 0
        let includingTaxNum = excludingTaxNum * (100 + consumptionTaxNum) / 100
        includingTaxTextRelay.accept(String(includingTaxNum))
    }
    
    var includingTaxText: Driver<String> {
        includingTaxTextRelay.asDriver()
    }
    private let includingTaxTextRelay = BehaviorRelay<String>(value: "")
    
    
}

extension ViewModel: ViewModelType {
    
    var inputs: ViewModelInput {
        return self
    }
    
    var outputs: ViewModelOutput {
        return self
    }
    
}
