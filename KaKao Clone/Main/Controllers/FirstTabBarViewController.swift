//
//  UITabbarViewController.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/02/23.
//

import UIKit

class FirstTabBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // 다음화면을 띄우는 더 정확한 시점 ⭐️⭐️⭐️
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ⭐️ 로그인화면 띄우기
        let vc = LoginViewController()
        if DataManager.loginCheck == false {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
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
