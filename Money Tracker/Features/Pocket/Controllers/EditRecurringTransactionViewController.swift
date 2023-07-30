//
//  EditRecurringTransactionViewController.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/7/22.
//

import UIKit
import RxSwift
import Vision

//class EditRecurringTransactionViewController: BaseViewController {
//    private let disposeBag = DisposeBag()
//
//    // MARK: - TableView
//    private let tableView = UITableView()
//    private var footerBottomConstraint: NSLayoutConstraint? = nil
//    private lazy var cells: [[UITableViewCell]] = [
//        [
//            amountCell,
//            fxRateCell,
//        ],
//        [
//            dateCell,
//            merchantCell,
//            categoryCell,
//            paymentMethodCell,
//        ],
//        [
//            tagCell,
//            recurringRuleCell,
//        ],
//        [
//            noteCell,
//        ]
//    ]
//
//    private let amountCell = TransactionAmountCell()
//    private let fxRateCell = TransactionTextCell()
//    private let dateCell = TransactionDateCell()
//    private let merchantCell = TransactionDetailCell()
//    private let categoryCell = TransactionDetailCell()
//    private let paymentMethodCell = TransactionDetailCell()
//    private let tagCell = TransactionDetailCell()
//    private let recurringRuleCell = TransactionTextCell()
//    private let noteCell = TransactionTextViewCell()
//
//    private var keyboardTrigger: IndexPath? = nil
//
//    var viewModel = RecurringTransactionCellViewModel()
//
//    init(mode: TransactionViewModel.ViewControllerMode) {
//        self.viewModel.viewControllerMode = mode
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureViews()
//        configureConstraints()
//        configureGestures()
//        configureSignals()
//
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardHeightWillChange(note:)),
//                                               name: UIView.keyboardWillChangeFrameNotification,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide(note:)),
//                                               name: UIView.keyboardWillHideNotification,
//                                               object: nil)
//    }
//}
//// MARK: - TapHandlers
//extension EditRecurringTransactionViewController {
//    @objc
//    private func didTapClose() {
//        homeCoordinator?.presentAlert(option: BaseCoordinator.AlertControllerOption(title: "Leave without saving it?",
//                                                                                    message: "All changes will be discarded.",
//                                                                                    preferredStyle: .alert),
//                                      actions: [
//                                        BaseCoordinator.AlertActionOption(title: "Leave",
//                                                                          style: .destructive,
//                                                                          handler: { _ in
//                                                                              self.homeCoordinator?.dismissCurrentModal()
//                                                                          }),
//                                        BaseCoordinator.AlertActionOption(title: "Stay",
//                                                                          style: .cancel,
//                                                                          handler: nil)
//                                      ])
//    }
//    @objc
//    private func didTapAdd() {
//        viewModel.addTransaction()
//        homeCoordinator?.dismissCurrentModal()
//    }
//    @objc
//    private func didTapInView() {
//        self.dismissKeyboard()
//    }
//    private func didRequestToEdit(_ field: Transaction.EditableField) {
//        homeCoordinator?.showOptionList(at: field, transactionViewModel: viewModel)
//    }
//    private func didRequestToUpdate(_ field: Transaction.EditableField, to value: Any) {
//        viewModel.updateTransaction(field, to: value)
//    }
//    private func didRequestToUpdateDate(to date: Date) {
//        viewModel.updateTransactionDate(to: date)
//    }
//    private func didRequestToViewRecurringRule() {
//        // TODO: -
//        print("will implement")
//    }
//
//}
//// MARK: - Keyboard
//extension EditRecurringTransactionViewController {
//    @objc
//    private func keyboardHeightWillChange(note: Notification) {
//        guard let keyboardFrame = note.userInfo?[UIView.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//        animateKeyboard(to: keyboardFrame.height, userInfo: note.userInfo)
//    }
//    @objc
//    private func keyboardWillHide(note: Notification) {
//        animateKeyboard(to: 0, userInfo: note.userInfo)
//        keyboardTrigger = nil
//    }
//    private func animateKeyboard(to height: CGFloat, userInfo: [AnyHashable : Any]?) {
//        let duration = userInfo?[UIView.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.15
//        let animationCurveRawValue = userInfo?[UIView.keyboardAnimationCurveUserInfoKey] as? UIView.AnimationCurve.RawValue
//        let animationOptions: UIView.AnimationOptions
//        switch animationCurveRawValue {
//        case UIView.AnimationCurve.linear.rawValue:
//            animationOptions = .curveLinear
//        case UIView.AnimationCurve.easeIn.rawValue:
//            animationOptions = .curveEaseIn
//        case UIView.AnimationCurve.easeOut.rawValue:
//            animationOptions = .curveEaseOut
//        case UIView.AnimationCurve.easeInOut.rawValue:
//            animationOptions = .curveEaseInOut
//        default:
//            animationOptions = .curveEaseInOut
//        }
//        footerBottomConstraint?.constant = -height
//        UIView.animate(withDuration: duration,
//                       delay: 0,
//                       options: [animationOptions, .beginFromCurrentState]) {
//            self.view.layoutIfNeeded()
//        } completion: { isSuccess in
//            if isSuccess, let indexPath = self.keyboardTrigger {
//                DispatchQueue.main.async {
//                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//                }
//            }
//        }
//    }
//}
//// MARK: - View Config
//extension EditRecurringTransactionViewController {
//    private func configureViews() {
//        switch viewModel.viewControllerMode {
//        case .add:
//            navigationItem.setTitle(Localized.TransactionDetail.addTransaction)
//            navigationItem.setBarButtonItem(at: .left,
//                                            image: UIImage(systemName: Icons.xmark),
//                                            target: self,
//                                            action: #selector(didTapClose))
//            navigationItem.setBarButtonItem(at: .right,
//                                            with: Localized.General.add,
//                                            target: self,
//                                            action: #selector(didTapAdd))
//        case .edit:
//            navigationItem.setTitle(Localized.TransactionDetail.transactionDetail)
//        }
//
//        configureCells()
//
//        tableView.dataSource = self
//        tableView.allowsSelection = false
//        tableView.separatorStyle = .none
//        tableView.register(TransactionAmountCell.self, forCellReuseIdentifier: TransactionAmountCell.reuseID)
//        tableView.register(TransactionDateCell.self, forCellReuseIdentifier: TransactionDateCell.reuseID)
//        tableView.register(TransactionDetailCell.self, forCellReuseIdentifier: TransactionDetailCell.reuseID)
//        tableView.register(TransactionTextFieldCell.self, forCellReuseIdentifier: TransactionTextFieldCell.reuseID)
//        tableView.register(TransactionToggleCell.self, forCellReuseIdentifier: TransactionToggleCell.reuseID)
//        view.addSubview(tableView)
//    }
//    private func configureCells() {
//        amountCell.didChangeValueHandler = { [weak self] in
//            self?.didRequestToUpdate(.amount, to: self?.amountCell.value ?? "0")
//        }
//        amountCell.didTapInCellHandler = { [weak self] in
//            self?.keyboardTrigger = IndexPath(row: 0, section: 0)
//        }
//        fxRateCell.value = "default"
//        fxRateCell.numberOfLines = 0
//        fxRateCell.isHidden = true
//
//        dateCell.title = Localized.TransactionDetail.date
//        dateCell.date = Date.today
//        dateCell.endEditingHandler = { [weak self] in
//            if let date = self?.dateCell.date {
//                self?.didRequestToUpdateDate(to: date)
//            }
//        }
//        merchantCell.title = Localized.TransactionDetail.merchant
//        merchantCell.value = Localized.TransactionDetail.addMerchant
//        merchantCell.valueIcon = viewModel.displayMerchantCellIcon
//        merchantCell.tapHandler = { [weak self] in
//            self?.didRequestToEdit(.merchant)
//        }
//        categoryCell.title = Localized.TransactionDetail.category
//        categoryCell.value = Localized.TransactionDetail.addCategory
//        categoryCell.valueIcon = viewModel.displayCategoryCellIcon
//        categoryCell.tapHandler = { [weak self] in
//            self?.didRequestToEdit(.category)
//        }
//        paymentMethodCell.title = Localized.TransactionDetail.paymentBy
//        paymentMethodCell.value = Localized.TransactionDetail.addPaymentMethod
//        paymentMethodCell.valueIcon = viewModel.displayPaymentMethodIcon
//        paymentMethodCell.tapHandler = { [weak self] in
//            self?.didRequestToEdit(.paymentBy)
//        }
//        recurringRuleCell.value = "default"
//        recurringRuleCell.tapHandler = { [weak self] in
//            self?.didRequestToViewRecurringRule()
//        }
//        tagCell.title = Localized.TransactionDetail.tag
//        tagCell.value = Localized.TransactionDetail.addTag
//        tagCell.valueIcon = viewModel.displayTagCellIcon
//        tagCell.tapHandler = { [weak self] in
//            self?.didRequestToEdit(.tag)
//        }
//        noteCell.placeholder = Localized.TransactionDetail.addNote
//        noteCell.didChangeValueHandler = { [weak self] in
//            self?.didRequestToUpdate(.note, to: self?.noteCell.value ?? "")
//        }
//        noteCell.didTapInCellHandler = { [weak self] in
//            self?.keyboardTrigger = IndexPath(row: 7, section: 0)
//        }
//    }
//    private func configureConstraints() {
//        tableView.snp.remakeConstraints { make in
//            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//            footerBottomConstraint = make.bottom
//                .equalTo(view.safeAreaLayoutGuide)
//                .inset(Constants.Spacing.medium)
//                .constraint.layoutConstraints.first
//        }
//    }
//    private func configureGestures() {
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
//        view.addGestureRecognizer(tapRecognizer)
//    }
//    private func configureSignals() {
//        viewModel.displayIcon
//            .asObservable()
//            .subscribe { value in
//                self.categoryCell.valueIcon = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayDateValue
//            .asObservable()
//            .subscribe { value in
//                self.dateCell.date = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayMerchantString
//            .asObservable()
//            .subscribe { value in
//                self.merchantCell.value = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayAmountValue
//            .asObservable()
//            .subscribe { value in
//                self.amountCell.value = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayCurrencyCodeString
//            .asObservable()
//            .subscribe { value in
//                self.amountCell.currencyCode = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayFxRateString
//            .asObservable()
//            .subscribe(onNext: { value in
//                self.fxRateCell.value = value
//                self.fxRateCell.isHidden = value.isEmpty
//            })
//            .disposed(by: disposeBag)
//
//        viewModel.displayPaymentMethodString
//            .asObservable()
//            .subscribe { value in
//                self.paymentMethodCell.value = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayCategoryString
//            .asObservable()
//            .subscribe { value in
//                self.categoryCell.value = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayTagString
//            .asObservable()
//            .subscribe { value in
//                self.tagCell.value = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayRecurringRuleValue
//            .asObservable()
//            .subscribe(onNext: { value in
//                self.recurringRuleCell.value = value
//                self.recurringRuleCell.isHidden = value.isEmpty
//            })
//            .disposed(by: disposeBag)
//
//        viewModel.displayNoteString
//            .asObservable()
//            .subscribe { value in
//                self.noteCell.value = value.isEmpty ? nil : value
//            }
//            .disposed(by: disposeBag)
//    }
//}
//// MARK: - Data Source
//extension EditRecurringTransactionViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return cells.count
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cells[section].count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return cells[indexPath.section][indexPath.row]
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .secondarySystemBackground
//        return view
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .secondarySystemBackground
//        return view
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10
//    }
//}
//// MARK: - Delegate
//extension EditRecurringTransactionViewController: UITableViewDelegate {
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.dismissKeyboard()
//    }
//}
//
//
