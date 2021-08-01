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
    init(repository: TaxRepositoryProtocol) {
        self.repository = repository
        setupBindings()
    }
    
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
    
    private func setupBindings() {
        // 消費税保存要求が来たらリポジトリで保存する
        // 保存中に新たな要求が来たら前の要求の結果は無視する
        saveConsumptionTaxTrigger
            .flatMapLatest(repository.save(consumptionTax:))
            .subscribe()
            .disposed(by: disposeBag)
        
        // 消費税読み込み要求が来たらリポジトリから読み込んで結果をストリームに流す
        // 読み込み中に要求が来たら前の要求の結果は無視する
        loadConsumptionTaxTrigger
            .flatMapLatest(repository.loadConsumptionTax)
            .bind(to: consumptionTaxRelay)
            .disposed(by: disposeBag)
    }
    
    func saveTax(consumptionTax: Int) {
        saveConsumptionTaxTrigger.accept(consumptionTax)
    }
    
    func loadConsumptionTax() {
        loadConsumptionTaxTrigger.accept(())
    }
    
    func calculateIncludingTax(excludingTax: Int, consumptionTax: Int) {
        // アプリのコアになる計算なので、UseCaseで処理する
        includingTaxRelay.accept(excludingTax * (100 + consumptionTax) / 100)
    }
    
}
