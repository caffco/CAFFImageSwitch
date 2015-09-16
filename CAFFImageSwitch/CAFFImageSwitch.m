//
//  CAFFImageSwitch.h
//  CaffImageSwitch
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 16/9/15.
//  Copyright © 2015 Caff. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CAFFImageSwitch.h"

@interface CAFFImageSwitch ()

@property ( nonatomic ) BOOL currentVisualValue;
@property ( nonatomic ) BOOL startTrackingValue;
@property ( nonatomic ) BOOL didChangeWhileTracking;
@property ( nonatomic ) BOOL isAnimating;
@property ( nonatomic ) BOOL userDidSpecifyOnThumbTintColor;
@property ( nonatomic ) BOOL switchValue;

/**
 *  Sets up CAFFImageSwitch.
 */
- (void)setupCAFFImageSwitch;

/**
 *  Update the looks of the switch to be in the on position optionally make it 
 *  animated.
 *
 *  @param animated Whether to animate change or not.
 */
- (void)showOnAnimated: (BOOL)animated;

/**
 *  Update the looks of the switch to be in the off position optionally make it 
 *  animated.
 *
 *  @param animated Whether to animate change or not.
 */
- (void)showOffAnimated:(BOOL)animated;

@end

@implementation CAFFImageSwitch

#pragma mark - Overriden setters

- (void)setOn:(BOOL)on
{
	self.switchValue = on;
	[self setOn:on animated:false];
}

- (void)setActiveColor:(UIColor*)activeColor
{
	_activeColor = activeColor;
	if ( self.on && !self.tracking )
	{
		self.backgroundView.backgroundColor = _activeColor;
	}
}

- (void)setInactiveColor:(UIColor*)inactiveColor
{
	_inactiveColor = inactiveColor;
	if ( !self.on && !self.tracking )
	{
		self.backgroundView.backgroundColor = _inactiveColor;
	}
}

- (void)setOnTintColor:(UIColor*)onTintColor
{
	_onTintColor = onTintColor;
	if ( self.on && !self.tracking )
	{
		self.backgroundView.backgroundColor   = _onTintColor;
		self.backgroundView.layer.borderColor = _onTintColor.CGColor;
	}
}

- (void)setBorderColor:(UIColor*)borderColor
{
	_borderColor = borderColor;
	if ( !self.on )
	{
		self.backgroundView.layer.borderColor = _borderColor.CGColor;
	}
}

- (void)setThumbTintColor:(UIColor*)thumbTintColor
{
	_thumbTintColor = thumbTintColor;
	if ( !self.userDidSpecifyOnThumbTintColor )
	{
		_onThumbTintColor = thumbTintColor;
	}
	if ( ( !self.userDidSpecifyOnThumbTintColor || !self.on ) && !self.tracking )
	{
		self.thumbView.backgroundColor = thumbTintColor;
	}
}

- (void)setOnThumbTintColor:(UIColor*)onThumbTintColor
{
	_onThumbTintColor                   = onThumbTintColor;
	self.userDidSpecifyOnThumbTintColor = YES;
	if ( self.on && !self.tracking )
	{
		self.thumbView.backgroundColor = _onThumbTintColor;
	}
}

- (void)setShadowColor:(UIColor*)shadowColor
{
	_shadowColor                     = shadowColor;
	self.thumbView.layer.shadowColor = _shadowColor.CGColor;
}

- (void)setRounded:(BOOL)rounded
{
	_rounded = rounded;
	if ( _rounded )
	{
		self.backgroundView.layer.cornerRadius = self.frame.size.height * 0.5;
		self.thumbView.layer.cornerRadius      = ( self.frame.size.height * 0.5 ) - 1;
	}
	else
	{
		self.backgroundView.layer.cornerRadius = 2;
		self.thumbView.layer.cornerRadius      = 2;
	}

	self.thumbView.layer.shadowPath =
	    [UIBezierPath bezierPathWithRoundedRect:self.thumbView.bounds
	                               cornerRadius:self.thumbView.layer.cornerRadius]
	        .CGPath;
}

- (void)setThumbImage:(UIImage*)thumbImage
{
	self.thumbImageView.image = thumbImage;
}

- (void)setOnImage:(UIImage*)onImage
{
	self.onImageView.image = onImage;
}

- (void)setOffImage:(UIImage*)offImage
{
	self.offImageView.image = offImage;
}

#pragma mark - Overriden getters

- (BOOL)isOn
{
	return self.switchValue;
}

