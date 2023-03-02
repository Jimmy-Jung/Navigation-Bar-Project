//
//  LoginView.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/03/02.
//

import UIKit

class LoginView: UIView {

    private let textViewHeight: CGFloat = 48
    
    //로고 이미지
    lazy var logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "kakaoLOGO"))
        image.contentMode = .scaleAspectFit
        self.addSubview(image)
        return image
    }()
    
    // MARK: - 이메일 입력하는 텍스트 뷰
    lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailInfoLabel)
        view.addSubview(emailTextField)
        return view
    }()
    
    // "이메일 또는 전화번호" 안내문구
    let emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .kakaoLightBrown
        return label
    }()
    
    // 로그인 - 이메일 입력 필드
    lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .kakaoBrown
        tf.tintColor = .kakaoBrown
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    // MARK: - 비밀번호 입력하는 텍스트 뷰
    lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    // 패스워드텍스트필드의 안내문구
    let passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .kakaoLightBrown
        return label
    }()
    
    // 로그인 - 비밀번호 입력 필드
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .kakaoBrown
        tf.tintColor = .kakaoBrown
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        return tf
    }()

    // 패스워드에 "표시"버튼 비밀번호 가리기 기능
    lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(UIColor.kakaoLightBrown, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return button
    }()
    
    // MARK: - 로그인버튼
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .kakaoLightBrown
        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
//        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.kakaoTextBrown, for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    //회원가입 버튼
    lazy var joinButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .kakaoLightBrown
        button.layer.cornerRadius = 5
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.kakaoTextBrown, for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    // 이메일텍스트필드, 패스워드, 로그인버튼 스택뷰에 배치
    lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton, joinButton])
        stview.spacing = 18
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .fill
        return stview
    }()
    
    
    
    // 비밀번호 재설정 버튼
    lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.setTitleColor(.kakaoBrown, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()

    // MARK: - 이니셜라이저

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .kakaoYellow
        [stackView, passwordResetButton].forEach { self.addSubview($0) }
    }
    
    // MARK: - 오토레이아웃
    // 오토레이아웃 향후 변경을 위한 변수(애니메이션)
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    lazy var logoImageViewCenterXConstraint = logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    
    // 오토레이아웃
    private func setupAutoLayout() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            emailInfoLabelCenterYConstraint,
            
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2),
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            passwordInfoLabelCenterYConstraint,
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -2),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*4 + 36),
            
            logoImageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            logoImageView.widthAnchor.constraint(equalToConstant: textViewHeight*4),
            logoImageViewCenterXConstraint,
            
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwordResetButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)
        ])
    }
}
