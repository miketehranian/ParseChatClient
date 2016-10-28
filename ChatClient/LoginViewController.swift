//
//  LoginViewController.swift
//  ChatClient
//
//  Created by Mike Tehranian on 10/27/16.
//  Copyright © 2016 Mike Tehranian. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onTapLogin(_ sender: AnyObject) {
        let user = PFUser()
        user.username = emailTextField.text!
        user.password = passwordTextField.text!
        user.email = emailTextField.text!
        
        
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!)
        { (pfUser:PFUser?, error:Error?) in
            
            if let error = error {
                dump(error)
                
                let alert = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                let alertController = UIAlertController(title: "Log in Error", message: error.localizedDescription, preferredStyle: .alert)
                
                alertController.addAction(alert)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
            self.performSegue(withIdentifier: "chatSegue", sender: nil)
        }
    
}

@IBAction func onTapSignup(_ sender: AnyObject) {
    
    let user = PFUser()
    user.username = emailTextField.text!
    user.password = passwordTextField.text!
    user.email = emailTextField.text!
    
    user.signUpInBackground { (succeeded: Bool, error: Error?) in
        
        if let error = error {
            let alert = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            let alertController = UIAlertController(title: "Sign up Error", message: error.localizedDescription, preferredStyle: .alert)
            
            alertController.addAction(alert)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}



 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

}
 

}
