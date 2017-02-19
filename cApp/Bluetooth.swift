//
//  Bluetooth.swift
//  cApp
//
//  Created by Andrew Connors on 2017-02-19.
//  Copyright © 2017 Andrew Connors. All rights reserved.
//

import Foundation
import CoreBluetooth

class Bluetooth: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate{
    var central_Manager:CBCentralManager!
    var arduino:CBPeripheral?
    var arduinoData: CBCharacteristic?
    var arduinoName: String
    var updateMessage: String
    var state: String
    
     init(name: String){
        self.state = ""
        self.updateMessage = ""
        self.arduinoName = name
        super.init()
        self.central_Manager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    //Functions to adhere to delegate rules.
    @objc func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case .PoweredOff:
            state = "PoweredOff"
            updateMessage = "Bluetooth on this device is currently powered off."
        case .Unsupported:
            state = "Unsupported"
            updateMessage = "This device does not support Bluetooth Low Energy."
        case .Unauthorized:
            state = "Unauthorzed"
            updateMessage = "This app is not authorized to use Bluetooth Low Energy."
        case .Resetting:
            state = "Resetting"
            updateMessage = "The BLE Manager is resetting; a state update is pending."
        case .Unknown:
            state = "Unknown"
            updateMessage = "The state of the BLE Manager is unknown."
        case .PoweredOn:
            state = "PoweredOn"
            updateMessage = "BLE Good To Go"
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("***Connected!!")
        
        updateMessage = "CONNECTED!!!"
        arduino?.discoverServices(nil)
    }
    
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        if let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            print("Next Peripheral Name: \(peripheralName)")
            print("It's UUID: \(peripheral.identifier.UUIDString)")
            
            if (peripheralName == arduinoName){
                print("THAR SHE BLOWS!")
                arduino = peripheral
                arduino!.delegate = self
                central_Manager.connectPeripheral(arduino!, options: nil)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if(error != nil){
            print("Error discovering characteristics");
            return
        }
        
        if let services = peripheral.services{
            for service in services {
                print("dicovered service: \(service)");
                //if specific service found{
                peripheral.discoverCharacteristics(nil, forService: service)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if(error != nil){
            print("Error discovering characteristics: \(error?.localizedDescription)");
            return
        }
        
        if let characteristics = service.characteristics{
            for characteristic in characteristics{
                if characteristic.UUID == CBUUID(string: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E") {
                    self.arduino?.setNotifyValue(true, forCharacteristic: characteristic)
                }
                
                print("Characteristic: \(characteristic)");
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if(error != nil){
            print("Error updating value for characteristic: \(error?.localizedDescription)");
            return
        }
        
        var count: UInt32 = 0;
        
        characteristic.value?.getBytes(&count, length: sizeof(UInt32))
        
        //        let data = NSData(bytes: count, length: count.count * sizeof(UInt32))
        //        let myString = NSString(data: data, encoding: NSUTF32LittleEndianStringEncoding) as! String
        
        
        let datastring = NSString(data: characteristic.value!, encoding: NSUTF8StringEncoding)
        print(datastring)
        
        updateMessage = datastring as! String
        
//        let dataArr = datastring?.componentsSeparatedByString(";")
//        let acclX = Double((dataArr?[0])!)
//        let acclY = Double((dataArr?[1])!)
//        plotPoint(acclX!, y: acclY!)
//        //This is where you're going to get a value to plot
//        //        if let dataPoint = characteristic.value{
//        //            plotPoint(dataPoint);
//        //        }
        
        
    }
    
    func startScan(){
        central_Manager.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    func stopScan(){
         central_Manager.stopScan()
    }
    
    func getState() -> String{
        return self.state
    }
    
    func getMessage() -> String{
        return self.updateMessage
    }
    
}