- (UIImage*)thumbImage
{
	return self.thumbImageView.image;
}

- (UIImage*)onImage
{
	return self.onImageView.image;
}

- (UIImage*)offImage
{
	return self.offImageView.image;
}

#pragma mark - Constructors

- (instancetype)init
{
	return [self initWithFrame:CGRectMake( 0, 0, 50, 30 )];
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if ( CGRectIsEmpty( frame ) )
	{
		frame = CGRectMake( 0, 0, 50, 30 );
	}
	self = [super initWithFrame:frame];
	if ( self )
	{
		[self setupCAFFImageSwitch];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if ( self )
	{
		[self setupCAFFImageSwitch];
	}
	return self;
}

- (void)setupCAFFImageSwitch
{
	self.activeColor      = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
	self.inactiveColor    = [UIColor clearColor];
	self.onTintColor      = [UIColor colorWithRed:0.3 green:0.85 blue:0.39 alpha:1];
	self.borderColor      = [UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1];
	self.thumbTintColor   = [UIColor whiteColor];
	self.onThumbTintColor = [UIColor whiteColor];
	self.shadowColor      = [UIColor grayColor];

	self.rounded                        = YES;
	self.currentVisualValue             = NO;
	self.startTrackingValue             = NO;
	self.didChangeWhileTracking         = NO;
	self.isAnimating                    = NO;
	self.userDidSpecifyOnThumbTintColor = NO;
	self.switchValue                    = NO;

	// Background view.

	self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, self.frame.size.width, self.frame.size.height )];

	self.backgroundView.backgroundColor        = [UIColor clearColor];
	self.backgroundView.layer.cornerRadius     = self.frame.size.height * 0.5;
	self.backgroundView.layer.borderColor      = self.borderColor.CGColor;
	self.backgroundView.layer.borderWidth      = 1.0;
	self.backgroundView.userInteractionEnabled = NO;
	self.backgroundView.clipsToBounds          = NO;
	[self addSubview:self.backgroundView];

	// on/off images.

	self.onImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height )];

	self.onImageView.alpha       = 1.0;
	self.onImageView.contentMode = UIViewContentModeCenter;
	[self.backgroundView addSubview:self.onImageView];

	self.offImageView             = [[UIImageView alloc] initWithFrame:CGRectMake( self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height )];
	self.offImageView.alpha       = 1.0;
	self.offImageView.contentMode = UIViewContentModeCenter;
	[self.backgroundView addSubview:self.offImageView];

	// Labels.

	self.onLabel               = [[UILabel alloc] initWithFrame:CGRectMake( 0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height )];
	self.onLabel.textAlignment = NSTextAlignmentCenter;
	self.onLabel.textColor     = [UIColor lightGrayColor];
	self.onLabel.font          = [UIFont systemFontOfSize:12];
	[self.backgroundView addSubview:self.onLabel];

	self.offLabel               = [[UILabel alloc] initWithFrame:CGRectMake( self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height )];
	self.offLabel.textAlignment = NSTextAlignmentCenter;
	self.offLabel.textColor     = [UIColor lightGrayColor];
	self.offLabel.font          = [UIFont systemFontOfSize:12];
	[self.backgroundView addSubview:self.offLabel];

	// thumb
	self.thumbView                        = [[UIView alloc] initWithFrame:CGRectMake( 1, 1, self.frame.size.height - 2, self.frame.size.height - 2 )];
	self.thumbView.backgroundColor        = self.thumbTintColor;
	self.thumbView.layer.cornerRadius     = ( self.frame.size.height * 0.5 ) - 1;
	self.thumbView.layer.shadowColor      = self.shadowColor.CGColor;
	self.thumbView.layer.shadowRadius     = 2.0;
	self.thumbView.layer.shadowOpacity    = 0.5;
	self.thumbView.layer.shadowOffset     = CGSizeMake( 0, 3 );
	self.thumbView.layer.shadowPath       = [UIBezierPath bezierPathWithRoundedRect:self.thumbView.bounds cornerRadius:self.thumbView.layer.cornerRadius].CGPath;
	self.thumbView.layer.masksToBounds    = NO;
	self.thumbView.userInteractionEnabled = NO;
	[self addSubview:self.thumbView];

	// thumb image
	self.thumbImageView                  = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, self.thumbView.frame.size.width, self.thumbView.frame.size.height )];
	self.thumbImageView.contentMode      = UIViewContentModeCenter;
	self.thumbImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.thumbView addSubview:self.thumbImageView];

	self.on = NO;
}

