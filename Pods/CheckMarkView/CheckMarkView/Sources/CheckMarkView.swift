//
//  CheckMarkView.swift
//  CheckMarkView
//
//  Created by Maxim on 7/18/15.
//  Copyright (c) 2015 Maxim. All rights reserved.
//

import UIKit

public class CheckMarkView: UIView {

	public enum CheckMarkStyle: Int {
		case Nothing
		case OpenCircle
		case GrayedOut
	}
	
	public var checked: Bool {
		get {
			return _checked
		}
		set(newValue) {
			_checked = newValue
			setNeedsDisplay()
		}
	}

	public var style: CheckMarkStyle {
		get {
			return _style
		}
		set(newValue) {
			_style = newValue
			setNeedsDisplay()
		}
	}
	
	private var _checked: Bool = false
	private var _style: CheckMarkStyle = .Nothing
	
    override public func drawRect(rect: CGRect) {
		super.drawRect(rect)
		
		if _checked {
			drawRectChecked(rect)
		}
		else {
			if _style == .OpenCircle {
				drawRectOpenCircle(rect)
			}
			else if _style == .GrayedOut {
				drawRectGrayedOut(rect)
			}
		}
    }
	
	func drawRectChecked(rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		let frame = self.bounds
		
		let checkmarkBlue = UIColor(red: 0.078, green: 0.435, blue: 0.875, alpha: 1)
		let shadow = UIColor.blackColor()
		let shadowOffset = CGSizeMake(0.1, -0.1)
		let shadowBlurRadius: CGFloat = 2.5
		
		let group = CGRectMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 6, CGRectGetHeight(frame) - 6)
		let checkedOvalPath = UIBezierPath(ovalInRect: CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00000 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 1.00000 + 0.5) - floor(CGRectGetWidth(group) * 0.00000 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5)))
		
		CGContextSaveGState(context)
		CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor)
		checkmarkBlue.setFill()
		checkedOvalPath.fill()
		CGContextRestoreGState(context)
		
		UIColor.whiteColor().setStroke()
		checkedOvalPath.lineWidth = 1
		checkedOvalPath.stroke()
		
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(CGRectGetMinX(group) + 0.27083 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.54167 * CGRectGetHeight(group)))
		bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(group) + 0.41667 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.68750 * CGRectGetHeight(group)))
		bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(group) + 0.75000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35417 * CGRectGetHeight(group)))
		bezierPath.lineCapStyle = kCGLineCapSquare
		
		UIColor.whiteColor().setStroke()
		bezierPath.lineWidth = 1.3
		bezierPath.stroke()
	}
	
	func drawRectOpenCircle(rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		let frame = self.bounds
		
		let shadow = UIColor.blackColor()
		let shadowOffset = CGSizeMake(0.1, -0.1)
		let shadowBlurRadius: CGFloat = 0.5
		let shadow2 = UIColor.blackColor()
		let shadow2Offset = CGSizeMake(0.1, -0.1)
		let shadow2BlurRadius: CGFloat = 2.5
		
		let group = CGRectMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 6, CGRectGetHeight(frame) - 6)
		let emptyOvalPath = UIBezierPath(ovalInRect: CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00000 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 1.00000 + 0.5) - floor(CGRectGetWidth(group) * 0.00000 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5)))
		
		CGContextSaveGState(context)
		CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor)
		CGContextRestoreGState(context)
		
		CGContextSaveGState(context)
		CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor)
		UIColor.whiteColor().setStroke()
		emptyOvalPath.lineWidth = 1
		emptyOvalPath.stroke()
		CGContextRestoreGState(context)
	}
	
	func drawRectGrayedOut(rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		let frame = self.bounds
		
		let grayTranslucent = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
		let shadow = UIColor.blackColor()
		let shadowOffset = CGSizeMake(0.1, -0.1)
		let shadowBlurRadius: CGFloat = 2.5
		
		let group = CGRectMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 6, CGRectGetHeight(frame) - 6)
		let uncheckedOvalPath = UIBezierPath(ovalInRect: CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00000 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 1.00000 + 0.5) - floor(CGRectGetWidth(group) * 0.00000 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5)))
		
		CGContextSaveGState(context)
		CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor)
		grayTranslucent.setFill()
		uncheckedOvalPath.fill()
		CGContextRestoreGState(context)
		
		UIColor.whiteColor().setStroke()
		uncheckedOvalPath.lineWidth = 1
		uncheckedOvalPath.stroke()
		
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(CGRectGetMinX(group) + 0.27083 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.54167 * CGRectGetHeight(group)))
		bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(group) + 0.41667 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.68750 * CGRectGetHeight(group)))
		bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(group) + 0.75000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.35417 * CGRectGetHeight(group)))
		bezierPath.lineCapStyle = kCGLineCapSquare
		
		UIColor.whiteColor().setStroke()
		bezierPath.lineWidth = 1.3
		bezierPath.stroke()
	}

}
