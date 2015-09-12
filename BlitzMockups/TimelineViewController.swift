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

public struct Comment{
    var name = String()
    var text = String()
}

public struct Post{
    var name = String()
    var avatar = String()
    var image = String?()
    var text = String?()
    var expandedLink = String?()
    var points = Int()
    var comments = [Comment?()]
    var date = NSDate()
}

func roundInterval(interval: Int)-> String {
    let val = "Just now";
    
    if interval == 0{
      return val;
    }
    
    let second = 1;
    let minute = second*60;
    let hour = minute*60;
    let day = hour*24;
    var num = abs(interval);
    
    var unit = "day";
    
    if num >= day {
        num /= day;
        if (num > 1){
            unit = "d";
        }
    } else if num >= hour {
        num /= hour;
        unit = (num > 1) ? "h" : "h";
    } else if (num >= minute) {
        num /= minute;
        unit = (num > 1) ? "m" : "m";
    } else if (num >= second) {
        num /= second;
        unit = (num > 1) ? "s" : "s";
        
    }
    
    return "\(num)\(unit)"
}

class TimelineViewController: UIViewController{
    
    var lastElement: UIView? = nil
    let scrollView = UIScrollView()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        self.view.addSubview(scrollView)
        scrollView.snp_makeConstraints{ make in
            make.edges.equalTo(self.view)
        }
        
        let logo = UIImageView(image: UIImage(named: "blitzsmall"))
        logo.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        self.view.backgroundColor = lightColor
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        logo.layer.magnificationFilter = kCAFilterNearest;
        self.navigationItem.titleView = logo
        
        /* Fake Calendar Data */
        let calendar = NSCalendar.currentCalendar()
        let components = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: NSDate())
        components.day = 1
        let first = calendar.dateFromComponents(components)

        /*Fake Post*/
        let post = Post(name: "SGehly", avatar: "safeppic", image: "safepic", text: "The red fox jumps over the brown fence and runs through the field and does more stuff. Lets get this to a third line.", expandedLink: nil, points: 9, comments: [], date: first!)
        let post3 = Post(name: "SGehly", avatar: "safeppic", image: "safepic2", text: "Mike best fox thing #TwoKinds", expandedLink: nil, points: -2, comments: [], date: first!)
        generateTimelineElement(post)
        generateTimelineElement(post3)
    }

    func generateTimelineElement(post: Post){
        
        let avatarSize = CGFloat(40)
        
        
        let element = UIView()
        element.backgroundColor = UIColor.whiteColor()
        element.layer.cornerRadius = 3
        element.layer.masksToBounds = true
        element.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).CGColor
        element.layer.shadowOffset = CGSize(width: 5,height: 5)
        scrollView.addSubview(element)

        let avatar = UIImageView(image: UIImage(named: post.avatar))
        avatar.layer.cornerRadius = avatarSize/2
        avatar.layer.masksToBounds = true
        element.addSubview(avatar)
        avatar.snp_makeConstraints{ make in
            make.size.equalTo(avatarSize)
            make.top.equalTo(element).offset(5)
            make.left.equalTo(element).offset(5)
        }
        
        let label = UILabel()
        label.text = post.name
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor.darkGrayColor()
        element.addSubview(label)
        label.snp_makeConstraints{ make in
            make.left.equalTo(avatar.snp_right).offset(5)
            make.top.equalTo(avatar).offset(5)
        }
        
        let time = UILabel()
        time.text = "\(roundInterval(Int(post.date.timeIntervalSinceNow))) • "
        time.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        time.textColor = UIColor.lightGrayColor()
        element.addSubview(time)
        time.snp_makeConstraints{ make in
            make.left.equalTo(avatar.snp_right).offset(5)
            make.bottom.equalTo(avatar).offset(-1)
        }
        
        let points = UILabel()
        points.text = "\(post.points)Ƥ"
        points.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        
        if post.points > 0{
            points.textColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1.0)
        }
        else if post.points == 0{
            points.textColor = UIColor.darkGrayColor()
        }
        else{
            points.textColor = UIColor(red: 192/255, green: 57/255, blue: 43/255, alpha: 1.0)
        }
        
        element.addSubview(points)
        points.snp_makeConstraints{ make in
            make.left.equalTo(time.snp_right)
            make.centerY.equalTo(time)
        }
        
        
        let content = UIView()
        
        if post.image != nil{
            content.backgroundColor = UIColor.blackColor()
            let iV = UIImageView(image: UIImage(named: post.image!))
            iV.contentMode = .ScaleAspectFit
            content.addSubview(iV)
            iV.snp_makeConstraints{ make in
                make.edges.equalTo(content)
            }
        }
        
        element.addSubview(content)
        content.snp_makeConstraints{ make in
            make.top.equalTo(avatar.snp_bottom).offset(5)
            make.width.equalTo(element)
            make.center.equalTo(element)
            make.height.equalTo(250)
        }
        
        
        let battleImg = UIImageView(image: UIImage(named: "timeline")?.imageWithRenderingMode(.AlwaysTemplate))
        battleImg.tintColor = UIColor.darkGrayColor()
        element.addSubview(battleImg)
        battleImg.snp_makeConstraints{ make in
            make.right.equalTo(element).offset(-5)
            make.centerY.equalTo(avatar)
        }
        
        let textFinal = NSMutableAttributedString()
        let name = NSAttributedString(string: "\(post.name): ", attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 14)!])
        textFinal.appendAttributedString(name)
        let textContent = NSAttributedString(string: "\(post.text!)", attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14)!])
        textFinal.appendAttributedString(textContent)
        
        let text = UILabel()
        text.attributedText = textFinal
        text.textColor = UIColor.darkGrayColor()
        text.numberOfLines = 0
        text.lineBreakMode = .ByWordWrapping
        element.addSubview(text)
        text.snp_makeConstraints{ make in
            make.left.equalTo(element).offset(10)
            make.right.equalTo(element).offset(-10)
            make.top.equalTo(content.snp_bottom).offset(10)
        }

        element.snp_makeConstraints{ make in
            if self.lastElement != nil{
                make.top.equalTo(self.lastElement!.snp_bottom).offset(10)
            }else{
                make.top.equalTo(self.view).offset(20)
            }
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view.frame.width-40)
            make.bottom.equalTo(text)
        }
        self.lastElement = element

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}