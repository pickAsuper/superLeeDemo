//
//  UIBarExtension.swift
//  sinaDemo
//
//  Created by admin on 17/4/21.
//  Copyright © 2017年 super. All rights reserved.
//   为了隐藏导航栏的底线

import Foundation
import UIKit

extension UINavigationBar {
    // 隐藏线
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = true
    }
    
    // 显示线
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = false
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) &&  view.bounds.height <= 1.0{
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(view: subview) {
                return imageView
            }
        }
        return nil
    }
}

extension UIToolbar {
    
    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = true
    }
    
    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = false
    }
    
    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) &&  view.bounds.height <= 1.0{
            return (view as! UIImageView)
        }
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(view: subview) {
                return imageView
            }
        }
        return nil
    }
}
