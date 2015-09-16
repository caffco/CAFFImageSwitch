//
//  CAFFImageSwitch.h
//  CaffImageSwitch
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 16/9/15.
//  Copyright © 2015 Caff. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CAFFImageSwitch : UIControl

#pragma mark - Public

/**
 *  Sets (without animation) whether the switch is on or off
 */
@property ( nonatomic, getter=isOn ) BOOL on;

/**
 *  Sets the background color that shows when the switch off and actively being
 *  touched.
 *
 *  Defaults to light gray.
 */
@property ( nonatomic, strong ) IBInspectable UIColor* activeColor;

/**
 *  Sets the background color when the switch is off.
 *
 *  Defaults to clear color.
 */
@property ( nonatomic, strong ) IBInspectable UIColor* inactiveColor;

/**
 *  Sets the background color that shows when the switch is on.
 *
 *  Defaults to green.
 */
@property ( nonatomic, strong ) IBInspectable UIColor* onTintColor;

/**
 *  Sets the border color that shows when the switch is off.
 *
 *  Defaults to light gray.
 */
@property ( nonatomic, strong ) IBInspectable UIColor* borderColor;

/**
 *  Sets the knob color.
 *
 *  Defaults to white.
 */
@property ( nonatomic, strong ) IBInspectable UIColor* thumbTintColor;

/**
 *  Sets the knob color that shows when the switch is on.
 *
 *  Defaults to white.
 */
@property ( nonatomic, strong ) IBInspectable UIColor* onThumbTintColor;

/**
 *  Sets the shadow color of the knob.
 *
 *  Defaults to gray.
 */
@property ( nonatomic, strong ) IBInspectable UIColor* shadowColor;

/**
 *  Sets whether or not the switch edges are rounded.
 *
 *  Set to NO to get a stylish square switch.
 *
 *  Defaults to YES.
 */
@property ( nonatomic, getter=isRounded ) IBInspectable BOOL rounded;

/**
 *  Sets the image that shows on the switch thumb.
 */
@property ( nonatomic, strong ) IBInspectable UIImage* thumbImage;

/**
 *  Sets the image that shows when the switch is on.
 *
 *  The image is centered in the area not covered by the knob.
 *
 *  Make sure to size your images appropriately.
 */
@property ( nonatomic, strong ) IBInspectable UIImage* onImage;

/**
 *  Sets the image that shows when the switch is off.
 *
 *  The image is centered in the area not covered by the knob.
 *
 *  Make sure to size your images appropriately.
 */
@property ( nonatomic, strong ) IBInspectable UIImage* offImage;

/**
 *  Sets the text that shows when the switch is on.
 *
 *  The text is centered in the area not covered by the knob.
 */
@property ( nonatomic, strong ) IBInspectable UILabel* onLabel;

/**
 *  Sets the text that shows when the switch is off.
 *
 *  The text is centered in the area not covered by the knob.
 */
@property ( nonatomic, strong ) IBInspectable UILabel* offLabel;

/**
 *  Set the state of the switch to on or off, optionally animating the 
 *  transition.
 *
 *  @param on       New switch's state.
 *  @param animated Whether to animate transition or not.
 */
- (void)setOn:(BOOL)on animated:(BOOL)animated;

#pragma mark - Internal

@property ( nonatomic, strong ) UIView* backgroundView;
@property ( nonatomic, strong ) UIView* thumbView;
@property ( nonatomic, strong ) UIImageView* onImageView;
@property ( nonatomic, strong ) UIImageView* offImageView;
@property ( nonatomic, strong ) UIImageView* thumbImageView;

@end
