//
//  CalloutAndAnchorView.swift
//  MapViewPlus
//
//  Created by Okhan on 25/08/17.
//  Copyright © 2017 okhanokbay. All rights reserved.
//

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
		bringSubview(toFront: calloutAsView)
		
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
