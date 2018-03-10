//
//  MapViewPlus
//
//  Created by Okhan Okbay on 10/03/2018
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 okhanokbay
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

public protocol AnchorViewDesignable: class {
    var startingPoint: CGPoint? { get }
    var firstLineEndPoint: CGPoint? { get }
    var secondLineEndPoint: CGPoint? { get }
}

public final class AnchorView: UIView, AnchorViewDesignable {
    
    fileprivate var fillColor: UIColor = UIColor.white
    
    public var startingPoint: CGPoint?
    public var firstLineEndPoint: CGPoint?
    public var secondLineEndPoint: CGPoint?
    
    public convenience init(frame: CGRect, startingPoint: CGPoint, firstLineEndPoint: CGPoint, secondLineEndPoint: CGPoint) {
        self.init(frame: frame)
        self.startingPoint = startingPoint
        self.firstLineEndPoint = firstLineEndPoint
        self.secondLineEndPoint = secondLineEndPoint
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func draw(_ rect: CGRect) {
        
        guard let startingPoint = startingPoint, let firstLineEndPoint = firstLineEndPoint, let secondLineEndPoint = secondLineEndPoint else { return }
        
        let shapePath = UIBezierPath()
        shapePath.move(to: startingPoint)
        shapePath.addLine(to: firstLineEndPoint)
        shapePath.addLine(to: secondLineEndPoint)
        shapePath.addLine(to: startingPoint)
		
		fillColor.setFill()
		shapePath.fill()
		
		UIColor.clear.setStroke()
		shapePath.lineWidth = 0
		
        shapePath.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath.cgPath
        layer.mask = shapeLayer
    }
}

public class AnchorViewHelper {
    public func getDefaultAnchor(withHeight height: CGFloat, fillColor: UIColor? = nil) -> AnchorView {
        let frameRect = getRectForEquilateralTriangle(relatedToHeight: height)
        let anchor = AnchorView.init(frame: frameRect,
                                     startingPoint: CGPoint.init(x: 0, y: 0),
                                     firstLineEndPoint: CGPoint.init(x: frameRect.width / 2, y: frameRect.height),
                                     secondLineEndPoint: CGPoint.init(x: frameRect.width, y: 0))
        
        if let fillColor = fillColor { anchor.fillColor = fillColor }
        
        return anchor
    }
    
    private func getRectForEquilateralTriangle(relatedToHeight height: CGFloat) -> CGRect {
        let width = CGFloat((height / pow(3, (1/2))) * 2) // makes the triangle an equilateral triangle.
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}