#pragma mark - Overriden UIControl methods

- (BOOL)beginTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
	[super beginTrackingWithTouch:touch withEvent:event];

	self.startTrackingValue     = self.on;
	self.didChangeWhileTracking = NO;

	CGFloat activeKnobWidth = self.bounds.size.height - 2 + 5;
	self.isAnimating        = YES;

	[UIView animateWithDuration:0.3
	    delay:0.0
	    options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
	    animations:^{
		    if ( self.on )
		    {
			    self.thumbView.frame                = CGRectMake( self.bounds.size.width - ( activeKnobWidth + 1 ), self.thumbView.frame.origin.y, activeKnobWidth, self.thumbView.frame.size.height );
			    self.backgroundView.backgroundColor = self.onTintColor;
			    self.thumbView.backgroundColor      = self.onThumbTintColor;
		    }
		    else
		    {
			    self.thumbView.frame                = CGRectMake( self.thumbView.frame.origin.x, self.thumbView.frame.origin.y, activeKnobWidth, self.thumbView.frame.size.height );
			    self.backgroundView.backgroundColor = self.activeColor;
			    self.thumbView.backgroundColor      = self.thumbTintColor;
		    }
		}
	    completion:^( BOOL finished ) {
		    self.isAnimating = NO;
		}];

	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
	[super continueTrackingWithTouch:touch withEvent:event];

	CGPoint lastPoint = [touch locationInView:self];

	// update the switch to the correct visuals depending on if
	// they moved their touch to the right or left side of the switch
	if ( lastPoint.x > self.bounds.size.width * 0.5 )
	{
		[self showOnAnimated:YES];
		if ( !self.startTrackingValue )
		{
			self.didChangeWhileTracking = YES;
		}
	}
	else
	{
		[self showOffAnimated:YES];
		if ( self.startTrackingValue )
		{
			self.didChangeWhileTracking = YES;
		}
	}

	return YES;
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
	[super endTrackingWithTouch:touch withEvent:event];

	BOOL previousValue = self.on;

	if ( self.didChangeWhileTracking )
	{
		[self setOn:self.currentVisualValue animated:YES];
	}
	else
	{
		[self setOn:!self.on animated:true];
	}

	if ( previousValue != self.on )
	{
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
}

- (void)cancelTrackingWithEvent:(UIEvent*)event
{
	[super cancelTrackingWithEvent:event];

	// just animate back to the original value
	if ( self.on )
	{
		[self showOnAnimated:true];
	}
	else
	{
		[self showOffAnimated:true];
	}
}

#pragma mark - UIView lifecycle

- (void)layoutSubviews
{
	[super layoutSubviews];

	if ( !self.isAnimating )
	{
		CGRect frame = self.frame;

		// Background.

		self.backgroundView.frame              = CGRectMake( 0, 0, frame.size.width, frame.size.height );
		self.backgroundView.layer.cornerRadius = self.isRounded ? frame.size.height * 0.5 : 2;

		// Images.

		self.onImageView.frame  = CGRectMake( 0, 0, frame.size.width - frame.size.height, frame.size.height );
		self.offImageView.frame = CGRectMake( frame.size.height, 0, frame.size.width - frame.size.height, frame.size.height );
		self.onLabel.frame      = CGRectMake( 0, 0, frame.size.width - frame.size.height, frame.size.height );
		self.offLabel.frame     = CGRectMake( frame.size.height, 0, frame.size.width - frame.size.height, frame.size.height );

		// Thumb.

		CGFloat normalKnobWidth = frame.size.height - 2;
		if ( self.on )
		{
			self.thumbView.frame = CGRectMake( frame.size.width - ( normalKnobWidth + 1 ), 1, frame.size.height - 2, normalKnobWidth );
		}
		else
		{
			self.thumbView.frame = CGRectMake( 1, 1, normalKnobWidth, normalKnobWidth );
		}

		self.thumbView.layer.cornerRadius = ( self.isRounded ) ? ( frame.size.height * 0.5 ) - 1 : 2;
	}
}

#pragma mark - Private methods

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
	self.switchValue = on;

	if ( on )
	{
		[self showOnAnimated:animated];
	}
	else
	{
		[self showOffAnimated:animated];
	}
}

