//
//  Rotatable.swift
//  Rotatable
//
//  Created by Simon Gladman on 01/10/2015.
//  Copyright © 2015 Simon Gladman. All rights reserved.
//

import UIKit

protocol Rotatable
{
    var transform: CGAffineTransform {get set}
    
    mutating func rotate(degrees degrees: CGFloat, animated: Bool)
    mutating func rotate(radians radians: CGFloat, animated: Bool)
    
    var rotation: (radians: CGFloat, degrees: CGFloat) { get }
}

extension UIView: Rotatable
{
    
}

extension Rotatable
{
    mutating func rotate(degrees degrees: CGFloat, animated: Bool = false)
    {
        rotate(radians: degreesToRadians(degrees), animated: animated)
    }
    
    mutating func rotate(radians radians: CGFloat, animated: Bool = false)
    {
        UIView.animateWithDuration(animated ? 0.2 : 0.0)
        {
            self.transform = CGAffineTransformMakeRotation(radians)
        }
    }
    
    var rotation: (radians: CGFloat, degrees: CGFloat)
    {
        let radians = CGFloat(atan2f(Float(transform.b), Float(transform.a)))
        
        return (radians, radiansToDegrees(radians))
    }
    
    func degreesToRadians(value: CGFloat) -> CGFloat
    {
        return CGFloat(M_PI) * value / 180.0
    }
    
    func radiansToDegrees(value: CGFloat) -> CGFloat
    {
        return value * 180 / CGFloat(M_PI)
    }
}
