//
//  Athlete.swift
//  cApp
//
//  Created by Andrew Connors on 2017-02-11.
//  Copyright © 2017 Andrew Connors. All rights reserved.
//

import Foundation

class Athlete{
    var name: String
    var weight: Double
    var height: Double
    var age: Int
    
    init(name: String, weight:Double, height:Double, age:Int){
        self.name = name
        self.weight = weight
        self.height = height
        self.age = age
    }
    
    func changeName(newName:String){
        self.name = newName
    }
    
    func changeAge(newAge:Int){
        self.age = newAge
    }
    
    func changeWeight(newWeight:Double){
        self.weight = newWeight
    }
    
    func changeHeight(newHeight:Double){
        self.height=newHeight
    }
    
    func getName() -> String{
        return self.name
    }
    
    func getWeight() -> Double{
        return self.weight
    }
    
    func getHeight() -> Double{
        return self.height
    }
    
    func getAge() -> Int{
        return self.age
    }
}
