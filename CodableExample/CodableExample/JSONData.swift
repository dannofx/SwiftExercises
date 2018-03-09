//
//  JSONData.swift
//  CodableExample
//
//  Created by Danno on 3/8/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import Foundation

func loadJSONData() -> Data? {
    let jsonText = """
                    [
                    {
                    "title": "The Pretender",
                    "artist": "Foo Fighters",
                    "time": 320
                    },
                    {
                    "title": "May 16",
                    "artist": "Lagwagon",
                    "time": 300
                    },
                    {
                    "title": "Superman's Song",
                    "artist": "Crash Test For Dummies",
                    "time": 290
                    },
                    {
                    "title": "Do Me Like a Caveman",
                    "artist": "Edguy",
                    "time": 240
                    }
                    ]
                   """
    return jsonText.data(using: .utf8)
}
