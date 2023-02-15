//
//  chatViewController.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/02/15.
//

import UIKit

class chatViewController: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet var textFieldView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        
        chatTextField.delegate = self
        
        // 키보드 올라올 때.
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardup), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 키보드 내려올 때.
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDown), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
    }
    
    @objc func keyBoardup(noti: Notification){
            let notiInfo = noti.userInfo!
            let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        // 홈 버튼 없는 아이폰들은 다 빼줘야함.
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
            
            let animationDuration = notiInfo[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            
            // 키보드 올라오는 애니메이션이랑 동일하게 텍스트뷰 올라가게 만들기.
            UIView.animate(withDuration: animationDuration) {
                self.textFieldView.layer.frame.origin.y += height
                self.view.layoutIfNeeded()
            }
            
        }
        
        @objc func keyBoardDown(noti: Notification){
            
            let notiInfo = noti.userInfo!
            let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            // 홈 버튼 없는 아이폰들은 다 빼줘야함.
            let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
            let animationDuration = notiInfo[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            
            
            UIView.animate(withDuration: animationDuration) {
                self.textFieldView.layer.frame.origin.y -= height
                self.view.layoutIfNeeded()
            }
        }
    
    //다른 화면 터치했을 때 키보드 내려가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
