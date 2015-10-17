//
//  ViewController.swift
//  BlitzMockups
//
//  Created by Sam Gehly on 9/6/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(size.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, size)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage.imageWithColor(darkColor, size: self.navigationBar.frame)
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationBar.setBackgroundImage(image, forBarMetrics: .Default)
        let igniter = BattleJoinController()
        self.setViewControllers([igniter], animated: false)
        
        
        let bar = UITabBar()
        self.view.addSubview(bar)
        bar.snp_makeConstraints{ make in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        bar.tintColor = UIColor.whiteColor()
        
        let items = [
            generateBarItem("Battle", image: "battle"),
            generateBarItem("Explore", image: "explore"),
            generateBarItem("Leaderboard", image: "top"),
            generateBarItem("Notifications", image: "notifications"),
            generateBarItem("Profile", image: "profile")
        ]
        bar.setItems(items, animated: false)
        bar.backgroundImage = image
    }
    
    func generateBarItem(name: String, image: String)-> UITabBarItem{
        let item = UITabBarItem(title: name, image: UIImage(named: image), tag: 0)
        return item
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
