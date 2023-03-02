//
//  ViewController.swift
//  Login
//
//  Created by 정준영 on 2023/02/09.
//

import UIKit

final class LoginViewController: UIViewController{
    
    static let shared = LoginViewController()
    private let loginView = LoginView()
    
    var loginCheck = false
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupAddTarget()
    }

    // 셋팅
    private func setupDelegate() {
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    private func setupAddTarget() {
        loginView.emailTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        loginView.passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        loginView.passwordSecureButton.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped  ), for: .touchUpInside)
    }
    
    
    // MARK: - 비밀번호 가리기 모드 켜고 끄기
    @objc private func passwordSecureModeSetting() {
        // 이미 텍스트필드에 내장되어 있는 기능
        loginView.passwordTextField.isSecureTextEntry.toggle()
    }
    
    // 로그인 버튼 누르면 동작하는 함수
    @objc func loginButtonTapped() {
        // 서버랑 통신해서, 다음 화면으로 넘어가는 내용 구현
        print("다음 화면으로 넘어가기")
        
        guard
            let email = loginView.emailTextField.text, !email.isEmpty, isValidEmail(testStr: email)
        else {
            loginView.emailInfoLabel.textColor = .systemRed
            loginView.emailInfoLabel.shake()
            return
        }
        guard
            let password = loginView.passwordTextField.text, !password.isEmpty,
                isValidPassword(password: password)
        else {
            loginView.passwordInfoLabel.textColor = .systemRed
            loginView.passwordInfoLabel.shake()
            return
        }
        self.loginCheck = true
        dismiss(animated: true)
    }
    
    // 리셋버튼이 눌리면 동작하는 함수
    @objc func resetButtonTapped() {
        //만들기
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        // 실제 띄우기
        self.present(alert, animated: true, completion: nil)
    }
    
    // 앱의 화면을 터치하면 동작하는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}


extension LoginViewController: UITextFieldDelegate {
    // MARK: - 텍스트필드 델리게이트
    //텍스트필드 편집 시작할때의 설정 - 문구가 위로올라가면서 크기 작아지고, 오토레이아웃 업데이트
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == loginView.emailTextField {
            loginView.emailTextFieldView.backgroundColor = #colorLiteral(red: 0.9543645978, green: 0.9543645978, blue: 0.9543645978, alpha: 1)
            loginView.emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            loginView.emailInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == loginView.passwordTextField {
            loginView.passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.9543645978, green: 0.9543645978, blue: 0.9543645978, alpha: 1)
            loginView.passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            loginView.passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.2) {
            self.loginView.stackView.layoutIfNeeded()
        }
    }
    
    
    // 텍스트필드 편집 종료되면 백그라운드 색 변경 (글자가 한개도 입력 안되었을때는 되돌리기)
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == loginView.emailTextField {
            loginView.emailTextFieldView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if loginView.emailTextField.text == "" {
                loginView.emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                loginView.emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == loginView.passwordTextField {
            loginView.passwordTextFieldView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if loginView.passwordTextField.text == "" {
                loginView.passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                loginView.passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.3) {
            self.loginView.stackView.layoutIfNeeded()
        }
    }
    
    // MARK: - 로그인 텍스트필드 검사
    @objc private func textFieldEditingChanged(_ textField: UITextField) {

        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                loginView.loginButton.backgroundColor = .kakaoLightBrown
                loginView.loginButton.isEnabled = false
                return
            }
        }
        //이메일과 비밀번호 텍스트필드 두가지 다 채워져있을 때 로그인 버튼 활성화
        guard
            let email = loginView.emailTextField.text, !email.isEmpty,
            let password = loginView.passwordTextField.text, !password.isEmpty
        else {
            loginView.loginButton.backgroundColor = .kakaoLightBrown
            loginView.loginButton.isEnabled = false
            return
        }
        //기본상태
        loginView.emailInfoLabel.text = "이메일주소 또는 전화번호"
        loginView.passwordInfoLabel.text = "비밀번호"
        loginView.loginButton.backgroundColor = .kakaoBrown
        loginView.loginButton.isEnabled = true
        
        //정규식 합격하면 플레이스홀더 초록색
        if textField == loginView.emailTextField {
            if isValidEmail(testStr: email) {
                loginView.emailInfoLabel.textColor = .systemGreen
                return
            } else {
                loginView.emailInfoLabel.textColor = .kakaoLightBrown
                return
            }
        } else {
            if isValidPassword(password: password) {
                loginView.passwordInfoLabel.textColor = .systemGreen
                return
            } else {
                loginView.passwordInfoLabel.textColor = .kakaoLightBrown
                return
            }
        }
        
    }
    
    
    // 엔터 누르면 일단 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


extension LoginViewController {
    // MARK: - ID,PW 형식 검사 메서드
    
    //이메일 형식 검사, 정규식을 사용
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //비밀번호 형식 검사, 최소6자리, 영문 대소문자 및 숫자가 모두 포함되어 있어야함
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
extension UIView {
    //로그인 오류시 글씨 흔들기
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.08
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))

        self.layer.add(shake, forKey: "position")
    }
}
