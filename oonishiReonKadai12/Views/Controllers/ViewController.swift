//
//  ViewController.swift
//  oonishiReonKadai12
//
//  Created by 大西玲音 on 2021/07/20.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    @IBOutlet private weak var excludingTaxTextField: UITextField!
    @IBOutlet private weak var consumptionTaxTextField: UITextField!
    @IBOutlet private weak var calculateButton: UIButton!
    @IBOutlet private weak var includingTaxLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private let viewModel: ViewModelType = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setupBindings()を先に読む
        setupBindings()
        viewModel.inputs.viewDidLoad()
        
    }

    private func setupBindings() {
        // selfが不要な形
        calculateButton.rx.tap
            .withLatestFrom(excludingTaxTextField.rx.text)
            .withLatestFrom(consumptionTaxTextField.rx.text, resultSelector: { ($0, $1) })
            .subscribe(onNext: viewModel.inputs.calculateButtonDidTapped)
            .disposed(by: disposeBag)
        
        // viewModelからの出力をそのままバインド
        viewModel.outputs.includingTaxText
            .drive(includingTaxLabel.rx.text)
            .disposed(by: disposeBag)
        
        // viewModelからの出力をそのままバインド
        viewModel.outputs.consumptionTaxText
            .drive(consumptionTaxTextField.rx.text)
            .disposed(by: disposeBag)
    }

}

