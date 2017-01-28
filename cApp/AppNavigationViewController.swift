//
//  AppNavigationViewController.swift
//  cApp
//
//  Created by Andrew Connors on 2017-01-21.
//  Copyright © 2017 Andrew Connors. All rights reserved.
//

import UIKit

class AppNavigationViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var reportsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var playerInfoButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "images/eouzdiba.png")!)
        reportsButton.setImage(UIImage(named: "pageicon.png"), forState: .Normal)
        settingsButton.setImage(UIImage(named: "settings.png"), forState: .Normal)
        playerInfoButton.setImage(UIImage(named: "conference.png"), forState: .Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
