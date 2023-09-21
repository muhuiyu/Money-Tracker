//
//  EditTransactionViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit
import RxSwift
import Vision

class EditTransactionViewController: Base.MVVMViewController<TransactionViewModel> {
    
    // MARK: - TableView
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var footerBottomConstraint: NSLayoutConstraint? = nil
    private lazy var cells: [[UITableViewCell]] = [
        [
            typeCell,
            amountCell,
//            fxRateCell,
        ],
        [
            dateCell,
            merchantCell,
            categoryCell,
        ],
        [
            tagCell,
            recurringRuleCell,
        ],
        [
            noteCell,
        ]
    ]
    
    private let typeCell = TransactionTypeCell()
    private let amountCell = TransactionAmountCell()
    private let fxRateCell = TransactionTextCell()
    private let dateCell = TransactionDateCell()
    private let merchantCell = TransactionDetailCell()
    private let categoryCell = TransactionDetailCell()
    private let tagCell = TransactionDetailCell()
    private let recurringRuleCell = TransactionTextCell()
    private let noteCell = TransactionTextViewCell()
    
    private var keyboardTrigger: IndexPath? = nil
    
    init(appCoordinator: AppCoordinator? = nil, coordinator: BaseCoordinator? = nil, viewModel: TransactionViewModel, mode: TransactionViewModel.ViewControllerMode) {
        super.init(appCoordinator: appCoordinator, coordinator: coordinator, viewModel: viewModel)
        viewModel.viewControllerMode = mode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHeightWillChange(note:)),
                                               name: UIView.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(note:)),
                                               name: UIView.keyboardWillHideNotification,
                                               object: nil)
    }
}
// MARK: - TapHandlers
extension EditTransactionViewController {
    @objc
    private func didTapClose() {
        coordinator?.presentAlert(option: BaseCoordinator.AlertControllerOption(title: "Leave without saving it?",
                                                                                message: "All changes will be discarded.",
                                                                                preferredStyle: .alert),
                                  actions: [
                                    BaseCoordinator.AlertActionOption(title: "Leave",
                                                                      style: .destructive,
                                                                      handler: { _ in
                                                                          self.coordinator?.dismissCurrentModal()
                                                                      }),
                                    BaseCoordinator.AlertActionOption(title: "Stay",
                                                                      style: .cancel,
                                                                      handler: nil)
                                  ])
    }
    @objc
    private func didTapAdd() {
        viewModel.addTransaction()
        coordinator?.dismissCurrentModal()
    }
    @objc
    private func didTapInView() {
        self.dismissKeyboard()
    }
    private func didRequestToEdit(_ field: Transaction.EditableField) {
        if let coordinator = coordinator as? TransactionCoordinator {
            coordinator.showOptionList(at: field, transactionViewModel: viewModel)
        }
    }
    private func didRequestToUpdate(_ field: Transaction.EditableField, to value: Any) {
        viewModel.updateTransaction(field, to: value)
    }
    private func didRequestToUpdateDate(to date: YearMonthDay) {
        viewModel.updateTransactionDate(to: date)
    }
    private func didRequestToViewRecurringRule() {
        // TODO: -
        print("will implement")
    }

}
// MARK: - Keyboard
extension EditTransactionViewController {
    @objc
    private func keyboardHeightWillChange(note: Notification) {
        guard let keyboardFrame = note.userInfo?[UIView.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        animateKeyboard(to: keyboardFrame.height, userInfo: note.userInfo)
    }
    @objc
    private func keyboardWillHide(note: Notification) {
        animateKeyboard(to: 0, userInfo: note.userInfo)
        keyboardTrigger = nil
    }
    private func animateKeyboard(to height: CGFloat, userInfo: [AnyHashable : Any]?) {
        let duration = userInfo?[UIView.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.15
        let animationCurveRawValue = userInfo?[UIView.keyboardAnimationCurveUserInfoKey] as? UIView.AnimationCurve.RawValue
        let animationOptions: UIView.AnimationOptions
        switch animationCurveRawValue {
        case UIView.AnimationCurve.linear.rawValue:
            animationOptions = .curveLinear
        case UIView.AnimationCurve.easeIn.rawValue:
            animationOptions = .curveEaseIn
        case UIView.AnimationCurve.easeOut.rawValue:
            animationOptions = .curveEaseOut
        case UIView.AnimationCurve.easeInOut.rawValue:
            animationOptions = .curveEaseInOut
        default:
            animationOptions = .curveEaseInOut
        }
        footerBottomConstraint?.constant = -height
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [animationOptions, .beginFromCurrentState]) {
            self.view.layoutIfNeeded()
        } completion: { isSuccess in
            if isSuccess, let indexPath = self.keyboardTrigger {
                DispatchQueue.main.async {
                    print(indexPath)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        }
    }
}
// MARK: - View Config
extension EditTransactionViewController {
    private func configureViews() {
        switch viewModel.viewControllerMode {
        case .add:
            navigationItem.setTitle(Localized.TransactionDetail.addTransaction)
            navigationItem.setBarButtonItem(at: .left,
                                            image: UIImage(systemName: Icons.xmark),
                                            target: self,
                                            action: #selector(didTapClose))
            navigationItem.setBarButtonItem(at: .right,
                                            with: Localized.General.add,
                                            target: self,
                                            action: #selector(didTapAdd))
        case .edit:
            navigationItem.setTitle(Localized.TransactionDetail.transactionDetail)
        }

        configureCells()

        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(TransactionAmountCell.self, forCellReuseIdentifier: TransactionAmountCell.reuseID)
        tableView.register(TransactionDateCell.self, forCellReuseIdentifier: TransactionDateCell.reuseID)
        tableView.register(TransactionDetailCell.self, forCellReuseIdentifier: TransactionDetailCell.reuseID)
        tableView.register(TransactionTextFieldCell.self, forCellReuseIdentifier: TransactionTextFieldCell.reuseID)
        tableView.register(TransactionToggleCell.self, forCellReuseIdentifier: TransactionToggleCell.reuseID)
        view.addSubview(tableView)
    }
    private func configureCells() {
        typeCell.didChangeValueHandler = { [weak self] type in
            self?.didRequestToUpdate(.type, to: type)
        }
        amountCell.didTapInCellHandler = { [weak self] in
            self?.presentCalculator()
        }
        fxRateCell.value = "default"
        fxRateCell.numberOfLines = 0
        fxRateCell.isHidden = true

        dateCell.title = Localized.TransactionDetail.date
        dateCell.date = YearMonthDay.today
        dateCell.endEditingHandler = { [weak self] in
            if let date = self?.dateCell.date {
                self?.didRequestToUpdateDate(to: date)
            }
        }
        merchantCell.icon = UIImage(systemName: Icons.person)
        merchantCell.title = Localized.TransactionDetail.merchant
        merchantCell.value = Localized.TransactionDetail.addMerchant
        merchantCell.valueIcon = viewModel.displayMerchantCellIcon
        merchantCell.valueIconColor = .systemCyan
        merchantCell.tapHandler = { [weak self] in
            self?.didRequestToEdit(.merchantID)
        }
        categoryCell.icon = UIImage(systemName: Icons.squareGrid2x2)
        categoryCell.title = Localized.TransactionDetail.category
        categoryCell.value = Localized.TransactionDetail.addCategory
        categoryCell.valueIcon = viewModel.displayCategoryCellIcon
        categoryCell.valueIconColor = viewModel.displayIconColor
        categoryCell.tapHandler = { [weak self] in
            self?.didRequestToEdit(.categoryID)
        }
        recurringRuleCell.value = "default"
        recurringRuleCell.tapHandler = { [weak self] in
            self?.didRequestToViewRecurringRule()
        }
        tagCell.icon = UIImage(systemName: Icons.tag)
        tagCell.title = Localized.TransactionDetail.tag
        tagCell.value = Localized.TransactionDetail.addTag
        tagCell.valueIcon = viewModel.displayTagCellIcon
        tagCell.tapHandler = { [weak self] in
            self?.didRequestToEdit(.tag)
        }
        noteCell.placeholder = Localized.TransactionDetail.addNote
        noteCell.didChangeValueHandler = { [weak self] in
            self?.didRequestToUpdate(.note, to: self?.noteCell.value ?? "")
        }
        noteCell.didTapInCellHandler = { [weak self] in
            self?.keyboardTrigger = IndexPath(row: 0, section: 3)
        }
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            footerBottomConstraint = make.bottom
                .equalTo(view.safeAreaLayoutGuide)
                .constraint.layoutConstraints.first
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        view.addGestureRecognizer(tapRecognizer)
    }
    private func configureBindings() {
        viewModel.transaction
            .asObservable()
            .subscribe { [weak self] _ in
                self?.configureData()
            }
            .disposed(by: disposeBag)
    }
    private func configureData() {
        typeCell.type = viewModel.transaction.value?.type ?? .expense
        categoryCell.valueIcon = viewModel.displayIcon
        dateCell.date = viewModel.displayDateValue
        merchantCell.value = viewModel.displayMerchantString
        amountCell.type = viewModel.transaction.value?.type ?? .expense
        amountCell.value = viewModel.displayAmountValue
        amountCell.currencyCode = viewModel.displayCurrencyCodeString
        categoryCell.value = viewModel.displayCategoryString
        categoryCell.valueIconColor = viewModel.displayIconColor
        tagCell.value = viewModel.displayTagString
        noteCell.value = viewModel.displayNoteString
        
        fxRateCell.value = viewModel.displayFxRateString
        fxRateCell.isHidden = viewModel.displayFxRateString?.isEmpty ?? true
            
        recurringRuleCell.value = viewModel.displayRecurringRuleValue
        recurringRuleCell.isHidden = viewModel.displayRecurringRuleValue?.isEmpty ?? true
    }
    
    private func presentCalculator() {
        guard let transaction = viewModel.transaction.value else { return }
        let viewController = CalculatorViewController()
        viewController.value = transaction.amount
        viewController.type = transaction.type
        viewController.didTapDoneHandler = { [weak self] value in
            self?.didRequestToUpdate(.amount, to: value)
        }
        viewController.didChangeCurrencyCode = { [weak self] value in
            self?.didRequestToUpdate(.currencyCode, to: value)
        }
        present(viewController, animated: true)
    }
}
// MARK: - Data Source
extension EditTransactionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
// MARK: - Delegate
extension EditTransactionViewController: UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.dismissKeyboard()
    }
}

