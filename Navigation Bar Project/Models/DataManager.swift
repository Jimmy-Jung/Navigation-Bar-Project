//
//  DataManager.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/02/17.
//

import UIKit

class DataManager {
    private var chatBoxArray: [ChatBox] = []
    
    func chatBoxData() {
        chatBoxArray = [
            ChatBox(chatBoxText: "첫 텍스트")
        ]
    }
    
    func getChetData() -> [ChatBox] {
        return chatBoxArray
    }
    
    func updateData(text: String?) {
        let chatBox = ChatBox(chatBoxText: text)
        chatBoxArray.append(chatBox)
    }
    
    func getLastData() -> ChatBox {
        return chatBoxArray[chatBoxArray.endIndex - 1]
    }
}
