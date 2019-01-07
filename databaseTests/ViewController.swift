//
//  ViewController.swift
//  databaseTests
//
//  Created by Dakota Brown on 1/5/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var firstNamelastNameLabel: UILabel!
    @IBOutlet weak var favoriteFoodLabel: UILabel!
    @IBOutlet weak var random1Label: UILabel!
    @IBOutlet weak var random2Label: UILabel!
    
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle = 0
    var userNumber: Int = 0
    var counter: Int = 0
    
    class User {
        var userNumber: Int
        var username: String
        var firstLast: String
        var favoriteFood: String
        var randomOne: String
        var randomTwo: String
        
        init (userNumber: Int, username: String, firstLast: String, favoriteFood: String, randomOne: String, randomTwo: String) {
            self.userNumber = userNumber
            self.username = username
            self.firstLast = firstLast
            self.favoriteFood = favoriteFood
            self.randomOne = randomOne
            self.randomTwo = randomTwo
        }
    }
    
    func userData() {
        ref?.child("users").child(String(userNumber)).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let favoriteFoodSnap = value?["Favorite food"] as? String ?? ""
            let nameSnap = value?["Name"] as? String ?? ""
            let rand1Snap = value?["Something random 1"] as? String ?? ""
            let rand2Snap = value?["Something random 2"] as? String ?? ""
            let usernameSnap = value?["Username"] as? String ?? ""
            self.favoriteFoodLabel.text = ("Favorite food: \(favoriteFoodSnap)")
            self.usernameLabel.text = ("Username: \(usernameSnap)")
            self.firstNamelastNameLabel.text = ("Full name: \(nameSnap)")
            self.random1Label.text = ("Random one: \(rand1Snap)")
            self.random2Label.text = ("Random two: \(rand2Snap)")
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let rand = Int(arc4random_uniform(17))
        userNumber = 7
        ref = Database.database().reference()
        userData()
    }
    
    @IBAction func changeTextButton(_ sender: Any) {
        /*let rand = Int(arc4random_uniform(17))
        userNumber = rand
        print(userNumber)
        userData()*/
        
    }
}
