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

final class DefaultCalloutViewThemeManager {
    public static func getBackgroundColor(of theme: DefaultCalloutViewTheme) -> UIColor {
        return theme == .light ? UIColor.white : UIColor.darkGray
    }
    
    public static func getItemColor(of theme: DefaultCalloutViewTheme) -> UIColor {
        return theme == .light ? UIColor.darkGray : UIColor.white
    }
    
    public static func getDetailDisclosureButtonImage(of theme: DefaultCalloutViewTheme) -> UIImage {
        return theme == .light ? ImagesHelper.detailDisclosureDark : ImagesHelper.detailDisclosureLight
    }
    
    public static func getInfoButtonImage(of theme: DefaultCalloutViewTheme) -> UIImage {
        return theme == .light ? ImagesHelper.infoDark : ImagesHelper.infoLight
    }
    
    public static func getPlaceholderImage(of theme: DefaultCalloutViewTheme) -> UIImage {
        return theme == .light ? ImagesHelper.placeholderDark : ImagesHelper.placeholderLight
    }
    
    public static func getAnchorFillColor(of theme: DefaultCalloutViewTheme) -> UIColor {
        return theme == .light ? UIColor.white : UIColor.darkGray
    }
    
    public static func getBorderColorForCalloutAndAnchor(of theme: DefaultCalloutViewTheme) -> UIColor {
        return theme == .light ? UIColor.darkGray : UIColor.white
    }
}
