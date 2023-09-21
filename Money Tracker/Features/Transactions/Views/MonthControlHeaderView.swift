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
    private let previousButton = IconButton(icon: UIImage(systemName: Icons.chevronBackwardCircleFill))
    private let nextButton = IconButton(icon: UIImage(systemName: Icons.chevronForwardCircleFill))
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
        previousButton.contentMode = .scaleAspectFit
        previousButton.tintColor = .secondarySystemBackground
        previousButton.layer.cornerRadius = Constants.IconButtonSize.small
        previousButton.backgroundColor = .label
        addSubview(previousButton)
        nextButton.contentMode = .scaleAspectFit
        nextButton.tintColor = .secondarySystemBackground
        nextButton.layer.cornerRadius = Constants.IconButtonSize.small
        nextButton.backgroundColor = .label
        addSubview(nextButton)
        monthLabel.text = yearMonth.value.getMonthString().uppercased()
        monthLabel.font = .bodyHeavy
        monthLabel.textAlignment = .center
        addSubview(monthLabel)
    }
    private func configureConstraints() {
        previousButton.snp.remakeConstraints { make in
            make.leading.equalTo(layoutMarginsGuide).inset(Constants.Spacing.large)
            make.size.equalTo(Constants.IconButtonSize.small)
            make.centerY.equalTo(monthLabel)
        }
        nextButton.snp.remakeConstraints { make in
            make.trailing.equalTo(layoutMarginsGuide).inset(Constants.Spacing.large)
            make.size.equalTo(Constants.IconButtonSize.small)
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

