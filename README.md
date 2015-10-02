# Rotatable
Swift Protocol Extension to Rotate any UIView
_Companion project to this blog post: http://flexmonkey.blogspot.co.uk/2015/10/rotatable-swift-protocol-extension-to.html_

![Rotatable](/Rotatable/Rotatable.gif)

##Rotatable: A Swift Protocol Extension to Rotate any UIView

One of the questions frequently asked on StackOverflow is “how do I rotate my UILabel / UIButton / UISlider etc.”. So, following on from Blurable, my Swift protocol extension for applying a Gaussian blur to UIViews, I thought I’d create another quick extension to make any UIView rotatable. 

By default, UIViews don’t have a simple rotation property. To rotate them, you have to create a CGAffineTransform and pass it to the view’s transform property. If your user interface requires lots of rotating, Rotatable bundles all that up into a separate extension and lets you forget about the implementation details.

##The Rotatable Protocol

The protocol itself is pretty basic, consisting of one property, transform of type CGAffineTransform, which UIViews already have, two new methods for actually rotating:

    mutating func rotate(degrees degrees: CGFloat, animated: Bool)
    mutating func rotate(radians radians: CGFloat, animated: Bool)

…and a readonly property that returns a tuple of the UIView’s current rotation in both radians and degrees:

    var rotation: (radians: CGFloat, degrees: CGFloat) { get }

##Rotatable Mechanics

The protocol extension contains the mechanics for rotating the component. It’s pretty basic stuff, simply creating a CGAffineTransformMakeRotation and  applying it to the transform property, If the rotate() method is called with animated set to true, it wraps setting in a UIView.animateWithDuration:

    mutating func rotate(radians radians: CGFloat, animated: Bool = false)
    {
        UIView.animateWithDuration(animated ? 0.2 : 0.0)
        {
            self.transform = CGAffineTransformMakeRotation(radians)
        }
    }

To return the current rotation, I extract the angle from the CGAffineTransform:

    var rotation: (radians: CGFloat, degrees: CGFloat)
    {
        let radians = CGFloat(atan2f(Float(transform.b), Float(transform.a)))
        
        return (radians, radiansToDegrees(radians))
    }

##Implementation

All the code for Rotatable is in one file, Rotatable.swift. To rotate an object, let’s say a date picker, all you have to do is invoke the rotate() method:

    var datePicker = UIDatePicker()
    view.addSubview(datePicker)

    datePicker.rotate(degrees: 45)

If you’re resetting the rotation, you may want to animate it, in which case the syntax would be:

    datePicker.rotate(radians: 0, animated: true)

By default, the animated property is set to false.

##Conclusion

Hopefully, this projects is another good demonstration of how Swift’s protocol extensions allow developers to retroactively add almost any type of behaviour to all objects in Swift including visual components with a minimum of effort.

All the code to this project is available in my GitHub repository here.
