//
//  ViewController.swift
//  XBAlertViewController
//
//  Created by LiuSky on 03/19/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit
import XBAlertViewController


/// MARK - ViewController
final class ViewController: UIViewController {

    /// 演示列表
    private lazy var tableView: UITableView = {
        let temTableView = UITableView()
        temTableView.backgroundColor = UIColor.white
        temTableView.separatorInset = .zero
        temTableView.rowHeight = 50
        temTableView.delegate = self
        temTableView.dataSource = self
        temTableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing:UITableViewCell.self))
        return temTableView
    }()
    
    private var alertView: XBShowAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        configView()
        configLocation()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "隐藏", style: UIBarButtonItem.Style.done, target: self, action: #selector(eventForDis))
    }
    
    
    /// 配置视图
    private func configView() {
        view.addSubview(tableView)
    }
    
    /// 配置位置
    private func configLocation() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func eventForDis() {
        self.alertView?.dismiss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return XBAlertStyle.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        cell?.textLabel?.text = XBAlertStyle.allCases[indexPath.row].description
        return cell!
    }
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let type = XBAlertStyle.allCases[indexPath.row]
        
        let autolatoutView = XBAutoLayoutView()
        alertView = XBShowAlertView.showAlertView(alertStyle: type,
                                      showInView: self.view,
                                      contentView: autolatoutView,
                                      backgoundTapDismissEnable: false,
                                      isShowMask: true,
                                      alertViewEdging: 20,
                                      alertViewOriginY: 10, delegate: self)
    }
}



// MARK: - XBShowAlertViewDelegate
extension ViewController: XBShowAlertViewDelegate {
    
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


