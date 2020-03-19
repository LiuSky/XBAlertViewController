//
//  XBAutoLayoutView.swift
//  XBAlertViewController_Example
//
//  Created by xiaobin liu on 2020/3/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import XBAlertViewController


/// MARK - XBAutoLayoutView
final class XBAutoLayoutView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let temLabel = UILabel()
        temLabel.text = "文本"
        temLabel.backgroundColor = UIColor.red
        temLabel.textColor = UIColor.white
        temLabel.textAlignment = .center
        return temLabel
    }()
    
    
    /// 安全区域距离底部
    private lazy var safeAreaInsetsBottom: CGFloat = {
        
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        configView()
        configLocation()
    }
    
    private func configView() {
        addSubview(titleLabel)
    }
    
    private func configLocation() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -safeAreaInsetsBottom).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - XBShowAlertViewDelegate
extension XBAutoLayoutView: XBShowAlertViewDelegate {
    
    func actionSheetWillShow(_ sheet: XBShowAlertView) {
        print("actionSheetWillShow")
    }
    
    func actionSheetDidShow(_ sheet: XBShowAlertView) {
        print("actionSheetDidShow")
    }
    
    func actionSheetWillDismiss(_ sheet: XBShowAlertView) {
        print("actionSheetWillDismiss")
    }
}
