//
//  ViewController.swift
//  cApp
//
//  Created by Andrew Connors on 2016-10-21.
//  Copyright © 2016 Andrew Connors. All rights reserved.
//

import UIKit
import Charts
import CoreBluetooth

class ViewController: UIViewController, ChartViewDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @IBOutlet weak var deviceLabel: UILabel!
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var startScan: UIButton!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    //CB Variables
    var central_Manager:CBCentralManager!
    var arduino:CBPeripheral?
    var arduinoData: CBCharacteristic?
    let arduinoName = "MPU NUS"
    var bgImage     = UIImage(named: "icerink.png");
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceLabel!.text = "Not Working"
        startScan.enabled = false
        central_Manager = CBCentralManager(delegate: self, queue: nil)
        
        
        createChartSets()
        
        chartView.noDataText = "You need to set some data points for the chart."
        self.chartView.delegate = self
        chartView.dragEnabled = true
        chartView.scaleXEnabled = true
        
        //var timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(ViewController.plotPoint), userInfo: nil, repeats: true)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var count = 0
    
    func plotPoint(dataPoint: Double, y: Double) {
        let newDataPoint = dataPoint
        let newDataPoint2 = y

        chartView.data?.addEntry(ChartDataEntry(value: newDataPoint, xIndex: count), dataSetIndex: 0)
        chartView.data?.addEntry(ChartDataEntry(value: newDataPoint2, xIndex: count), dataSetIndex: 1)
        chartView.data?.addXValue(String(count))
        self.chartView.setVisibleXRangeMaximum(10.0)

        self.chartView.notifyDataSetChanged()
        self.chartView.moveViewToX(CGFloat(count))
        self.chartView.moveViewToAnimated(xIndex: CGFloat((chartView.data?.getDataSetByIndex(0).entryCount)!), yValue: 0.0, axis: ChartYAxis.AxisDependency.Left, duration: NSTimeInterval(floatLiteral: 1))

        count = count + 1

    }
    
    func createChartSets(){
        let first_set = LineChartDataSet(yVals: [ChartDataEntry](), label: "First Set")
        first_set.drawCirclesEnabled = false
        first_set.setColor(UIColor.redColor())
        first_set.drawFilledEnabled = false
        first_set.drawCubicEnabled = true
        
        let ss = LineChartDataSet(yVals: [ChartDataEntry](), label: "Second Set")
        ss.drawCirclesEnabled = false
        ss.setColor(UIColor.greenColor())
        ss.drawFilledEnabled = false
        ss.drawCubicEnabled = true
        
        self.chartView.data = LineChartData(xVals: [String](), dataSets: [first_set, ss])
    }
    
    @IBAction func toggleScan(sender: UIButton) {
        if(startScan.currentTitle == "Start Scan"){
            startScan.setTitle("Stop Scan", forState: .Normal)
            central_Manager.scanForPeripheralsWithServices(nil, options: nil)
        }else if(startScan.currentTitle == "Stop Scan"){
            startScan.setTitle("Start Scan", forState: .Normal)
            central_Manager.stopScan()
        }
    }
    
    //MARK- CBCentralManager methods
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case .PoweredOff:
            deviceLabel!.text = "Bluetooth on this device is currently powered off."
        case .Unsupported:
            deviceLabel!.text = "This device does not support Bluetooth Low Energy."
        case .Unauthorized:
            deviceLabel!.text = "This app is not authorized to use Bluetooth Low Energy."
        case .Resetting:
            deviceLabel!.text = "The BLE Manager is resetting; a state update is pending."
        case .Unknown:
            deviceLabel!.text = "The state of the BLE Manager is unknown."
        case .PoweredOn:
            startScan.enabled = true
            deviceLabel!.text = "BLE Good To Go"
        }
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
        
        
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("***Connected!!")
        
        deviceLabel!.text = "CONNECTED!!!"
        arduino?.discoverServices(nil)
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
        
        dataLabel.text = datastring as! String
        
        let dataArr = datastring?.componentsSeparatedByString(";")
        let acclX = Double((dataArr?[0])!)
        let acclY = Double((dataArr?[1])!)
        plotPoint(acclX!, y: acclY!)
        //This is where you're going to get a value to plot
//        if let dataPoint = characteristic.value{
//            plotPoint(dataPoint);
//        }
        
        
    }
    
    
        
//
//    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
//        <#code#>
//    }
    
    


}
