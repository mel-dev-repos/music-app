//
//  musicData.swift
//  music-app
//
//  Created by melina  on 08.09.26.
//
import Foundation

struct MusicData : Decodable {
    let tracks : Tracks
}


struct Tracks : Decodable {
    let items : [Items]
  
}


struct Items : Codable {
    let artists : [Artist]
    let name : String
    let album : Album
}


struct Artist : Codable {
    let name : String
}
struct Album  : Codable {
    let images : [Image]
}


struct Image : Codable {
    let url : String
}
