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
    private let leadingSeparator = UIView()
    private let trailingSeparator = UIView()
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
        stackView.contentMode = .scaleAspectFit
        addSubview(stackView)
        
        leadingSeparator.backgroundColor = .white
        stackView.addArrangedSubview(leadingSeparator)
        stackView.addArrangedSubview(incomeStack)
        leftSeparator.backgroundColor = .systemGray.withAlphaComponent(0.2)
        stackView.addArrangedSubview(leftSeparator)
        stackView.addArrangedSubview(expenseStack)
        rightSeparator.backgroundColor = .systemGray.withAlphaComponent(0.2)
        stackView.addArrangedSubview(rightSeparator)
        stackView.addArrangedSubview(balanceStack)
        trailingSeparator.backgroundColor = .white
        stackView.addArrangedSubview(trailingSeparator)
        
        topSeparator.backgroundColor = .systemGray.withAlphaComponent(0.2)
        addSubview(topSeparator)
        bottomSeparator.backgroundColor = .systemGray.withAlphaComponent(0.2)
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
            make.width.equalTo(90)
        }
        expenseStack.snp.remakeConstraints { make in
            make.width.equalTo(90)
        }
        balanceStack.snp.remakeConstraints { make in
            make.width.equalTo(90)
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
        leadingSeparator.snp.remakeConstraints { make in
            make.width.equalTo(1)
        }
        trailingSeparator.snp.remakeConstraints { make in
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
            case .income: return .systemGreen
            case .expense: return .systemRed
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
            valueLabel.text = value?.toCurrencyString() ?? ""
        }
    }
    
    init(type: ValueType) {
        self.type = type
        super.init(frame: .zero)
        
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
        titleLabel.text = type.rawValue
        titleLabel.font = .small
        addSubview(titleLabel)
        valueLabel.textAlignment = .center
        valueLabel.textColor = type.color
        valueLabel.font = .smallBold
        addSubview(valueLabel)
        
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Spacing.trivial)
            make.centerX.equalToSuperview()
            make.leading.trailing.lessThanOrEqualToSuperview()
        }
        valueLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Spacing.slight)
            make.bottom.equalToSuperview().inset(Constants.Spacing.trivial)
            make.centerX.equalToSuperview()
            make.leading.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
