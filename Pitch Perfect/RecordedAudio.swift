//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Wassim Seifeddine on 3/3/16.
//  Copyright © 2016 Wassim Seifeddine. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathURL : NSURL!
    var title : String!
    
    init(title:String, filePathIURL:NSURL){
        self.title = title
        self.filePathURL = filePathIURL
    }
}