- (void)showOnAnimated:(BOOL)animated
{
	CGFloat normalKnobWidth = self.bounds.size.height - 2;
	CGFloat activeKnobWidth = normalKnobWidth + 5;
	if ( animated )
	{
		self.isAnimating = YES;

		[UIView animateWithDuration:0.3
		    delay:0.0
		    options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
		    animations:^{
			    if ( self.tracking )
			    {
				    self.thumbView.frame = CGRectMake( self.bounds.size.width - ( activeKnobWidth + 1 ), self.thumbView.frame.origin.y, activeKnobWidth, self.thumbView.frame.size.height );
			    }
			    else
			    {
				    self.thumbView.frame = CGRectMake( self.bounds.size.width - ( normalKnobWidth + 1 ), self.thumbView.frame.origin.y, normalKnobWidth, self.thumbView.frame.size.height );
			    }

			    self.backgroundView.backgroundColor   = self.onTintColor;
			    self.backgroundView.layer.borderColor = self.onTintColor.CGColor;
			    self.thumbView.backgroundColor        = self.onThumbTintColor;
			    self.onImageView.alpha                = 1.0;
			    self.offImageView.alpha               = 0;
			    self.onLabel.alpha                    = 1.0;
			    self.offLabel.alpha                   = 0;
			}
		    completion:^( BOOL finished ) {
			    self.isAnimating = NO;
			}];
	}
	else
	{
		if ( self.tracking )
		{
			self.thumbView.frame = CGRectMake( self.bounds.size.width - ( activeKnobWidth + 1 ), self.thumbView.frame.origin.y, activeKnobWidth, self.thumbView.frame.size.height );
		}
		else
		{
			self.thumbView.frame = CGRectMake( self.bounds.size.width - ( normalKnobWidth + 1 ), self.thumbView.frame.origin.y, normalKnobWidth, self.thumbView.frame.size.height );
		}

		self.backgroundView.backgroundColor   = self.onTintColor;
		self.backgroundView.layer.borderColor = self.onTintColor.CGColor;
		self.thumbView.backgroundColor        = self.onThumbTintColor;
		self.onImageView.alpha                = 1.0;
		self.offImageView.alpha               = 0;
		self.onLabel.alpha                    = 1.0;
		self.offLabel.alpha                   = 0;
	}

	self.currentVisualValue = YES;
}

- (void)showOffAnimated:(BOOL)animated
{
	CGFloat normalKnobWidth = self.bounds.size.height - 2;
	CGFloat activeKnobWidth = normalKnobWidth + 5;

	if ( animated )
	{
		self.isAnimating = YES;
		[UIView animateWithDuration:0.3
		    delay:0.0
		    options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
		    animations:^{
			    if ( self.tracking )
			    {
				    self.thumbView.frame                = CGRectMake( 1, self.thumbView.frame.origin.y, activeKnobWidth, self.thumbView.frame.size.height );
				    self.backgroundView.backgroundColor = self.activeColor;
			    }
			    else
			    {
				    self.thumbView.frame                = CGRectMake( 1, self.thumbView.frame.origin.y, normalKnobWidth, self.thumbView.frame.size.height );
				    self.backgroundView.backgroundColor = self.inactiveColor;
			    }

			    self.backgroundView.layer.borderColor = self.borderColor.CGColor;
			    self.thumbView.backgroundColor        = self.thumbTintColor;
			    self.onImageView.alpha                = 0;
			    self.offImageView.alpha               = 1.0;
			    self.onLabel.alpha                    = 0;
			    self.offLabel.alpha                   = 1.0;

			}
		    completion:^( BOOL finished ) {
			    self.isAnimating = NO;
			}];
	}
	else
	{
		if ( self.tracking )
		{
			self.thumbView.frame                = CGRectMake( 1, self.thumbView.frame.origin.y, activeKnobWidth, self.thumbView.frame.size.height );
			self.backgroundView.backgroundColor = self.activeColor;
		}
		else
		{
			self.thumbView.frame                = CGRectMake( 1, self.thumbView.frame.origin.y, normalKnobWidth, self.thumbView.frame.size.height );
			self.backgroundView.backgroundColor = self.inactiveColor;
		}
		self.backgroundView.layer.borderColor = self.borderColor.CGColor;
		self.thumbView.backgroundColor        = self.thumbTintColor;
		self.onImageView.alpha                = 0;
		self.offImageView.alpha               = 1.0;
		self.onLabel.alpha                    = 0;
		self.offLabel.alpha                   = 1.0;
	}

	self.currentVisualValue = NO;
}

@end
