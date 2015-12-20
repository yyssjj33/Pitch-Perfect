//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Ji Yang on 12/19/15.
//  Copyright © 2015 Ji Yang. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    override init(){}
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}