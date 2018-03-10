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

public enum CalloutViewShowingAnimationType {
	case fromTop, fromBottom, fromLeft, fromRight
}

public enum CalloutViewHidingAnimationType {
	case toTop, toBottom, toLeft, toRight
}

open class MapViewPlusAnimator {
	
	public var showingAnimationDuration: TimeInterval = 0.8
	public var hidingAnimationDuration: TimeInterval = 0.15
	
	public var animationValue: CGFloat = 30
	
	public fileprivate(set) var defaultShowingAnimationType: CalloutViewShowingAnimationType = .fromBottom
	public fileprivate(set) var defaultHidingAnimationType: CalloutViewHidingAnimationType = .toBottom
	
	public func show(_ calloutView: UIView, andAnchorView anchorView: UIView, combinedView: CalloutAndAnchorView, withType animationType: CalloutViewShowingAnimationType, completion: (() -> ())? = nil) {
		
		calloutView.alpha = 0
		anchorView.alpha = 0
		
		let calloutFrameBeforeAnimation = calloutView.frame
		let anchorFrameBeforeAnimayion = anchorView.frame
		
		let addValueToY : CGFloat = animationType == .fromBottom ? animationValue : (animationType == .fromTop ? -animationValue : (0))
		let addValueToX : CGFloat = animationType == .fromRight ? animationValue : (animationType == .fromLeft ? -animationValue : (0))
		
		if animationType == .fromBottom || animationType == .fromTop {
			let transform = CGAffineTransform(scaleX: 0.4, y: 1.4)
			combinedView.transform = transform
		}else {
			let transform = CGAffineTransform(scaleX: 1.4, y: 0.4)
			combinedView.transform = transform
		}
		
		DispatchQueue.main.async {
			calloutView.frame.origin = CGPoint(x: calloutView.frame.origin.x + addValueToX, y: calloutView.frame.origin.y + addValueToY)
			anchorView.frame.origin = CGPoint(x: anchorView.frame.origin.x + addValueToX, y: anchorView.frame.origin.y + addValueToY)
			
			UIView.animate(withDuration: self.showingAnimationDuration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
				
				calloutView.alpha = 1
				anchorView.alpha = 1
				
				calloutView.frame = calloutFrameBeforeAnimation
				anchorView.frame = anchorFrameBeforeAnimayion
				
				combinedView.transform = .identity
				
			}, completion: { completed in
				guard completed else { return }
				completion?()
			})
		}
	}
	
	public func hide(_ combinedView: UIView, withAnimationType animationType: CalloutViewHidingAnimationType, completion: (() -> ())? = nil) {
		
		let addValueToY : CGFloat = animationType == .toBottom ? animationValue : (animationType == .toTop ? -animationValue : (0))
		let addValueToX : CGFloat = animationType == .toRight ? animationValue : (animationType == .toLeft ? -animationValue : (0))
		
		DispatchQueue.main.async {
	
			UIView.animate(withDuration: self.hidingAnimationDuration, animations: {
				
				combinedView.alpha = 0
				
				combinedView.frame.origin = CGPoint(x: combinedView.frame.origin.x + addValueToX, y: combinedView.frame.origin.y + addValueToY)
				
				if animationType == .toTop || animationType == .toBottom {
					combinedView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
				}else {
					combinedView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
				}
				
			}, completion: { completed in
				
				guard completed else { return }
				combinedView.removeFromSuperview()
				completion?()
			})
		}
	}
}

