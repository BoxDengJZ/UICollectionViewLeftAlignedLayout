//
//  HistoryModel.swift
//  petit
//
//  Created by Jz D on 2020/11/4.
//  Copyright © 2020 swift. All rights reserved.
//

import Foundation



struct HistoryModel {
    let histories: [FileRecord]
    
    
    private
    let version_name: String
    
    let publisher_name: String
    
    
    private
    let book_name: String
    
}


extension HistoryModel{
    
    var title: String{
        "\(book_name) \(version_name)"
    }
    
    
    
    static let up = HistoryModel(histories: FileRecord.up, version_name: "No 1", publisher_name: "哈哈", book_name: "Bon Jovi")
    
    static let down = HistoryModel(histories: FileRecord.up, version_name: "No 2", publisher_name: "he he", book_name: "东方神起")
}


struct FileRecord{
    let title: String

    let finish_time: String
    
}



extension FileRecord{
    
    
    static let up: [FileRecord] = [FileRecord(title: "Roulette", finish_time: "1984年1月21日"),
                                    FileRecord(title: "Price Of Love", finish_time: "1985年x月xx日")]
    
    
    static let down: [FileRecord] = [FileRecord(title: "    One More Thing", finish_time: "？年？月？日"),
                                     FileRecord(title: "Catch Me-If You", finish_time: "？年？月？日")]
 
}
