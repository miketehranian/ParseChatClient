//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Mike Tehranian on 10/27/16.
//  Copyright © 2016 Mike Tehranian. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var chatTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refresh()
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ChatViewController.refresh), userInfo: nil, repeats: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCellTableViewCell
        
        let message = messages[indexPath.row]
        if let messageText = message.object(forKey: "text") as? String {
            cell.messageLabel.text = messageText
            
            if let messageUser = message.object(forKey: "user") as? String {
                cell.userLabel.text = messageUser
            }
        }

        return cell
    }
    
    func refresh() {
        
        let query = PFQuery(className:"Message")
        
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                
                self.messages = []
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
//                        if let messageText = object.object(forKey: "text") as? String {
//                            self.messages.append(messageText)
//                        }
                        self.messages.append(object)
                        
                    }
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("MDT ERROR below")
                dump(error)
            }
            
            
        }
        
        
    }
    
    @IBAction func onTapSend(_ sender: UIButton) {
        let message = PFObject(className:"Message")
        message["text"] = chatTextField.text!
        message["user"] = PFUser.current()?.username
        
        message["image"] = PFObject(className: "UserPhoto")
        
        
        message.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                NSLog("Successfully saved the message: \(self.chatTextField.text!)")
            } else {
                NSLog("Error while saving message: \(error?.localizedDescription)")
            }
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
