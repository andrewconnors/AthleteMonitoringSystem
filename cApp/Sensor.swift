//
//  Sensor.swift
//  cApp
//
//  Created by Andrew Connors on 2017-02-12.
//  Copyright © 2017 Andrew Connors. All rights reserved.
//

import Foundation

class Sensor{
    var id: String
    
    init(id:String){
        self.id = id
    }
    
    func getID() -> String{
        return self.id
    }
    
    func setID(newID: String){
        self.id = newID
    }
    
}
