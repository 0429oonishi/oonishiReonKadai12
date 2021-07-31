//
//  TaxUseCase.swift
//  oonishiReonKadai12
//
//  Created by 大西玲音 on 2021/07/30.
//

import RxSwift
import RxRelay

final class TaxUseCase {
    
    private let repository: TaxRepositoryProtocol

    private let loadConsumptionTaxTrigger = PublishRelay<Void>()
    private let saveConsumptionTaxTrigger = PublishRelay<Int>()

    var consumptionTax: Observable<Int?> {
        consumptionTaxRelay.asObservable()
    }
    private let consumptionTaxRelay = BehaviorRelay<Int?>(value: nil)

    var includingTax: Observable<Int?> {
        includingTaxRelay.asObservable()
    }
    private let includingTaxRelay = BehaviorRelay<Int?>(value: nil)

    private let disposeBag = DisposeBag()

    init(repository: TaxRepositoryProtocol) {
        self.repository = repository

        setupBindings()
    }

    private func setupBindings() {
        loadConsumptionTaxTrigger
            .flatMapLatest(repository.loadConsumptionTax)
            .bind(to: consumptionTaxRelay)
            .disposed(by: disposeBag)

        saveConsumptionTaxTrigger
            .flatMapLatest(repository.save(consumptionTax:))
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func saveTax(consumptionTax: Int) {
        saveConsumptionTaxTrigger.accept(consumptionTax)
    }
    
    func loadConsumptionTax() {
        loadConsumptionTaxTrigger.accept(())
    }

    func calculateIncludingTax(excludingTax: Int, consumptionTax: Int) {
        includingTaxRelay.accept(excludingTax * (100 + consumptionTax) / 100)
    }
}
