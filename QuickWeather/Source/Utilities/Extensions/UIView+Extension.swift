//
//  UIView+Extension.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import UIKit

extension UIView {
    /// Sets the shadow properties for the layer of the view.
    ///
    /// This method configures the shadow by setting the corner radius, shadow opacity, shadow radius,
    /// shadow offset, and shadow color of the layer.
    ///
    /// - Parameters:
    ///   - cornerRadius: The radius of the layer's corners. A larger value results in more rounded corners. Default is 4.
    ///   - shadowOpacity: The opacity of the layer's shadow. A higher value results in a more visible shadow, with 1.0 being fully opaque and 0.0 being fully transparent. Default is 0.5.
    ///   - shadowRadius: The blur radius used to create the shadow. A larger value results in a more blurred (softer) shadow. Default is 4.
    ///   - shadowOffset: The offset (in points) of the layer's shadow. The width value moves the shadow horizontally, and the height value moves it vertically. Default is `CGSize(width: 0, height: 1)`, which means the shadow is slightly below the view.
    ///   - shadowColor: The color of the layer's shadow. Default is `Color.mainTheme`. This should be a `UIColor` object, and it is converted to `CGColor` for setting the layer's shadow color.
    ///
    /// - Note: The `shadowColor` parameter takes a `UIColor` object, but it is converted to `CGColor` for setting the layer's shadow color.
    ///
    /// ```swift
    /// // Example usage:
    /// view.setShadow(cornerRadius: 8, shadowOpacity: 0.7, shadowRadius: 6, shadowOffset: CGSize(width: 2, height: 2), shadowColor: .black)
    /// ```
    ///
    /// Use this method to apply a consistent shadow style across your UI components.
    func setShadow(cornerRadius: CGFloat = 4,
                   shadowOpacity: Float = 0.5,
                   shadowRadius: CGFloat = 4,
                   shadowOffset: CGSize = CGSize(width: 0, height: 1),
                   shadowColor: UIColor = .black) {
        
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor.cgColor
    }
}
