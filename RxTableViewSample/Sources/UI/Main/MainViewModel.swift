//
//  MainDataSource.swift
//  RxTableViewSample
//
//  Created by Shota Kashihara on 2017/12/14.
//  Copyright © 2017年 Karadanote Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    // MARK: - Vars
    
    let title: Driver<String>
    let isLoading: Driver<Bool>
    let hasFailed: Driver<Bool>
    
    private enum TaikendanDataEvent {
        case loading
        case taikendanData(TaikendanData)
        case error
    }
    
    // MARK: - Init
    
    init(
        taikendanDataService: TaikendanDataService,
        refreshDriver: Driver<Void>) {
        
        let taikendanDataEventDriver = refreshDriver
            .startWith(())
            .flatMapLatest { _ -> Driver<TaikendanDataEvent> in
                return taikendanDataService.fetchTaikendanData()
                    .map { .taikendanData($0) }
                    .asDriver(onErrorJustReturn: .error)
                    .startWith(.loading)
        }
        
        self.isLoading = taikendanDataEventDriver
            .map { event in
                switch event {
                case .loading: return true
                default: return false
                }
        }
        
        self.hasFailed = taikendanDataEventDriver
            .map { event in
                switch event {
                case .error: return true
                default: return false
                }
        }
        
        let taikendanDataDriver = taikendanDataEventDriver
            .map { event -> TaikendanData? in
                switch event {
                case .taikendanData(let data): return data
                default: return nil
                }
            }
            .filter { $0 != nil }
            .map { $0! }
        
        self.title = taikendanDataDriver
            .map { $0.title }
    }
}
