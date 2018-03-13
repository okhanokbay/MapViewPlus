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
import Kingfisher

// Default Callout's detail button colors and also callout's background color will be decided related to theme.
public enum DefaultCalloutViewTheme {
	case light, dark
}

// The button type that will be sent through delegate methods
public enum DefaultCalloutViewButtonType {
	case background, detail
}

// The button type that can be located in any location in default callout view in future.
public enum DefaultCalloutViewDetailButtonType {
	case detailDisclosure, info
}

public enum DefaultCalloutViewImageType {
	case downloadable(imageURL: URL, placeholder: UIImage?)
	case fromBundle(image: UIImage)
	case none
}

public protocol DefaultCalloutViewDelegate: class {
	func buttonDetailTapped(with viewModel: DefaultCalloutViewModelProtocol, buttonType: DefaultCalloutViewButtonType)
}

open class DefaultCalloutView: UIView {
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var labelTitle: UILabel!
	@IBOutlet weak var labelSubtitle: UILabel!
	@IBOutlet weak var buttonBackground: UIButton!
	@IBOutlet weak var buttonDetail: UIButton!
	
	public weak var delegate: DefaultCalloutViewDelegate?
	
	fileprivate var viewModel: DefaultCalloutViewModelProtocol!
    
	open override func awakeFromNib() {
		super.awakeFromNib()
		layer.cornerRadius = 5
		imageView.layer.cornerRadius = 2
	}
	
	@IBAction func buttonBackgroundTouchDown(_ sender: Any) {
		callTapDelegateWith(.background)
	}
	
	@IBAction func buttonDetailTouchDown(_ sender: Any) {
		callTapDelegateWith(.detail)
	}
	
	private func callTapDelegateWith(_ buttonType: DefaultCalloutViewButtonType) {
		delegate?.buttonDetailTapped(with: viewModel, buttonType: buttonType) //Crashes if there is no viewModel set.
	}
}

extension DefaultCalloutView: CalloutViewPlus {
	public func configureCallout(_ viewModel: CalloutViewModel) {
		let defaultViewModel = viewModel as! DefaultCalloutViewModelProtocol
		
		self.viewModel = defaultViewModel
		
		backgroundColor = DefaultCalloutViewThemeManager.getBackgroundColor(of: defaultViewModel.theme)
		let relatedItemColor = DefaultCalloutViewThemeManager.getItemColor(of: defaultViewModel.theme)
		labelTitle.textColor = relatedItemColor
		labelSubtitle.textColor = relatedItemColor
		
		switch defaultViewModel.imageType{
		case .downloadable(let imageURL, let placeholder):
			DispatchQueue.main.async {
				self.imageView.kf.setImage(with: imageURL, placeholder: placeholder)
			}
			
		case .fromBundle(let image):
			imageView.image = image
			
		case .none: // This will be nil and calloutview will shrink to hide imageview in one of the next releases.
			imageView.image = (DefaultCalloutViewThemeManager.getPlaceholderImage(of: defaultViewModel.theme))
		}
		
		switch defaultViewModel.detailButtonType {
		case .detailDisclosure:
			buttonDetail.setBackgroundImage((DefaultCalloutViewThemeManager.getDetailDisclosureButtonImage(of: defaultViewModel.theme)), for: .normal)
			
		case .info:
			buttonDetail.setBackgroundImage((DefaultCalloutViewThemeManager.getInfoButtonImage(of: defaultViewModel.theme)), for: .normal)
		}
		
		labelTitle.text = defaultViewModel.title
		labelSubtitle.text = defaultViewModel.subtitle ?? nil
	}
}

extension DefaultCalloutView: CalloutViewCustomizerDelegate {
	public func mapView(_ mapView: MapViewPlus, centerForCalloutViewOf annotationView: AnnotationViewPlus) -> CalloutViewPlusCenter {
		return .defaultCenter
	}
	
	//Default Callout View self sizes its width by calculating the minimum width of either title or subtitle, related to which has the minimum value.
	public func mapView(_ mapView: MapViewPlus, boundsForCalloutViewOf annotationView: AnnotationViewPlus) -> CalloutViewPlusBound {
		let titleExpectedWidth = labelTitle.intrinsicContentSize.width
		let subTitleExpectedWidth = labelSubtitle.intrinsicContentSize.width
		
		let titleWidthChange = labelTitle.bounds.size.width - titleExpectedWidth
		let subtitleWidthChange = labelSubtitle.bounds.size.width - subTitleExpectedWidth
		
		let mapViewWidth = mapView.bounds.size.width
		let newCalloutWidth = bounds.size.width - (titleWidthChange < subtitleWidthChange ? titleWidthChange : subtitleWidthChange)
		
		//Don't let it grow too big.
		guard newCalloutWidth < mapViewWidth - (mapView.calloutViewHorizontalInset * 2) else {
			return .defaultBounds
		}
		
		return .customBounds(CGRect(x: 0 , y: 0, width: newCalloutWidth, height: bounds.size.height))
	}
}

extension DefaultCalloutView: AnchorViewCustomizerDelegate {
    public func mapView(_ mapView: MapViewPlus, heightForAnchorOf calloutView: CalloutViewPlus) -> CGFloat {
        return mapView.defaultHeightForAnchors
    }
    
    public func mapView(_ mapView: MapViewPlus, fillColorForAnchorOf calloutView: CalloutViewPlus) -> UIColor {
        return DefaultCalloutViewThemeManager.getAnchorFillColor(of: viewModel.theme)
    }
}
