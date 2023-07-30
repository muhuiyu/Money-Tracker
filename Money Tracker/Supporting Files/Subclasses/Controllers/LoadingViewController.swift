//
//  LoadingViewController.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/6/22.
//

class LoadingViewController: ViewController {
    
    private let spinnerView = SpinnerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinnerView)
        spinnerView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
