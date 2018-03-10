//
//  DefaultCalloutViewModel.swift
//  MapViewPlus
//
//  Created by Okhan on 07/03/2018.
//  Copyright © 2018 okhanokbay. All rights reserved.
//

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
