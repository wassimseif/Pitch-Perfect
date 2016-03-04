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
    
    func getTitle() -> String{
        return self.title
    }
    
    func getFilePathURL() -> NSURL {
        return filePathURL ?? nil
    }
    
    func setTitle(newTitle : String){
        self.title = newTitle
    }
    
    func setFilePathURL(newFilePathURL : NSURL){
        self.filePathURL = newFilePathURL
    }
}
