//
//  ViewController.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/02/14.
//

import UIKit

class ViewController: UIViewController {
    
    let chatDateManager = DataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tappedChatBtn(_ sender: UIButton) {
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let vc = segue.destination as? ChatViewController else {return}
//        vc.chatDataManager = self.chatDateManager
//    }
}

