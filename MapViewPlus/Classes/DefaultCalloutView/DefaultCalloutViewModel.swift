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

import Foundation

public protocol DefaultCalloutViewModelProtocol: CalloutViewModel {
	var title: String { get set }
	var subtitle: String? { get set }
	var imageType: DefaultCalloutViewImageType { get set }
	var theme: DefaultCalloutViewTheme { get set }
	var detailButtonType: DefaultCalloutViewDetailButtonType { get set }
}

public extension DefaultCalloutViewModelProtocol {
	var theme: DefaultCalloutViewTheme {
		return .light
	}
	
	var detailButtonType: DefaultCalloutViewDetailButtonType {
		return .detailDisclosure
	}
}

open class DefaultCalloutViewModel: DefaultCalloutViewModelProtocol {
	public var title: String
	public var subtitle: String?
	public var imageType: DefaultCalloutViewImageType
	public var theme: DefaultCalloutViewTheme
	public var detailButtonType: DefaultCalloutViewDetailButtonType
	
	public init(title: String, subtitle: String? = nil, imageType: DefaultCalloutViewImageType = .none, theme: DefaultCalloutViewTheme = .light, detailButtonType: DefaultCalloutViewDetailButtonType = .detailDisclosure) {
		self.title = title
		self.subtitle = subtitle
		self.imageType = imageType
		self.theme = theme
		self.detailButtonType = detailButtonType
	}
}
