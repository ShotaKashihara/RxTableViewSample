//
//  TaikendanDataService.swift
//  RxTableViewSample
//
//  Created by Shota Kashihara on 2017/12/14.
//  Copyright © 2017年 Karadanote Inc. All rights reserved.
//

import Foundation
import RxSwift

open class TaikendanDataService {
    
    open func fetchTaikendanData() -> Observable<TaikendanData> {
        let observable = Observable<TaikendanData>.create { [weak self] observer in
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                let shouldFail = false//arc4random_uniform(2) == 0
                if shouldFail {
                    observer.onError(NSError.init(domain: "Fake network error", code: 0, userInfo: nil))
                } else {
                    observer.onNext((self?.createRandomTaikendanData())!)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
        return observable.share(replay: 1, scope: .whileConnected)
    }
    
    fileprivate func createRandomTaikendanData() -> TaikendanData {
        return TaikendanData(title: "hoge", context: "fuga", image: "image", url: "http://google.com")
    }
}
