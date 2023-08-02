//
//  CalculatorViewController.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    private let topView = UIView()
    private let currencyButton = CalculatorCurrencyButton()
    private let previewLabel = UILabel()
    
    private let chooseButton = CalculatorTypeButton(width: 96)
    private let calculatorContainer = UIView()
    private let mainStackView = UIStackView()
    
    private var currentValue = "" {
        didSet {
            previewLabel.text = currentValue.isEmpty ? "0" : currentValue
        }
    }
    
    var currencyCode: CurrencyCode = "SGD" {
        didSet {
            currencyButton.currency = currencyCode
        }
    }
    
    // initial value
    var value: Double = 0 {
        didSet {
            currentValue = value.toStringTwoDigits()
        }
    }
    
    var type: TransactionType? {
        didSet {
            if let type = type {
                chooseButton.type = type
                previewLabel.textColor = type.color
            }
        }
    }
    
    var didTapDoneHandler: ((Double) -> Void)?
    var didChangeCurrencyCode: ((CurrencyCode) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
}

// MARK: - View Config
extension CalculatorViewController {
    private func configureViews() {
        view.backgroundColor = .clear
        
        currencyButton.currency = "SGD"
        currencyButton.tapHandler = { [weak self] in
            self?.presentCurrencyList()
        }
        topView.addSubview(currencyButton)
        previewLabel.font = .h1
        previewLabel.textAlignment = .right
        topView.addSubview(previewLabel)
        topView.backgroundColor = .white
        view.addSubview(topView)
        
        mainStackView.distribution = .equalSpacing
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        calculatorContainer.addSubview(mainStackView)
        calculatorContainer.backgroundColor = .systemGroupedBackground
        view.addSubview(calculatorContainer)
        
        configureButtons()
        
        chooseButton.tapHandler = { [weak self] in
            self?.didRequestTodo(.chooseType)
        }
    }
    
    private func configureConstraints() {
        currencyButton.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.Spacing.medium)
        }
        previewLabel.snp.remakeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(Constants.Spacing.medium)
        }
        topView.snp.remakeConstraints { make in
            make.bottom.equalTo(calculatorContainer.snp.top)
            make.leading.trailing.equalTo(calculatorContainer)
        }
        mainStackView.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Spacing.medium)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.small)
            make.bottom.equalTo(view.layoutMarginsGuide)
        }
        calculatorContainer.snp.remakeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Buttons
    private func configureButtons() {
        let lines: [[ButtonModel]] = [
            [
                ButtonModel(action: .chooseType),
                ButtonModel(value: "C", action: .clear),
                ButtonModel(icon: "delete.left", action: .delete),
                ButtonModel(value: "+", icon: "plus"),
            ],
            [
                ButtonModel(value: "7"),
                ButtonModel(value: "8"),
                ButtonModel(value: "9"),
                ButtonModel(value: "-", icon: "minus"),
            ],
            [
                ButtonModel(value: "4"),
                ButtonModel(value: "5"),
                ButtonModel(value: "6"),
                ButtonModel(value: "*", icon: "multiply"),
            ],
            [
                ButtonModel(value: "1"),
                ButtonModel(value: "2"),
                ButtonModel(value: "3"),
                ButtonModel(value: "/", icon: "divide"),
            ],
            [
                ButtonModel(value: "."),
                ButtonModel(value: "0"),
                ButtonModel(icon: "equal", action: .equal),
                ButtonModel(icon: "checkmark", action: .done),
            ],
        ]
        
        for line in lines {
            let stackView = UIStackView()
            stackView.distribution = .equalSpacing
            stackView.axis = .horizontal
            
            for item in line {
                switch item.action {
                case .append:
                    if let value = item.value {
                        // plus, minus, multiply, divide
                        var width: Double = (item.icon == nil) ? 96 : 60
                        let view = CalculatorSymbolButton(value: item.value, iconName: item.icon, width: width)
                        view.tapHandler = { [weak self] in
                            self?.didRequestToAppend(value)
                        }
                        stackView.addArrangedSubview(view)
                    }
                case .chooseType:
                    stackView.addArrangedSubview(chooseButton)
                case .done, .delete, .equal, .clear:
                    let width: Double = item.action == .done ? 60 : 96
                    let backgroundColor: UIColor? = item.action == .done ? .systemOrange : nil
                    
                    let view = CalculatorSymbolButton(value: item.value, iconName: item.icon, backgroundColor: backgroundColor, width: width)
                    view.tapHandler = { [weak self] in
                        self?.didRequestTodo(item.action)
                    }
                    stackView.addArrangedSubview(view)
                }
            }
            mainStackView.addArrangedSubview(stackView)
        }
    }
    
    private func didRequestToAppend(_ value: String) {
        if value == "." && currentValue.contains(".") { return }
        currentValue += value
    }

    private func calculate() {
        if let last = currentValue.last, last == "." {
            currentValue = String(currentValue.dropLast(1))
        }
        let expression = NSExpression(format: currentValue)
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            currentValue = String(result.doubleValue)
        }
    }

    private func presentCurrencyList() {
        let viewController = PickerViewController(text: "Choose", options: CurrencyCode.list)
        viewController.didPickOption = { [weak self] value in
            self?.currencyCode = value
        }
        present(viewController.embedInNavgationController(), animated: true)
    }
    
    private func didRequestTodo(_ action: ButtonAction) {
        switch action {
        case .clear:
            currentValue = ""
        case .chooseType:
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Income", style: .default, handler: { _ in
                self.type = .income
            }))
            alert.addAction(UIAlertAction(title: "Expense", style: .default, handler: { _ in
                self.type = .expense
            }))
            alert.addAction(UIAlertAction(title: "Transfer", style: .default, handler: { _ in
                self.type = .transfer
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true)
            
        case .delete:
            currentValue = String(currentValue.dropLast(1))
        case .equal:
            calculate()
        case .done:
            calculate()
            if let value = Double(currentValue) {
                didTapDoneHandler?(value)
            }
            didChangeCurrencyCode?(currencyCode)
            self.dismiss(animated: true)
        default:
            return
        }
    }
}

// MARK: - ButtonModel
extension CalculatorViewController {
    enum ButtonModelType {
        case symbol
        case digit
        case action
    }
    
    enum ButtonAction {
        case append
        case clear
        case chooseType
        case delete
        case equal
        case done
    }
    
    private struct ButtonModel {
        let label: String?
        let value: String?
        let icon: String?
        let action: ButtonAction
        
        init(label: String? = nil, value: String? = nil, icon: String? = nil, action: ButtonAction = .append) {
            self.label = label
            self.value = value
            self.icon = icon
            self.action = action
        }
    }
}
