//
//  Score.swift
//  MemoryGame
//
//  Created by Lior Cohen on 08/06/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import Foundation

struct Score : Codable, Comparable {
    
    var name:String
    var time:Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case time
    }
    
    init(name:String,time:Int) {
        self.name = name
        self.time = time
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(time, forKey: .time)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        time = try container.decode(Int.self, forKey: .time)
    }
    
    static func load() -> [Score]?{
        if let data = UserDefaults.standard.object(forKey: StaticValues.RECORDS_NAME_FILE) as? Data,  let scores = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Score]
        {
            return scores
        }
        return nil
    }
    
    static func save(score:Score){
        var scores:[Score]? = load()
        if scores != nil {
            scores?.append(score)
            scores?.sort()
        }
        else
        {
            scores = [score]
        }
        saveToFile(scores: scores!)
    }
    
    private static func saveToFile(scores:[Score]){
        let data = NSKeyedArchiver.archivedData(withRootObject: scores)
        UserDefaults.standard.set(data, forKey: StaticValues.RECORDS_NAME_FILE)
        UserDefaults.standard.synchronize()
    }
    
    static func < (lhs: Score, rhs: Score) -> Bool {
        return lhs.time < rhs.time
    }
}








