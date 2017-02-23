//
//  PlayerStatsViewController.swift
//  cApp
//
//  Created by Andrew Connors on 2017-01-24.
//  Copyright © 2017 Andrew Connors. All rights reserved.
//

import UIKit

class PlayerStatsViewController: UIViewController {

    @IBOutlet weak var barChartImagePlaceholder: UIImageView!
    @IBOutlet weak var pieChartImagePlaceholder: UIImageView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartImagePlaceholder.image = UIImage(named: "images/combined_chart.png")
        pieChartImagePlaceholder.image = UIImage(named: "images/pie_chart-512.png")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backToPlayerList(sender: AnyObject) {
        self.performSegueWithIdentifier("playerScreenToPlayerList", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
