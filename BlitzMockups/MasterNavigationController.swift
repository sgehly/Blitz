//
//  ViewController.swift
//  BlitzMockups
//
//  Created by Sam Gehly on 9/6/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import UIKit

let darkColor = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1.0)
let lightColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)

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
        let timeline = TimelineViewController()
        self.setViewControllers([timeline], animated: false)
        
        
        let bar = UITabBar()
        self.view.addSubview(bar)
        bar.snp_makeConstraints{ make in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        bar.tintColor = UIColor.whiteColor()
        
        let items = [
            generateBarItem("Timeline", image: "timeline"),
            generateBarItem("Explore", image: "map"),
            generateBarItem("Top Users", image: "leaderboard"),
            generateBarItem("Notifications", image: "notifications"),
            generateBarItem("Profile", image: "viking")
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
