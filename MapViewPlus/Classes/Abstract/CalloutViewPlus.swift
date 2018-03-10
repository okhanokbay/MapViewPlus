//
//  CalloutViewConfig.swift
//  MapViewPlus
//
//  Created by Okhan on 18/08/17.
//  Copyright © 2017 okhanokbay. All rights reserved.
//

import UIKit

public enum CalloutViewPlusBound {
    case defaultBounds
    case customBounds(CGRect)
}

public enum CalloutViewPlusCenter {
    case defaultCenter
    case customCenter(CGPoint)
}

//All the callout view types conform to this protocol
public protocol CalloutViewModel{}

public protocol CalloutViewPlus: class {
    func configureCallout(_ viewModel: CalloutViewModel)
}
