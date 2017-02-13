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
    
    @IBOutlet weak var practiceLogo: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginInfoErrorLabel.hidden = true
        LoginButton.layer.borderWidth = 1
        practiceLogo.image = UIImage(named: "images/temp_logo.png");
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: userName.frame.size.height - width, width:  userName.frame.size.width, height: userName.frame.size.height)
        
        border.borderWidth = width
        userName.layer.addSublayer(border)
        userName.layer.masksToBounds = true
        
        password.layer.addSublayer(border)
        password.layer.masksToBounds = true
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
