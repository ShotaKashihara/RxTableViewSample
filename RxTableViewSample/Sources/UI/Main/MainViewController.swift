//
//  MainViewController.swift
//  RxTableViewSample
//
//  Created by Shota Kashihara on 2017/12/14.
//  Copyright © 2017年 Karadanote Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var taikendanDataService: TaikendanDataService!
    private var viewModel: MainViewModel!
    private let disposeBag = DisposeBag()
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<SectionOfTaikendanData>?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taikendanDataService = TaikendanDataService()
        
        self.configureViewModel()
        self.configureBindings()
    }
    
    // MARK: - Private
    
    private func configureViewModel() {
        self.viewModel = MainViewModel.init(
            taikendanDataService: self.taikendanDataService,
            refreshDriver: self.refreshButton.rx.tap.asDriver()
        )
    }
    
    private func configureBindings() {
        self.viewModel.isLoading
            .map { !$0 }
            .drive(self.tableView.rx.isHidden)
            .disposed(by: self.disposeBag)

        self.viewModel.title
            .drive(self.rx.title)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: -
}
