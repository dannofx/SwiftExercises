//
//  Song.swift
//  CodableExample
//
//  Created by Danno on 3/8/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import Cocoa

// MARK: - Example structure
struct Song {
    var title: String
    var artist: String
    var duration: TimeInterval
    
    init(title: String, artist: String, duration: TimeInterval) {
        self.title = title
        self.artist = artist
        self.duration = duration
    }
}

// MARK: - Encoding / Decoding
extension Song: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case title
        case artist
        case duration = "time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.artist = try values.decode(String.self, forKey: .artist)
        self.duration = try values.decode(Double.self, forKey: .duration)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.artist, forKey: .artist)
        try container.encode(self.duration, forKey: .duration)
    }
}
