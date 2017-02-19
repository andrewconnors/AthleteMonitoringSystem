//
//  ViewController.swift
//  cApp
//
//  Created by Andrew Connors on 2016-10-21.
//  Copyright © 2016 Andrew Connors. All rights reserved.
//

import UIKit
import Charts
//import bluetooth functionality?

class ViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var goodJumps: UILabel!
    @IBOutlet weak var deviceLabel: UILabel!
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var badJumps: UILabel!
    @IBOutlet weak var startScan: UIButton!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    //CB Variables
    let bleController = Bluetooth(name: "MPU NUS")
    var bgImage     = UIImage(named: "icerink.png");
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        deviceLabel!.text = "Not Working"
        startScan.enabled = false
        
        createChartSets()
        chartView.alpha = 0.9
        chartView.noDataText = "You need to set some data points for the chart."
        self.chartView.delegate = self
        chartView.dragEnabled = true
        chartView.scaleXEnabled = true
        
        let size:CGFloat = 120.0
        
        goodJumps.bounds = CGRectMake(0.0, 0.0, size, size)
        goodJumps.layer.cornerRadius = size / 2
        goodJumps.layer.borderWidth = 3.0
        goodJumps.layer.backgroundColor = UIColor.clearColor().CGColor
        goodJumps.layer.borderColor = UIColor.greenColor().CGColor
        
        badJumps.bounds = CGRectMake(0.0, 0.0, size, size)
        badJumps.layer.cornerRadius = size / 2
        badJumps.layer.borderWidth = 3.0
        badJumps.layer.backgroundColor = UIColor.clearColor().CGColor
        badJumps.layer.borderColor = UIColor.redColor().CGColor
        
        //Get state of bluetooth controller
        getBluetoothState()
        
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
            bleController.startScan();
            
        }else if(startScan.currentTitle == "Stop Scan"){
            startScan.setTitle("Start Scan", forState: .Normal)
            bleController.stopScan()
        }
    }
    
    func getBluetoothState(){
        if(bleController.getState() == "PoweredOn"){
            startScan.enabled = true;
        }else{
            deviceLabel!.text = bleController.getMessage();
        }
    }
    
    
    
    
        
        
    
    
    
    
    
        
//
//    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
//        <#code#>
//    }
    
    


}
