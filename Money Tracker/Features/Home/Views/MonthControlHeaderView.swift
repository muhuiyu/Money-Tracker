//
//  MonthControlHeaderView.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit
import RxRelay
import RxSwift

class MonthControlHeaderView: UIView {
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    private let previousButton = IconButton(icon: UIImage(systemName: Icons.chevronBackward))
    private let nextButton = IconButton(icon: UIImage(systemName: Icons.chevronForward))
    private let monthLabel = UILabel()
    
    // MARK: - States
    let yearMonth = BehaviorRelay<YearMonth>(value: YearMonth.now)
    
    // MARK: - Handlers
    var previousButtonTapHandler: (() -> Void)? {
        didSet {
            previousButton.tapHandler = previousButtonTapHandler
        }
    }
    var nextButtonTapHandler: (() -> Void)? {
        didSet {
            nextButton.tapHandler = nextButtonTapHandler
        }
    }
    
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
extension MonthControlHeaderView {
    private func configureViews() {
        addSubview(previousButton)
        addSubview(nextButton)
        monthLabel.text = yearMonth.value.getMonthString().uppercased()
        monthLabel.font = .bodyHeavy
        monthLabel.textAlignment = .center
        addSubview(monthLabel)
    }
    private func configureConstraints() {
        previousButton.snp.remakeConstraints { make in
            make.leading.equalTo(layoutMarginsGuide).inset(Constants.Spacing.large)
            make.centerY.equalTo(monthLabel)
        }
        nextButton.snp.remakeConstraints { make in
            make.trailing.equalTo(layoutMarginsGuide).inset(Constants.Spacing.large)
            make.centerY.equalTo(monthLabel)
        }
        monthLabel.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    private func configureBindings() {
        yearMonth
            .asObservable()
            .subscribe { [weak self] value in
                self?.monthLabel.text = value.getMonthString().uppercased()
            }
            .disposed(by: disposeBag)
    }
}

