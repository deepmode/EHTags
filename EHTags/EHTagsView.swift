//
//  EHTagsView.swift
//  EHTags
//
//  Created by Eric Ho on 23/10/2016.
//  Copyright © 2016 Eric Ho. All rights reserved.
//

import UIKit

extension String {
    
    //reference: http://stackoverflow.com/questions/30450434/figure-out-size-of-uilabel-based-on-string-in-swift
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}

protocol EHTagsViewDelegate {
    func didPressTagButton(tagButton: UIButton)
}

class EHTagsView: UIView {
    
    let topPadding:CGFloat = 10.0
    let leadingPadding:CGFloat = 10.0
    let separatorHPadding:CGFloat = 10.0
    let separatorVPadding:CGFloat = 10.0
    let trailPadding:CGFloat = 10.0
    let bottomPadding:CGFloat = 10.0
    
    let labelTextVPadding:CGFloat = 5.0 + 5.0
    let labelTextHPadding:CGFloat = 5.0 + 5.0
    let tagViewBackgroundColor = UIColor.greenColor()
    let tagBackgroundColor = UIColor.groupTableViewBackgroundColor()
    
    //let selectFont = UIFont.systemFontOfSize(12.0)
    
    var labels = [UIButton]()
    var delegate:EHTagsViewDelegate?

    func setup(containerWidth:CGFloat, words:[String]) {
    
        let maxWidthSupport = containerWidth - leadingPadding - trailPadding
        
        self.frame = CGRectMake(0,0,0,0)
        self.backgroundColor = tagViewBackgroundColor
        
        for (_,eachWord) in words.enumerate() {
            
            let label = UIButton(frame: CGRectMake(0,0,0,0))
            //label.text = eachWord
            label.setTitleColor(UIColor.blackColor(), forState: .Normal)
            label.setTitle(eachWord, forState: .Normal)
            label.sizeToFit()
            
            //label.textAlignment = .Center
            label.backgroundColor = tagBackgroundColor
            
            label.addTarget(self, action: #selector(buttonPress(_:)), forControlEvents: .TouchUpInside)
            
            if label.bounds.width + labelTextHPadding > maxWidthSupport {
                //limit the label size
                let newHeight = label.bounds.height + labelTextVPadding
                let newLabelFrame = CGRectMake(0, 0, maxWidthSupport ,newHeight)
                label.frame = newLabelFrame
            } else {
                let currentFrame = label.frame
                let newWidth = currentFrame.width + labelTextHPadding
                let newHeight = currentFrame.height + labelTextVPadding
                let newLabelFrame = CGRectMake(0, 0, newWidth,newHeight)
                label.frame = newLabelFrame
            }
            self.labels.append(label)
            self.addSubview(label)
        }
    }
    
    internal func buttonPress(sender:UIButton) {
        //print("button: \(sender.titleLabel?.text)")
        self.delegate?.didPressTagButton(sender)
    }


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        //set frame
        super.drawRect(rect)
        self.updateTagsFrame(rect.width)
    }
    
    func estimateTagsViewHeight(containerWidth:CGFloat) -> CGFloat {
        return self.updateTagsFrame(containerWidth).height
    }
    
    private func updateTagsFrame(containerWidth:CGFloat) -> CGRect {
        var remaiderWidth = containerWidth
        var currentX:CGFloat = 0
        var currentY:CGFloat = 0 + topPadding
        var rowHeight:CGFloat = 0
        
        for eachLabel in labels {
            
            var fitThisRow = true
            
            let isABegin = remaiderWidth == containerWidth ? true : false
            if isABegin {
                fitThisRow = remaiderWidth - leadingPadding - eachLabel.bounds.width - trailPadding >= 0
            } else {
                fitThisRow = remaiderWidth - separatorHPadding - eachLabel.bounds.width - trailPadding >= 0
            }
            rowHeight = eachLabel.bounds.height
            
            if fitThisRow {
                
                if isABegin {
                    currentX = leadingPadding
                    remaiderWidth = remaiderWidth - leadingPadding - eachLabel.bounds.width
                } else {
                    currentX = containerWidth - remaiderWidth + separatorHPadding
                    remaiderWidth = remaiderWidth - separatorHPadding - eachLabel.bounds.width
                }
                
                let frame = CGRectMake(currentX, currentY, eachLabel.bounds.width, eachLabel.bounds.height)
                eachLabel.frame = frame
            } else {
                remaiderWidth = containerWidth
                currentX = leadingPadding
                currentY = currentY + rowHeight + separatorVPadding
                
                let frame = CGRectMake(currentX, currentY, eachLabel.bounds.width, eachLabel.bounds.height)
                eachLabel.frame = frame
                
                remaiderWidth = remaiderWidth - leadingPadding - eachLabel.bounds.width
            }
            
            eachLabel.layer.cornerRadius = 0.0
            eachLabel.layer.masksToBounds = true
        }
        
        let finalFrame = CGRectMake(0, 0, containerWidth, currentY + rowHeight + bottomPadding)
        return finalFrame
    }


}
