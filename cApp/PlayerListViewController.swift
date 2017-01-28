//
//  PlayerListViewController.swift
//  cApp
//
//  Created by Andrew Connors on 2017-01-24.
//  Copyright © 2017 Andrew Connors. All rights reserved.
//

import UIKit

class PlayerListViewController: UIViewController {

    @IBOutlet weak var playerTable: UITableView!
    @IBOutlet weak var addPlayerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "images/eouzdiba.png")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addPlayerToList() {
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
