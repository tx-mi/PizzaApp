//
//  CustomSegmentedControl.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 17.10.2022.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    private let segmentInset: CGFloat = 5
    private let segmentImage: UIImage? = UIImage(color: .transparentPink)
    
    override init(items: [Any]?) {
        super.init(items: items)
        
        setDividerImage(UIImage(color: UIColor(hex: 0xeeeef0)), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()

        //background
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
        //foreground
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            if foregroundImageView.isFocused {
                print(1)
            }
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            foregroundImageView.image = segmentImage    //substitute with our own colored image
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height/2
        }
    }
}

extension UIImage {
    
    //creates a UIImage given a UIColor
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
