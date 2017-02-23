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
    
    @IBOutlet weak var passwordImageView: UIImageView!
    
    @IBOutlet weak var usernameImageView: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var login = true
    var usernameImage = UIImage(named: "images/username_icon.png") //NEED TO IMPORT THIS
    var passwordImage = UIImage(named: "images/password_lock_icon.png") //THIS AS WELL
    
    @IBOutlet weak var practiceLogo: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userImage.image = UIImage(named: "images/user_icon_circle.png")
        practiceLogo.image = UIImage(named: "images/temp_logo.png");
        
        username.leftViewMode = UITextFieldViewMode.Always
        password.leftViewMode = UITextFieldViewMode.Always
        
        usernameImageView.image = usernameImage
        passwordImageView.image = passwordImage
        
        username.leftView = usernameImageView
        password.leftView = passwordImageView
        
        self.view.backgroundColor = UIColor(red:0.31, green:0.36, blue:0.46, alpha:1.0);
        loginInfoErrorLabel.hidden = true
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
