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

open class CalloutAndAnchorView: UIView {
    
    var calloutView: CalloutViewPlus?
    var anchorView: AnchorViewDesignable?
	
    public convenience init(frame: CGRect,
                            calloutView: CalloutViewPlus,
                            anchorView: AnchorViewDesignable) {
        
        self.init(frame: frame)
        
        self.calloutView = calloutView
        self.anchorView = anchorView
        
        let calloutAsView = calloutView as! UIView
        let anchorAsView = anchorView as! UIView
        
        calloutAsView.frame.origin.x = 0
        calloutAsView.frame.origin.y = 0
        
        anchorAsView.center = CGPoint(x: frame.width / 2, y: frame.height - (anchorAsView.bounds.size.height / 2) - 1)
		// -1 to avoid a flickering gap between anchorview and calloutview
		
        addSubview(calloutAsView)
        addSubview(anchorAsView)
        bringSubviewToFront(calloutAsView)
		
		backgroundColor = UIColor.clear
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		layer.masksToBounds = false
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
		layer.shadowOpacity = 0.3
	}
}
