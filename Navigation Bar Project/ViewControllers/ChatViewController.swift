//
//  chatViewController.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/02/15.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var textFieldViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    //키보드 높이 조절을 위한 컨스턴트
    lazy var textFeildViewHeightConstant = textFieldViewHeight.constant
    
    var chatBoxArray: [ChatBox] = []
    var chatDataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setup()
        setupData()
        keyboartSetup()
        
        
    }
    
    func keyboartSetup() {
        self.tabBarController?.tabBar.isHidden = true
        keyboardSetObserver()
    }
    
    func setup() {
        tableView.dataSource = self
        chatTextField.delegate = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        
    }
    
    func setupData() {
        chatDataManager.chatBoxData()
        chatBoxArray = chatDataManager.getChetData()
    }
    
    
    func keyboardSetObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
    }
    
    
    @objc func keyboardWillShow(_ noti: Notification){
        let notiInfo = noti.userInfo!
        if let keyboardFrame = (notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //animation
            let height = keyboardFrame.height - self.view.safeAreaInsets.bottom
            let animationDuration = notiInfo[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            //키보드 올라오는 애니메이션이랑 동일하게 텍스트뷰 올라가게 만들기.
            UIView.animate(withDuration: animationDuration) {
                self.textFieldViewHeight.constant = self.textFeildViewHeightConstant + height
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ noti: Notification){
        let notiInfo = noti.userInfo!
        if ((notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            //animation
            let animationDuration = notiInfo[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            //키보드 올라오는 애니메이션이랑 동일하게 텍스트뷰 올라가게 만들기.
            UIView.animate(withDuration: animationDuration) {
                self.textFieldViewHeight.constant = self.textFeildViewHeightConstant
                self.view.layoutIfNeeded()
            }
        }
    }
        
    //다른 화면 터치했을 때 키보드 내려가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    deinit {
        // 노티피케이션의 등록 해제 (해제안하면 계속 등록될 수 있음) ⭐️
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    // 텍스트필드의 엔터키가 눌러졌을때 호출 (동작할지 말지 물어보는 것)
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //데이터매니저에 텍스트 추가
            chatDataManager.updateData(text: textField.text)
            let newText = chatDataManager.getLastData()
            chatBoxArray.append(newText)
            textField.text = ""
            tableView.reloadData()
            return true
        }
}

extension ChatViewController: UITableViewDataSource {
    
    // 1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return chatBoxArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1", for: indexPath) as! TableViewCell
        
        cell.textView.text = chatBoxArray[indexPath.row].chatBoxText
        
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1") as! TableViewCell
                cell.textView.text = chatBoxArray[indexPath.row].chatBoxText // or any other data source you have
                
                let size = CGSize(width: cell.textView.frame.width, height: CGFloat.greatestFiniteMagnitude)
                let textHeight = cell.textView.sizeThatFits(size).height
                
                // Add any additional spacing needed for the cell
                let cellHeight = textHeight + 8 // 16 is the padding you want
                
                return cellHeight
    }
}

