//
//  LoginViewController.swift
//  cApp
//
//  Created by Andrew Connors on 2017-01-20.
//  Copyright © 2017 Andrew Connors. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginInfoErrorLabel: UILabel!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    var login = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "images/eouzdiba.png")!)
        let size:CGFloat = 75.0
        LoginButton.bounds = CGRectMake(0,0,size,size)
        loginInfoErrorLabel.hidden = true
        LoginButton.layer.cornerRadius = size/2
        LoginButton.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segueToNav(sender: UIButton) {
        if(login){
            self.performSegueWithIdentifier("loginToNav", sender: self);

        }else{
            loginInfoErrorLabel.hidden = false
        }
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
