//
//  LoginManager.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/03/02.
//

import Foundation

struct LoginManager {
    //이메일 형식 검사, 정규식을 사용
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //비밀번호 형식 검사, 최소6자리, 영문 대소문자 및 숫자가 모두 포함되어 있어야함
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\\\d)[A-Za-z\\\\d]{6,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
//    let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
//    let success = UIAlertAction(title: "확인", style: .default) { action in
//        print("확인버튼이 눌렸습니다.")
//    }
//    let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
//        print("취소버튼이 눌렸습니다.")
//    }
//    
//    alert.addAction(success)
//    alert.addAction(cancel)
//    
//    // 실제 띄우기
//    self.present(alert, animated: true, completion: nil)
}
