//
//  DataManager.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/02/17.
//

import UIKit

class DataManager {
    static let shared = DataManager()
    
    private var chatBoxArray: [ChatBox] = [ChatBox(chatBoxText: "첫 텍스트", textedTime: "시작 00:00")]
    
    func getChetData() -> [ChatBox] {
        return chatBoxArray
    }
    
    func updateData(text: String?, time: String?) {
        let chatBox = ChatBox(chatBoxText: text, textedTime: time)
        chatBoxArray.append(chatBox)
    }
    
    func getLastData() -> ChatBox {
        return chatBoxArray[chatBoxArray.endIndex - 1]
    }
    private init() {
        print("메모리 할당")
    }
    
    deinit {
        print("메모리 해제")
    }
}
