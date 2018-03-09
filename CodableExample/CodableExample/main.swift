//
//  main.swift
//  CodableExample
//
//  Created by Danno on 3/8/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import Foundation

// MARK: - Store Song using UserDefaults
let songKey = "song"
let song = Song(title: "One Headlight", artist: "The Wallflowers", duration: 312)
let userDefaults = UserDefaults.standard
userDefaults.setCodableValue(song, forKey: songKey)
guard let savedSong = userDefaults.codableValue(Song.self, forKey: songKey) else { exit(1) }
print("Saved song: ")
print(savedSong)

// MARK: - Parse JSON to [Song]
guard let jsonData = loadJSONData() else { exit(1) }
guard let jsonSongs = try? JSONDecoder().decode([Song].self, from: jsonData) else { exit(1) }
print("JSON to Song array:")
for jsonSong in jsonSongs {
    print(jsonSong)
}

