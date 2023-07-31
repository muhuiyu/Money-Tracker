//
//  HomeSummaryView.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit
import RxRelay
import RxSwift

class HomeSummaryView: UIView {
    private let disposeBag = DisposeBag()
    
    private let stackView = UIStackView()
    private let incomeStack = HomeSummaryStackView(type: .income)
    private let expenseStack = HomeSummaryStackView(type: .expense)
    private let balanceStack = HomeSummaryStackView(type: .balance)
    
    private let topSeparator = UIView()
    private let bottomSeparator = UIView()
    private let leftSeparator = UIView()
    private let rightSeparator = UIView()
    
    var income = BehaviorRelay(value: Double())
    var expense = BehaviorRelay(value: Double())
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
        configureBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Config
extension HomeSummaryView {
    private func configureViews() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        stackView.addArrangedSubview(incomeStack)
        leftSeparator.backgroundColor = .gray
        stackView.addArrangedSubview(leftSeparator)
        stackView.addArrangedSubview(expenseStack)
        rightSeparator.backgroundColor = .gray
        stackView.addArrangedSubview(rightSeparator)
        stackView.addArrangedSubview(balanceStack)
        
        topSeparator.backgroundColor = .gray
        addSubview(topSeparator)
        bottomSeparator.backgroundColor = .gray
        addSubview(bottomSeparator)
    }
    private func configureConstraints() {
        topSeparator.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
        stackView.snp.remakeConstraints { make in
            make.top.equalTo(topSeparator.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomSeparator.snp.top)
        }
        incomeStack.snp.remakeConstraints { make in
            make.width.equalTo(100)
//            make.top.equalTo(topSeparator.snp.bottom)
//            make.leading.equalToSuperview()
//            make.bottom.equalTo(bottomSeparator.snp.top)
//            make.trailing.equalTo(leftSeparator.snp.leading)
        }
        expenseStack.snp.remakeConstraints { make in
            make.width.equalTo(100)
//            make.top.bottom.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.leading.equalTo(leftSeparator.snp.trailing)
//            make.trailing.equalTo(rightSeparator.snp.leading)
        }
        balanceStack.snp.remakeConstraints { make in
            make.width.equalTo(100)
//            make.trailing.equalToSuperview()
//            make.top.bottom.equalToSuperview()
//            make.leading.equalTo(rightSeparator.snp.trailing)
        }
        bottomSeparator.snp.remakeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
        leftSeparator.snp.remakeConstraints { make in
            make.width.equalTo(1)
        }
        rightSeparator.snp.remakeConstraints { make in
            make.width.equalTo(1)
        }
    }
    private func configureBindings() {
        income
            .asObservable()
            .subscribe { [weak self] value in
                self?.incomeStack.value = value
            }
            .disposed(by: disposeBag)
        
        expense
            .asObservable()
            .subscribe { [weak self] value in
                self?.expenseStack.value = value
            }
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(income, expense)
            .subscribe { [weak self] (income, expense) in
                self?.balanceStack.value = income - expense
            }
            .disposed(by: disposeBag)
    }
}


class HomeSummaryStackView: UIView {
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let type: ValueType
    
    enum ValueType: String {
        case income
        case expense
        case balance
        
        var color: UIColor {
            switch self {
            case .income: return .green
            case .expense: return .red
            case .balance: return .black
            }
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title?.capitalizingFirstLetter()
        }
    }
    
    var value: Double? {
        didSet {
            // TODO: - Change to decimal format
            valueLabel.text = "$" + (value?.toStringTwoDigits() ?? "")
        }
    }
    
    init(type: ValueType) {
        self.type = type
        super.init(frame: .zero)
        
        titleLabel.textAlignment = .center
        titleLabel.text = type.rawValue
        titleLabel.font = .small
        addSubview(titleLabel)
        valueLabel.textAlignment = .center
        valueLabel.textColor = type.color
        addSubview(valueLabel)
        
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.trailing.lessThanOrEqualToSuperview()
        }
        valueLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Spacing.small)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}