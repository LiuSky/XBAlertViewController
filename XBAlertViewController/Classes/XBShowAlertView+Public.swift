//
//  XBShowAlertView+Public.swift
//  XBAlertViewController
//
//  Created by LiuSky on 03/19/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit
import Foundation


// MARK: - public func
extension XBShowAlertView {
    
    /// 显示视图
    ///
    /// - Parameter inView: 显示在那个view上面(如果为nil就显示在window上面)
    public func show(inView: UIView? = nil) {
        
        var showInView: UIView!
        if let temView = inView {
            showInView = temView
        } else {
            
            let currentWindows = UIApplication.shared.windows
            guard let window = currentWindows.first,
                let temView = window.rootViewController?.view else {
                    fatalError("当前主窗口不能为nil")
            }
            showInView = temView
        }
        
        delegate?.actionSheetWillShow(self)
        
        if self.superview == nil {
            showInView.addSubview(self)
        }
        
        let isShow = true
        switch alertStyle {
        case let .actionSheet(directionType):
            animationDirection(directionType, isShow: isShow)
        case let .alert(animateType):
            alertAnimateType(animateType, isShow: isShow)
        }
    }
    
    /// 隐藏
    public func dismiss() {
        
        guard self.superview != nil else {
            return
        }
        
        delegate?.actionSheetWillDismiss(self)
        
        let isShow = false
        switch alertStyle {
        case let .actionSheet(directionType):
            animationDirection(directionType, isShow: isShow)
        case let .alert(animateType):
            alertAnimateType(animateType, isShow: isShow)
        }
    }

    @discardableResult
    ///  显示弹窗视图(默认显示在window)
    /// - Parameters:
    ///   - alertStyle: 弹出风格
    ///   - windowLevel: 窗口等级
    ///   - showInView: 显示在那个视图
    ///   - contentView: 内容视图
    ///   - backgroundGestureRecognizer: 点击背景自定义手势事件
    ///   - backgoundTapDismissEnable: 点击背景是否隐藏
    ///   - isShowMask: 是否遮照
    ///   - backgroundViewColor: 背景颜色
    ///   - alertViewEdging: 弹出视图边距
    ///   - alertViewOriginY: 根据Y轴中心点设置偏移量
    ///   - delegate: 委托
    /// - Returns: <#description#>
    public static func showAlertView(alertStyle: XBAlertStyle = .alert(animateType: .direction(type: .top)),
                                     windowLevel: UIWindow.Level = .normal,
                                     showInView: UIView? = nil,
                                     contentView: UIView,
                                     backgroundGestureRecognizer: UIGestureRecognizer? = nil,
                                     backgoundTapDismissEnable: Bool = true,
                                     isShowMask: Bool = true,
                                     backgroundViewColor: UIColor? = nil,
                                     alertViewEdging: CGFloat = 0,
                                     alertViewOriginY: CGFloat = 0,
                                     delegate: XBShowAlertViewDelegate? = nil) -> XBShowAlertView {
        let showView = XBShowAlertView(contentView: contentView)
        showView.layer.zPosition = windowLevel.rawValue
        if let temBackgroundGestureRecognizer = backgroundGestureRecognizer {
            showView.backgroundView.addGestureRecognizer(temBackgroundGestureRecognizer)
        }
        showView.backgoundTapDismissEnable = backgoundTapDismissEnable
        showView.delegate = delegate
        showView.alertStyle = alertStyle
        showView.alertViewOriginY = alertViewOriginY
        showView.alertViewEdging = alertViewEdging
        showView.backgroundViewColor = backgroundViewColor ?? UIColor.black.withAlphaComponent(0.25)
        showView.isShowMask = isShowMask
        showView.show(inView: showInView)
        return showView
    }
}
