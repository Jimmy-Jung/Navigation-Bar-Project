//
//  ViewController.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/02/14.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    let chatDateManager = DataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func tappedChatBtn(_ sender: UIButton) {
    }
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        DataManager.loginCheck = false
        tabBarController?.selectedIndex = 0
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let vc = segue.destination as? ChatViewController else {return}
//        vc.chatDataManager = self.chatDateManager
//    }
}

