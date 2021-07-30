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
        
        setupBindings()
        
    }

    private func setupBindings() {
        calculateButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.inputs.calculateButtonDidTapped(
                    excludingTaxText: self?.excludingTaxTextField.text,
                    consumptionTaxText: self?.consumptionTaxTextField.text
                )
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.includingTaxText
            .drive(onNext: { [weak self] text in
                self?.includingTaxLabel.text = text
            })
            .disposed(by: disposeBag)

        
    }

}

