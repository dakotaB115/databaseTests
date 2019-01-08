//
//  AddDataViewController.swift
//  databaseTests
//
//  Created by Dakota Brown on 1/7/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class AddDataViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var firstNameLastNameTextField: UITextField!
    @IBOutlet weak var favoriteFoodTextField: UITextField!
    @IBOutlet weak var randomOneTextField: UITextField!
    @IBOutlet weak var randomTwoTextField: UITextField!
    
    var ref: DatabaseReference!
    var newUser: Int = 0
    func saveData() {
        
    }
    
    func displayError(title: String, message: String) {
        let title = title
        let message = message
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("users").observe(.value) { (snapshot: DataSnapshot!) in
            self.newUser = Int(snapshot.childrenCount)
        }
    }
    
    @IBAction func addDataButton(_ sender: Any) {
        
        guard let username = UsernameTextField.text, !username.isEmpty else {
            displayError(title: "Missing username", message: "Please enter a username.")
            return
        }
        
        guard let name = firstNameLastNameTextField.text, !name.isEmpty else {
            displayError(title: "Missing username", message: "Please enter a username.")
            return
        }
        
        guard let favFood = favoriteFoodTextField.text, !favFood.isEmpty else {
            displayError(title: "Missing username", message: "Please enter a username.")
            return
        }
        
        guard let randOne = randomOneTextField.text, !randOne.isEmpty else {
            displayError(title: "Missing username", message: "Please enter a username.")
            return
        }
        
        guard let randTwo = randomTwoTextField.text, !randTwo.isEmpty else {
            displayError(title: "Missing username", message: "Please enter a username.")
            return
        }
        
        ref?.child("users").child(String(newUser)).child("Favorite food").setValue(favFood)
        ref?.child("users").child(String(newUser)).child("Name").setValue(name)
        ref?.child("users").child(String(newUser)).child("Something random 1").setValue(randOne)
        ref?.child("users").child(String(newUser)).child("Something random 2").setValue(randTwo)
        ref?.child("users").child(String(newUser)).child("Username").setValue(username)
        
        ref.child("users").observe(.value) { (snapshot: DataSnapshot!) in
            self.newUser = Int(snapshot.childrenCount)
        }
        print(newUser)
        UsernameTextField.text = ""
        firstNameLastNameTextField.text = ""
        favoriteFoodTextField.text = ""
        randomOneTextField.text = ""
        randomTwoTextField.text = ""
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToUserData", sender: self)
    }
}
