//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Prathamesh Talathi on 04/07/16.
//  Copyright © 2016 Prathamesh Talathi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let storedUsername = "qwerty";
    let storedPassword = "qwerty";
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonTapped(sender: AnyObject) {
        
        let username = usernameTextField.text;
        let password = passwordTextField.text;
        
        var errorMessage = "";
        var isError = false;
        
        if(isEmptyFields(username!, password: password!)){
            isError = true;
            errorMessage = "Fields cannot be empty";
        } else if(!isValidUserName(username!) || !isCorrectUserName(username!)){ // Wrong username
            if(!isValidUserName(username!)){
                errorMessage = "Minimum 6 charaters required";
            } else if(!isCorrectPassword(password!)){ // Wrong password
                errorMessage = "Wrong Username & Password";
            } else {
                errorMessage = "Wrong Username"
            }
            isError = true;
        } else if(!isCorrectPassword(password!)){ // Wrong password
            errorMessage = "Wrong Password";
            isError = true;
        } else {  // Login is successful
            saveCredentialsAndOpenWelcomeScreen();
            isError = false;
        }
        
        if(isError){
            showMessageAlertDialog(errorMessage)
        }
        
    }
    
    func isEmptyFields(username: String, password: String) -> Bool {
        return username.characters.count == 0 || password.characters.count == 0;
    }
    
    func isValidUserName(username: String) -> Bool {
        return username.characters.count >= 6;
    }
    
    func isCorrectUserName(username: String) -> Bool {
        return username == storedUsername;
    }
    
    func isCorrectPassword(password: String) -> Bool {
        return password == storedPassword;
    }
    
    func saveCredentialsAndOpenWelcomeScreen(){
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        self.performSegueWithIdentifier("welcomeView", sender: self)
    }
    
    func showMessageAlertDialog(errorMessage: String){
        let alertController = UIAlertController(title: "Login", message:
            errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
