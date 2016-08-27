//
//  ShareView.swift
//  Dianbangbang
//
//  Created by 武飞跃 on 16/6/11.
//  Copyright © 2016年 RG. All rights reserved.
//

import UIKit



class ShareView: UIView , UIScrollViewDelegate {

    private var shareContent:String!
    private var shareImage:UIImage!
    private var shareUrl:String!
    private var shareTitle:String!
    private var contentHeight:CGFloat = 220
    
    private var bgView:UIView!
    private var contentView:UIView!
    private var rootVC:UIViewController!
    private var scrollView:UIScrollView!
    private var pageControl:UIPageControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bgView = UIView.init(frame: self.bounds)
        self.bgView.backgroundColor = UIColor.blackColor()
        self.bgView.alpha = 0.0
        self.addSubview(self.bgView)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.bgViewTapped))
        self.bgView.addGestureRecognizer(tapGesture)
        
        self.contentView = UIView.init(frame: CGRectMake(0, CGRectGetHeight(frame), CGRectGetWidth(frame), contentHeight))
        self.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.addSubview(self.contentView)

        let sharePaltformArray = [
            [ "share_weixin", "share_friend", "share_sina" , "share_qq", "share_zone"],
            [ "微信","朋友圈", "微博", "QQ", "QQ空间"]
        ]
        
        self.scrollView = UIScrollView.init(frame: CGRectMake(0, 0, CGRectGetWidth(frame), 130))
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.pagingEnabled = true
        self.scrollView.delegate = self
        self.scrollView.backgroundColor = UIColor.whiteColor()
        self.scrollView.contentOffset = CGPointMake(0, 0)
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame) * CGFloat(self.pageNum(sharePaltformArray[0].count)), 0)
        self.contentView.addSubview(self.scrollView)
        
        
        self.pageControl = UIPageControl.init(frame: CGRectMake(0, CGRectGetHeight(self.scrollView.frame), CGRectGetWidth(frame), 35))
        self.pageControl.backgroundColor = UIColor.whiteColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.grayColor()
        self.pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.pageControl.numberOfPages = pageNum(sharePaltformArray[0].count)
        self.contentView.addSubview(self.pageControl)
        
        
        
        let buttonWidth:CGFloat = 55.0
        let buttonGap = ( CGRectGetWidth(frame) - buttonWidth * 4 ) / 5
        
        for i in 0 ..< 5 {
            
            let shareButton = UIButton(type:.Custom)
        
            let btnRect = CGRectMake(buttonGap * ( CGFloat(i) + 1) + buttonWidth * CGFloat(i) + (i % 4 == 0 && i != 0 ? 20 : 0), 40, buttonWidth, buttonWidth)
            
            shareButton.frame = btnRect
            shareButton.tag = 100 + i
            shareButton.addTarget(self, action: #selector(self.shareButtonClicked(_:)), forControlEvents: .TouchUpInside)
            shareButton.setBackgroundImage(UIImage(named: sharePaltformArray[0][i]), forState: .Normal)
            shareButton.setBackgroundImage(UIImage(named: sharePaltformArray[0][i] + "_hover"), forState: .Highlighted)
            shareButton.layer.cornerRadius = buttonWidth / 2
            shareButton.layer.masksToBounds = true
            self.scrollView.addSubview(shareButton)
            
            let shareLabel = UILabel.init(frame: CGRectMake(CGRectGetMinX(shareButton.frame), CGRectGetMaxY(shareButton.frame) + 10 , CGRectGetWidth(shareButton.frame), 15))
            shareLabel.font = UIFont.systemFontOfSize(13)
            shareLabel.textColor = UIColor.init(red: 0.24, green: 0.24, blue: 0.25, alpha: 1.0)
            shareLabel.textAlignment = .Center
            shareLabel.text = sharePaltformArray[1][i]
            self.scrollView.addSubview(shareLabel)
        }
        
        let cancelBtn = UIButton(type:.Custom)
        cancelBtn.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 44, CGRectGetWidth(self.contentView.frame), 44)
        cancelBtn.backgroundColor = UIColor.whiteColor()
        cancelBtn.setTitle("取消", forState: .Normal)
        cancelBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClicked), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(cancelBtn)
    }
    
    
    func setShareModel(content:String , image:UIImage , url:String , title:String) {
        
        self.shareContent = content
        self.shareImage = image
        self.shareUrl = url
        self.shareTitle = title
        
    }
    
    /**
     遮罩背景响应事件
     */
    func bgViewTapped() {
        
        self.dismiss()
        
    }
    
    /**
     取消按钮响应事件
     */
    func cancelBtnClicked() {
        
        self.dismiss()
        
    }

    /**
     分享按钮响应事件
     */
    func shareButtonClicked(sender:UIButton) {
        
        let snsTypes:Array<AnyObject>!
        var currentShareType:String!
        if sender.tag == 100 {
//            snsTypes = [UMShareToWechatSession]
            currentShareType = "1"
            
//            UMSocialData.defaultData().extConfig.wechatSessionData.title = self.shareTitle
//            UMSocialData.defaultData().extConfig.wechatSessionData.url = self.shareUrl
            
        }else if sender.tag == 100 + 1 {
//            snsTypes = [UMShareToWechatTimeline]
            currentShareType = "0"
            if self.shareTitle != nil && self.shareTitle.characters.count > 0 {
//                UMSocialData.defaultData().extConfig.wechatTimelineData.title = self.shareTitle
                
            }else{
//                UMSocialData.defaultData().extConfig.wechatTimelineData.title = self.shareContent
            }
        }else if sender.tag == 100 + 2 {
//            snsTypes = [UMShareToSina]
            currentShareType = "2"
            
            self.shareContent = self.shareUrl + self.shareContent
            
            guard self.shareTitle.characters.count > 0 else{
//                UMSocialData.defaultData().extConfig.qzoneData.title = "  "
                return
            }
//            UMSocialData.defaultData().extConfig.qzoneData.title = self.shareTitle
//            UMSocialData.defaultData().extConfig.qzoneData.url = self.shareUrl
        }else if sender.tag == 100 + 3 {
//            snsTypes = [UMShareToQQ]
            currentShareType = "4"
            guard self.shareTitle.characters.count > 0 else{
//                UMSocialData.defaultData().extConfig.qqData.title = "  "
                return
            }
//            UMSocialData.defaultData().extConfig.qqData.title = self.shareTitle
//            UMSocialData.defaultData().extConfig.qqData.url = self.shareUrl
        }else if sender.tag == 100 + 4 {
//            snsTypes = [UMShareToQzone]
            currentShareType = "3"
            guard self.shareTitle.characters.count > 0 else{
//                UMSocialData.defaultData().extConfig.qzoneData.title = "  "
                return
            }
//            UMSocialData.defaultData().extConfig.qzoneData.title = self.shareTitle
//            UMSocialData.defaultData().extConfig.qzoneData.url = self.shareUrl
        }else{
            snsTypes = []
            currentShareType = " "
        }
        
        
    }
    
    func showInViewController(viewController:UIViewController){
        self.rootVC = viewController
        self.showInView(viewController.view)
    }
    
    private func dismiss(){
        UIView.animateWithDuration(0.3, animations: { 
                self.bgView.alpha = 0.0
                self.contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), self.contentHeight)
            
            }) { (finished) in
                self.removeFromSuperview()
        }
        
        
    }
    
    private func pageNum(num:Int) -> Int {
        return (num % 4 == 0 ? 0 : 1) + num / 4
    }
    
    private func showInView(parentView:UIView) {
        
        parentView.addSubview(self)
        UIView.animateWithDuration(0.3) {
            self.bgView.alpha = 0.4
            self.contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - self.contentHeight, CGRectGetWidth(self.frame), self.contentHeight)
        }
        
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = CGRectGetWidth(self.bounds)
        let pageFraction = self.scrollView.contentOffset.x / pageWidth
        self.pageControl.currentPage = Int(pageFraction)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
