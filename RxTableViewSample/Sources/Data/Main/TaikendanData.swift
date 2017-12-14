//
//  TaikendanData.swift
//  RxTableViewSample
//
//  Created by Shota Kashihara on 2017/12/14.
//  Copyright © 2017年 Karadanote Inc. All rights reserved.
//

import RxDataSources

struct SectionOfTaikendanData {
    var header: String
    var items: [TaikendanData]
}

extension SectionOfTaikendanData: AnimatableSectionModelType {
    typealias Item = TaikendanData
    init(original: SectionOfTaikendanData, items: [SectionOfTaikendanData.Item]) {
        self = original
        self.items = items
    }
}

public struct TaikendanData {
    let title: String
    let context: String
    let image: String
    let url: String
}
