//
//  LCWaveView.swift
//  sinaDemo
//
//  Created by admin on 17/4/21.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCWaveView: UIView {

    //角速度
    var waveFrequency: CGFloat = 1.5
    //速度
    var waveSpeed: CGFloat = 0.6
    //高度
    var waveHeight: CGFloat = 5
    //真实图层
    fileprivate var realWaveLayer: CAShapeLayer = CAShapeLayer()
    //蒙版图层
    fileprivate var maskWaveLayer: CAShapeLayer = CAShapeLayer()
    //浮动view
    var overView: UIView?
    //时间
    fileprivate var timer: CADisplayLink?
    //真实图层颜色
    var realWaveColor: UIColor = UIColor.orange {
        didSet {
            realWaveLayer.fillColor = realWaveColor.cgColor
        }
    }
    //蒙版图层颜色
    var maskWaveColor: UIColor = .orange {
        didSet {
            maskWaveLayer.fillColor = maskWaveColor.cgColor
        }
    }
    //偏距
    fileprivate var offset: CGFloat = 0
    
    fileprivate var priFrequency: CGFloat = 0
    fileprivate var priWaveSpeed: CGFloat = 0
    fileprivate var priWaveHeight: CGFloat = 0
    fileprivate var isStarting: Bool = false
    fileprivate var isStopping: Bool = false
    
    //init View
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var f = self.bounds
        f.origin.y = frame.size.height
        f.size.height = 0
        maskWaveLayer.frame = f
        realWaveLayer.frame = f
        self.backgroundColor = .clear
        
        self.layer.addSublayer(realWaveLayer)
        self.layer.addSublayer(maskWaveLayer)
        
    }
    //convenience init
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        
        realWaveColor = color
        maskWaveColor = color.withAlphaComponent(0.5)
        
        realWaveLayer.fillColor = realWaveColor.cgColor
        maskWaveLayer.fillColor = maskWaveColor.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //添加漂浮view
    func addOverView(oView: UIView) -> Void {
        overView = oView
        overView?.center = self.center
        overView?.frame.origin.y = self.frame.height - (overView?.frame.height)!
        self.addSubview(overView!)
    }
    
    //开始浮动
    func startWave() -> Void {
        if !isStarting {
            stop()
            isStarting = true
            isStopping = false
            priWaveHeight = 0
            priFrequency = 0
            priWaveSpeed = 0
            
            timer = CADisplayLink(target: self, selector: #selector(waveEvent))
            timer?.add(to: .current, forMode: .commonModes)
        }
    }
    
    //停止浮动
    
    func stop() -> Void {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    
    func stopWave() -> Void {
        
        if !isStopping {
            isStarting = false
            isStopping = true
        }
    }
    
    //浮动事件
    func waveEvent() -> Void {
        
        if isStarting {
            if priWaveHeight < waveHeight {
                priWaveHeight = priWaveHeight + waveHeight/100.0
                var f = self.bounds
                f.origin.y = f.size.height - priWaveHeight
                f.size.height = priWaveHeight
                maskWaveLayer.frame = f
                realWaveLayer.frame = f
                priFrequency = priFrequency + waveFrequency/100.0
                priWaveSpeed = priWaveSpeed + waveSpeed/100.0
            } else {
                isStarting = false
            }
        }
        
        if isStopping {
            if priWaveHeight > 0 {
                priWaveHeight = priWaveHeight - waveHeight / 50.0
                var f = self.bounds
                f.origin.y = f.size.height
                f.size.height = priWaveHeight
                maskWaveLayer.frame = f
                realWaveLayer.frame = f
                priFrequency = priFrequency - waveFrequency / 50.0
                priWaveSpeed = priWaveSpeed - waveSpeed / 50.0
            } else {
                isStopping = false
                stopWave()
            }
        }
        // 基本波动的速度
        offset += priWaveSpeed
        
        let width = frame.width
        let height = CGFloat(priWaveHeight)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height))
        var y: CGFloat = 0
        
        let maskPath = CGMutablePath()
        maskPath.move(to: CGPoint(x: 0, y: height))
        
        let offset_f = Float(offset * 0.045)
        let waveFrequency_f = Float(0.01 * priFrequency)
        
        for x in 0...Int(width) {
            y = height * CGFloat(sinf(waveFrequency_f * Float(x) + offset_f))
            path.addLine(to: CGPoint(x: CGFloat(x), y: y))
            maskPath.addLine(to: CGPoint(x: CGFloat(x), y: -y))
        }
        if overView != nil {
            let centX = self.bounds.size.width/2
            let centY = height * CGFloat(sinf(waveFrequency_f * Float(centX) + offset_f))
            let center = CGPoint(x: centX , y: centY + self.bounds.size.height - overView!.bounds.size.height/2 - priWaveHeight - 1 )
            overView?.center = center
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        
        path.closeSubpath()
        self.realWaveLayer.path = path
        
        maskPath.addLine(to: CGPoint(x: width, y: height))
        maskPath.addLine(to: CGPoint(x: 0, y: height))
        
        maskPath.closeSubpath()
        self.maskWaveLayer.path = maskPath
    }
}
