//
//  AnalysisHeaderViewController.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/5/22.
//

import UIKit
import RxSwift
import Charts

//private class CubicLineSampleFillFormatter: FillFormatter {
//    func getFillLinePosition(dataSet: Charts.LineChartDataSetProtocol, dataProvider: Charts.LineChartDataProvider) -> CGFloat {
//        return -10
//    }
//}

class AnalysisHeaderViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    // MARK: - View
    private let containerView = UIView()
    private let monthLabel = UILabel()
    private let amountLabel = UILabel()
    private let compareStack = UIStackView()
    private let compareLabel = UILabel()
    private let compareResultLabel = UILabel()
    
//    private let chartContainerView = UIView()
//    private let chartView = LineChartView()
//    private let yAxisMaximumLabel = UILabel()
    
    // MARK: - Data
    // TODO: - Connect to database
    let monthAndYear: MonthAndYear
    let averageExpense: Double
    let expenseData: [Double]
    
    init(monthAndYear: MonthAndYear,
         averageExpense: Double,
         expenseData: [Double]) {
        self.monthAndYear = monthAndYear
        self.averageExpense = averageExpense
        self.expenseData = expenseData
        super.init()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureViews()
//        configureConstraints()
//        configureSignals()
    }

}
// MARK: - TapHandlers
extension AnalysisHeaderViewController {
    
}
// MARK: - View Config
//extension AnalysisHeaderViewController {
//    private func configureViews() {
//        guard let currentMonthExpense = expenseData.last else { return }
//
//        amountLabel.text = currentMonthExpense.toCurrencyString(shouldRoundOffToInt: true)
//        amountLabel.font = UIFont.h3
//        amountLabel.textColor = .label
//        amountLabel.textAlignment = .left
//        containerView.addSubview(amountLabel)
//
//        compareLabel.font = UIFont.desc
//        compareLabel.textColor = .label
//        compareLabel.text = Localized.Analysis.totalExpense
//        compareStack.addArrangedSubview(compareLabel)
//        compareResultLabel.textColor = currentMonthExpense > averageExpense ? .systemRed : .systemGreen
//        let difference = (currentMonthExpense - averageExpense)
//        let frontSymbol = difference > 0 ? "▲" : "▼"
//        compareResultLabel.font = UIFont.desc
//        compareResultLabel.text = "\(frontSymbol) \(difference.toCurrencyString(shouldRoundOffToInt: true))"
//        compareStack.addArrangedSubview(compareResultLabel)
//        compareStack.axis = .horizontal
//        compareStack.spacing = Constants.Spacing.small
//        compareStack.alignment = .bottom
//        containerView.addSubview(compareStack)
//
//        configureChart()
//        containerView.addSubview(chartContainerView)
//
//        containerView.backgroundColor = .secondarySystemBackground
//        containerView.layer.cornerRadius = 20
//        view.addSubview(containerView)
//    }
//    private func configureChart() {
//        var lineChartEntry = [ChartDataEntry]()
//        for i in 0..<expenseData.count {
//            let value = ChartDataEntry(x: Double(i), y: expenseData[i])
//            lineChartEntry.append(value)
//        }
//
//        let line1 = LineChartDataSet(entries: lineChartEntry, label: "expenseData")
//        line1.mode = .cubicBezier
//        line1.valueTextColor = .clear
//        line1.drawFilledEnabled = true
//        line1.drawCirclesEnabled = false
//        line1.lineWidth = 1.8
//        line1.circleRadius = 0
//        line1.colors = [NSUIColor.blue]
//        line1.fillColor = NSUIColor.cyan.withAlphaComponent(0.4)
//        line1.fillAlpha = 1
//        line1.drawHorizontalHighlightIndicatorEnabled = false
//        line1.fillFormatter = CubicLineSampleFillFormatter()
//
//        let data = LineChartData(dataSet: line1)
//        chartView.data = data
//        chartView.backgroundColor = .clear
//        chartView.dragEnabled = false
//        chartView.setScaleEnabled(false)
//        chartView.pinchZoomEnabled = false
//        chartView.maxHighlightDistance = 300
//
//        let xAxis = chartView.xAxis
//        xAxis.labelTextColor = .tertiaryLabel
//        xAxis.setLabelCount(6, force: true)
//        xAxis.labelPosition = .bottom
//        xAxis.axisLineColor = .clear
//        xAxis.drawGridLinesEnabled = false
//
//        if let font = UIFont.desc {
//            xAxis.labelFont = font
//        }
//
//        chartView.rightAxis.enabled = false
//        chartView.leftAxis.enabled = false
//        chartView.legend.enabled = false
//        chartView.animate(xAxisDuration: 0.5, yAxisDuration: 1)
//        chartContainerView.addSubview(chartView)
//
//        yAxisMaximumLabel.font = UIFont.desc
//        yAxisMaximumLabel.textColor = .tertiaryLabel
//        yAxisMaximumLabel.textAlignment = .right
//        yAxisMaximumLabel.text = expenseData.last?.toCurrencyString(shouldRoundOffToInt: true)
//        chartContainerView.addSubview(yAxisMaximumLabel)
//    }
//    private func configureConstraints() {
//        amountLabel.snp.remakeConstraints { make in
//            make.top.leading.trailing.equalToSuperview().inset(Constants.Spacing.medium)
//        }
//        compareStack.snp.remakeConstraints { make in
//            make.top.equalTo(amountLabel.snp.bottom).offset(Constants.Spacing.small)
//            make.leading.equalTo(amountLabel)
//        }
//        chartContainerView.snp.remakeConstraints { make in
//            make.top.equalTo(compareStack.snp.bottom).offset(Constants.Spacing.small)
//            make.leading.trailing.equalTo(amountLabel)
//            make.bottom.equalToSuperview().inset(Constants.Spacing.medium)
//        }
//        chartView.snp.remakeConstraints { make in
//            make.top.leading.bottom.equalToSuperview()
//            make.trailing.equalTo(yAxisMaximumLabel.snp.leading)
//        }
//        yAxisMaximumLabel.snp.remakeConstraints { make in
//            make.top.equalTo(chartView).offset(Constants.Spacing.slight)
//            make.trailing.equalToSuperview()
//        }
//        containerView.snp.remakeConstraints { make in
//            make.edges.equalTo(view.layoutMarginsGuide)
//        }
//    }
//    private func configureSignals() {
//        // TODO: - connect to viewModels
//    }
//}
