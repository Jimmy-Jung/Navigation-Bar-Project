//
//  chatViewController.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/02/15.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var BGBGViewButtom: NSLayoutConstraint!
    @IBOutlet weak var sendBtn: UIButton!
    
    var chatBoxArray: [ChatBox] = []
    var chatDataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableViewSetup()
        textViewSetup()
        setupData()
        keyboartSetup()
        hideKeyboard()
    }
    
    @IBAction func sendBtnTapped(_ sender: UIButton) {
        
        if let messageBody = chatTextView.text, chatTextView.text != "",
           let messageSender = Auth.auth().currentUser?.email {
            let timestamp = Date().timeIntervalSince1970
            db.collection(K.Fstore.collectionName).addDocument(data:[
                K.Fstore.sender : messageSender,
                K.Fstore.massage : messageBody,
                K.Fstore.date: timestamp
            ]) { error in
                if let e = error {
                    print(e)
                } else {
                    print("성공적으로 메세지를 보냈습니다.")
                }
            }
            chatTextView.text = ""
            realTimeLoadMessage()
        }
    }
    
    //실시간 채팅 기능
    func realTimeLoadMessage() {
        db.collection(K.Fstore.collectionName)
            .order(by: K.Fstore.date, descending: true)
            .limit(to: 1)
            .addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    guard let snapshotDocument = querySnapshot?.documents.first else {return}
                    let data = snapshotDocument.data()
                    guard let sender = data[K.Fstore.sender] as? String,
                          let message = data[K.Fstore.massage] as? String,
                          let date = data[K.Fstore.date] as? TimeInterval else {return}
                    self.chatDataManager.updateData(sender: sender, message: message, date: date)
                    let newMesaege = self.chatDataManager.getLastData()
                    self.chatBoxArray.append(newMesaege)
                    self.tableView.reloadData()
                }
            }
    }
    
    func keyboartSetup() {
        self.tabBarController?.tabBar.isHidden = true
        keyboardSetObserver()
    }
    
    func textViewSetup() {
        chatTextView.delegate = self
        chatTextView.showsVerticalScrollIndicator = false
        BGView.layer.cornerRadius = 17
        sendBtn.layer.cornerRadius = 14

    }
    
    func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        sendBtn.isHidden = true
        
    }
    
    func setupData() {
        chatBoxArray = chatDataManager.getChetData()
    }
    
    func hideKeyboard()
        {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(ChatViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
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
    
    @objc func dismissKeyboard()
        {
            view.endEditing(true)
        }
    
    @objc func keyboardWillShow(_ noti: Notification){
        let notiInfo = noti.userInfo!
        if let keyboardFrame = (notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //animation
            let height = keyboardFrame.height - self.view.safeAreaInsets.bottom - 8
            let animationDuration = notiInfo[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            //키보드 올라오는 애니메이션이랑 동일하게 텍스트뷰 올라가게 만들기.
            UIView.animate(withDuration: animationDuration) {
                self.BGBGViewButtom.constant = height
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
                self.BGBGViewButtom.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
        
    //다른 화면 터치했을 때 키보드 내려가기
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
    deinit {
        // 노티피케이션의 등록 해제 (해제안하면 계속 등록될 수 있음) ⭐️
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
        
        cell.chatBox = chatBoxArray[indexPath.row]
        
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1") as! TableViewCell
                cell.textView.text = chatBoxArray[indexPath.row].message // or any other data source you have
                
                let size = CGSize(width: cell.textView.frame.width, height: CGFloat.greatestFiniteMagnitude)
                let textHeight = cell.textView.sizeThatFits(size).height
                
                // Add any additional spacing needed for the cell
                let cellHeight = textHeight + 8 // 16 is the padding you want
                
                return cellHeight
    }
    
}

extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
            let size = CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude)
            let expectedSize = textView.sizeThatFits(size)
            messageTextViewHeightConstraint.constant = expectedSize.height
        
            sendBtn.isHidden = chatTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    
    
}
