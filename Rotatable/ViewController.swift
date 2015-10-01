//
//  ViewController.swift
//  Rotatable
//
//  Created by Simon Gladman on 01/10/2015.
//  Copyright © 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label = UILabel()
    var switchControl = UISwitch()
    var datePicker = UIDatePicker()
    var segmentedControl = UISegmentedControl(items: ["AAA", "BBB", "CCC", "DDD"])
    
    let toolbarContainer = UIStackView()
    
    let resetButton = UIButton(type: UIButtonType.System)
    let slider = UISlider()
    let infoLabel = UILabel()
    let blur = UIVisualEffectView(effect: UIBlurEffect())
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        label.text = "Rotatable Label"
        
        view.addSubview(label)
        view.addSubview(switchControl)
        view.addSubview(segmentedControl)
        view.addSubview(datePicker)

        view.addSubview(blur)
        view.addSubview(toolbarContainer)
        
        // ----
        
        slider.minimumValue = -180
        slider.maximumValue = 180
        
        slider.frame = CGRect(x: 0, y: view.frame.height - slider.intrinsicContentSize().height, width: view.frame.width, height: slider.intrinsicContentSize().height)
        
        toolbarContainer.addArrangedSubview(slider)
        
        slider.addTarget(self, action: "sliderChangeHandler", forControlEvents: UIControlEvents.ValueChanged)
        
        // -----
        
        view.addSubview(toolbarContainer)
        
        resetButton.setTitle("Reset", forState: UIControlState.Normal)
        
        resetButton.tintColor = UIColor.blueColor()
        
        resetButton.frame = CGRect(x: 20, y: view.frame.height - 100, width: resetButton.intrinsicContentSize().width, height: resetButton.intrinsicContentSize().width)
        
        resetButton.addTarget(self, action: "resetRotation", forControlEvents: UIControlEvents.TouchDown)
        
        toolbarContainer.addArrangedSubview(resetButton)
        
        // ----
        
        toolbarContainer.addArrangedSubview(infoLabel)
        
        updateInfoLabel()
    }
    
    func resetRotation()
    {
        label.rotate(radians: 0, animated: true)
        datePicker.rotate(radians: 0, animated: true)
        switchControl.rotate(radians: 0, animated: true)
        segmentedControl.rotate(radians: 0, animated: true)
        
        slider.value = 0
        
        updateInfoLabel()
    }
    
    func sliderChangeHandler()
    {
        label.rotate(degrees: CGFloat(slider.value))
        datePicker.rotate(degrees: CGFloat(slider.value))
        switchControl.rotate(degrees: CGFloat(slider.value))
        segmentedControl.rotate(degrees: CGFloat(slider.value))
        
        updateInfoLabel()
    }
    
    func updateInfoLabel()
    {
        infoLabel.text = "\(Int(label.rotation.degrees))°"
    }
    
    override func viewDidLayoutSubviews()
    {
        label.frame = CGRect(origin: CGPoint(x: view.frame.width * 0.25 - label.intrinsicContentSize().width * 0.5,
            y: view.frame.height * 0.25),
            size: CGSize(width: label.intrinsicContentSize().width,
                height: label.intrinsicContentSize().height))

        switchControl.frame = CGRect(origin: CGPoint(x: view.frame.width * 0.25 - switchControl.intrinsicContentSize().width * 0.5,
            y: view.frame.height * 0.5),
            size: CGSize(width: switchControl.intrinsicContentSize().width, height: switchControl.intrinsicContentSize().height))

        segmentedControl.frame = CGRect(origin: CGPoint(x: view.frame.width * 0.25 - segmentedControl.intrinsicContentSize().width * 0.5,
            y: view.frame.height * 0.75),
            size: CGSize(width: segmentedControl.intrinsicContentSize().width, height: segmentedControl.intrinsicContentSize().height))
        
        datePicker.frame = CGRect(origin: CGPoint(x: view.frame.width * 0.66 - datePicker.intrinsicContentSize().width * 0.5,
            y: view.frame.height * 0.5 - datePicker.intrinsicContentSize().height * 0.5),
            size: CGSize(width: datePicker.intrinsicContentSize().width, height: datePicker.intrinsicContentSize().height))
        
        toolbarContainer.frame = CGRect(x: 5,
            y: view.frame.height - 50,
            width: view.frame.width - 10,
            height: 50)
        
        blur.frame = toolbarContainer.frame
        
        toolbarContainer.spacing = 10
    }
}



