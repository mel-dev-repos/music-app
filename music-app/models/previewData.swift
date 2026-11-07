//
//  previewData.swift
//  music-app
//
//  Created by melina  on 06.11.26.
//

struct PreviewData : Codable {
    var results : [PreviewResult]
    
}

struct PreviewResult : Codable {
    var previewUrl : String?
}


