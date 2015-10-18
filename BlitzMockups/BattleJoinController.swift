//
//  TimelineViewController.swift
//  BlitzMockups
//
//  Created by Sam Gehly on 9/6/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import SnapKit
import AVFoundation
import UIKit

class BattleJoinController: UIViewController{
    
    let width = 50
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        //General Page Settings
        self.navigationController?.navigationBarHidden = true;
        self.view.backgroundColor = darkColor

        //Logo
        let logo = UIImageView(image: UIImage(named: "swordup"))
        logo.image = logo.image?.imageWithRenderingMode(.AlwaysTemplate)
        logo.tintColor = lightColor
        self.view.addSubview(logo)
        logo.snp_makeConstraints{ make in
            make.height.equalTo(125)
            make.width.equalTo(70)
            make.centerX.equalTo(self.view).offset(2)
            make.top.equalTo(self.view).offset(50)
        }
        
        let f = UILabel()
        f.text = "BL"
        f.font = UIFont(name: "HelveticaNeue-Bold", size: 64)
        f.textColor = UIColor.whiteColor()
        self.view.addSubview(f)
        f.snp_makeConstraints{ make in
            make.right.equalTo(logo.snp_left).offset(-10)
            make.top.equalTo(logo)
            make.height.equalTo(logo)
        }
        let l = UILabel()
        l.text = "TZ"
        l.font = UIFont(name: "HelveticaNeue-Bold", size: 64)
        l.textColor = UIColor.whiteColor()
        self.view.addSubview(l)
        l.snp_makeConstraints{ make in
            make.left.equalTo(logo.snp_right)
            make.top.equalTo(logo)
            make.height.equalTo(logo)
        }
        
        let offset = Int(self.view.frame.height/4-130)

        //Random Button
        let randomButton = generateButton("Tournament", subtitle: "Play for points!", color: blueButtonColor, reference: logo, offset: offset)
        
        
        let joinButton = generateButton("Join Room", subtitle: "Join your friends!", color: greenButtonColor, reference: randomButton, offset: offset)
        
        let createButton = generateButton("Create Room", subtitle: "Host your friends!", color: redButtonColor, reference: joinButton, offset: offset)
        
        let practiceButton = generateButton("Practice Games", subtitle: "Practice your skills!", color: purpleButtonColor, reference: createButton, offset: offset)
        
    }
    
    func generateButton(title: String, subtitle: String, color: UIColor, reference: UIView, offset: Int?) -> UIButton{
        var sl: UIView? = nil
        let button = UIButton(type: .Custom)
        button.backgroundColor = color
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        
        let buttonLabel = UILabel()
        buttonLabel.text = title
        buttonLabel.textAlignment = .Center
        buttonLabel.textColor = UIColor.whiteColor()
        buttonLabel.font = UIFont(name: "HelveticaNeue", size: 26)
        button.addSubview(buttonLabel)
        buttonLabel.snp_makeConstraints{ make in
            make.top.equalTo(button).inset(10)
            make.width.equalTo(button)
            make.centerX.equalTo(button)
        }
        
        let buttonSublabel = UILabel()
        buttonSublabel.text = subtitle
        buttonSublabel.textAlignment = .Center
        buttonSublabel.textColor = UIColor.whiteColor()
        buttonSublabel.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        button.addSubview(buttonSublabel)
        buttonSublabel.snp_makeConstraints{ make in
            make.top.equalTo(buttonLabel.snp_bottom)
            make.width.equalTo(button)
            make.centerX.equalTo(button)
        }

        self.view.addSubview(button)
        button.snp_makeConstraints{ make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(reference.snp_bottom).offset(offset!)
            make.width.equalTo(self.view).offset(-width)
            make.bottom.equalTo(buttonSublabel).offset(10)
        }
        return button
    }
    
}