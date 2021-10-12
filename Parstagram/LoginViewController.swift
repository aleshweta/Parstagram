//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Shweta Ale on 10/5/21.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    var refreshControl: UIRefreshControl!

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    func onRefresh() {
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", for:
                                    UIControl.Event.valueChanged)
        //scrollView.insertSubview(refreshControl, atIndex: 0)

        // Do any additional setup after loading the view.
    }
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    func refresh() {
        run(after: 2) {
           self.refreshControl.endRefreshing()
        }
    }

    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
       
        
        PFUser.logInWithUsername(inBackground: username, password: password     ) {(user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }else{
                print("Error: \(error?.localizedDescription) ")
            }
            
        }
        
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
    
        user.signUpInBackground{
        (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(error?.localizedDescription)")
            }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
