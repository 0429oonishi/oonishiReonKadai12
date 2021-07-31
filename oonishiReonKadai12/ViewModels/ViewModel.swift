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
    func viewDidLoad()
    func calculateButtonDidTapped(excludingTaxText: String?,
                                  consumptionTaxText: String?)
}

protocol ViewModelOutput: AnyObject {
    var includingTaxText: Driver<String> { get }
    var consumptionTaxText: Driver<String> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

final class ViewModel: ViewModelInput, ViewModelOutput {
    
    private let taxUseCase = TaxUseCase(
        repository: TaxRepository(
            dataStore: TaxUserDefaultsDataStore()
        )
    )
    
    func viewDidLoad() {
        setupBindings()

        taxUseCase.loadConsumptionTax()
    }

    private func setupBindings() {
        taxUseCase.consumptionTax.compactMap { $0 }
            .map { String($0) }
            .bind(to: consumptionTaxTextRelay)
            .disposed(by: disposeBag)

        taxUseCase.includingTax.compactMap { $0 }
            .map { String($0) }
            .bind(to: includingTaxTextRelay)
            .disposed(by: disposeBag)
    }
    
    func calculateButtonDidTapped(excludingTaxText: String?,
                                  consumptionTaxText: String?) {
        let excludingTax = Int(excludingTaxText ?? "") ?? 0
        let consumptionTax = Int(consumptionTaxText ?? "") ?? 0

        taxUseCase.saveTax(consumptionTax: consumptionTax)
        taxUseCase.calculateIncludingTax(excludingTax: excludingTax, consumptionTax: consumptionTax)
    }
    
    var includingTaxText: Driver<String> {
        includingTaxTextRelay.asDriver()
    }
    private let includingTaxTextRelay = BehaviorRelay<String>(value: "")
    
    var consumptionTaxText: Driver<String> {
        consumptionTaxTextRelay.asDriver()
    }
    private let consumptionTaxTextRelay = BehaviorRelay(value: "")
    
    private let disposeBag = DisposeBag()
}

extension ViewModel: ViewModelType {
    
    var inputs: ViewModelInput {
        return self
    }
    
    var outputs: ViewModelOutput {
        return self
    }
    
}
