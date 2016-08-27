//
//  ViewController.swift
//  ShareViewTest
//
//  Created by 武飞跃 on 2016/8/27.
//  Copyright © 2016年 RG. All rights reserved.
//

import UIKit

let UMENG_SHARE_TEXT = "点帮帮里程碑"
let UMENG_MILESTONE_SHARE_TEXT = "点帮帮里程碑"
let UMENG_INVITE_SHARE_TEXT = "发现一款好玩的APP,点帮帮，快来下载吧，下载地址是http://bangbang.pointgongyi.com"
let ABOUT_US_URL = "http://bangbang.pointgongyi.com"

//获取屏幕的 高度、宽度
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.createBtn();
        
    }
    func createBtn(){
        let btn             = UIButton(type:.Custom)
        let btn_frame       = CGRectMake(0, 0, 100,44)
        btn.frame           = btn_frame
        btn.center          = self.view.center
        btn.backgroundColor = UIColor.redColor()
        btn.setTitle("点击", forState: .Normal)
        btn.addTarget(self, action: #selector(self.handleBtnAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func handleBtnAction(sender:UIButton ){
        
        //To  Do
        
        let shareView = ShareView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        shareView.setShareModel(UMENG_INVITE_SHARE_TEXT, image: UIImage(named: "share_logo")!, url: ABOUT_US_URL, title: UMENG_SHARE_TEXT)
        
        shareView.showInViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

