//
//  RealmDatabase.swift
//  cApp
//
//  Created by Andrew Connors on 2017-02-11.
//  Copyright © 2017 Andrew Connors. All rights reserved.
//

import Foundation
import RealmSwift

//Each class represents a table in the realm database

class DBPlayer: Object{
    let name: String = ""
    let age: Int = 0
    let weight: Double = 0
    let height: Double = 0
    //let sensors = List<Sensor>()
}

class DBSensor: Object{
    let id: String = ""
}

class DBTeam: Object{
    let name: String = ""
    let players = List<DBPlayer>()
}

//This class is to manage adding and deleting elements
class Database{
    
    let realm = try! Realm()
    
    func addPlayer(player: Athlete){
        try! realm.write(){
            let playerObject = realm.create(DBPlayer.self, value: [player.getName(), player.getAge(), player.getWeight(), player.getHeight()])
            realm.add(playerObject)
        }
    }
    
    func removePlayer(player: Athlete){
        try! realm.write(){
            let playerObject = realm.create(DBPlayer.self, value: [player.getName(), player.getAge(), player.getWeight(), player.getHeight()])
            realm.delete(playerObject)
        }
    }
    
    func doesExist(player: Athlete) -> Bool{
        //using name as a primary key for now but will need to change to generated ID
        let exist = realm.objects(DBPlayer.self).filter("name='Larry'") //Larry is my test case
        if(exist.count > 0){
            return true
        }
        
        return false
    }
    
    
}
