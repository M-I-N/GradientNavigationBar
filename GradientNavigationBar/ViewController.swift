//
//  ViewController.swift
//  GradientNavigationBar
//
//  Created by Nayem BJIT on 6/22/18.
//  Copyright © 2018 BJIT Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarAppearence()
        // Do any additional setup after loading the view, typically from a nib.
        removeNavigationBarBackButtonItemTitle()
    }

    func setNavigationBarAppearence() {
        let colors = [UIColor(red: 30/255, green: 234/255, blue: 191/255, alpha: 1), UIColor(red: 12/255, green: 198/255, blue: 183/255, alpha: 1)]
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension CAGradientLayer {
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 0, y: 1)
    }

    func createGradientImage() -> UIImage? {

        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
}

extension UINavigationBar {
    func setGradientBackground(colors: [UIColor]) {
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y     // this adjustment is important, otherwise the frame is considered without the status bar height which in turns causes the gradient layer to be calculated wrong
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        setBackgroundImage(gradientLayer.createGradientImage(), for: .default)
    }
}

extension UIViewController {
    func removeNavigationBarBackButtonItemTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
}
