//
//  CustomInputTextView.swift
//  XBAlertViewController_Example
//
//  Created by xiaobin liu on 2020/6/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - 自定义文本输入
final class CustomInputTextView: UIView {
    
    /// 内容视图
    private lazy var contentView: UIView = {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    /// 输入框
    private lazy var textField: UITextField = {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.backgroundColor = UIColor.black
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        $0.textColor = UIColor.white
        $0.attributedPlaceholder = NSAttributedString(string: "  请输入你的语言", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    /// 确定按钮
    private lazy var confirmButton: UIButton = {
        $0.backgroundColor = UIColor.red
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        $0.setTitle("确定", for: UIControl.State.normal)
        $0.setTitleColor(UIColor.white, for: UIControl.State.normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(eventForConfirm), for: UIControl.Event.touchUpInside)
        return $0
    }(UIButton(type: .custom))
    
    /// 布局
    private var layoutConstraint: NSLayoutConstraint?
    
    /// 初始化
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
        configView()
        configLocation()
        addObserver()
    }
    
    /// 配置视图
    private func configView() {
        addSubview(contentView)
        addSubview(textField)
        addSubview(confirmButton)
    }
    
    /// 配置位置
    private func configLocation() {
        
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        layoutConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 150)
        layoutConstraint?.isActive = true
        
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func eventForConfirm() {
        textField.resignFirstResponder()
    }
    
    public func show() {
        textField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// MARK - keyboard observer
private extension CustomInputTextView {
    
    func addObserver() {
        removeObserver()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidHide(notification:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    private func removeObserver() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardNotification = KeyboardNotification(from: notification) else { return }
        animateAlongside(keyboardNotification) { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.layoutConstraint?.isActive = false
            self.layoutConstraint?.constant = -(keyboardNotification.endFrame.height + 20)
            self.layoutConstraint?.isActive = true
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        guard let keyboardNotification = KeyboardNotification(from: notification) else { return }
        animateAlongside(keyboardNotification) { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = UIColor.clear
            self.layoutConstraint?.isActive = false
            self.layoutConstraint?.constant = 150
            self.layoutConstraint?.isActive = true
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        self.removeFromSuperview()
    }
    
    private func animateAlongside(_ notification: KeyboardNotification, animations: @escaping ()->Void) {
        UIView.animate(withDuration: notification.timeInterval, delay: 0, options: [notification.animationOptions, .allowAnimatedContent, .beginFromCurrentState], animations: animations, completion: nil)
    }
}
