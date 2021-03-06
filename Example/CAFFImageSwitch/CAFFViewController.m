//
//  CAFFViewController.m
//  CAFFImageSwitch
//
//  Created by Lluís Ulzurrun de Asanza i Sàez on 09/16/2015.
//  Copyright (c) 2015 Lluís Ulzurrun de Asanza i Sàez. All rights reserved.
//

#import "CAFFViewController.h"

#import <CAFFImageSwitch/CAFFImageSwitch.h>

@interface CAFFViewController ()

@end

@implementation CAFFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ibSwitch.onTintColor = [UIColor colorWithRed:0.20f green:0.42f blue:0.86f alpha:1.00f];
    self.ibSwitch.on = YES;
    
    // this will create the switch with default dimensions, you'll still need to set the position though
    // you also have the option to pass in a frame of any size you choose
    CAFFImageSwitch *mySwitch = [[CAFFImageSwitch alloc] initWithFrame:CGRectZero];
    mySwitch.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch];
    
    // turn the switch on
    mySwitch.on = YES;
    
    // Example of a bigger switch with images
    CAFFImageSwitch *mySwitch2 = [[CAFFImageSwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    mySwitch2.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 - 80);
    [mySwitch2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    mySwitch2.offImage = [UIImage imageNamed:@"cross.png"];
    mySwitch2.onImage = [UIImage imageNamed:@"check.png"];
    mySwitch2.onTintColor = [UIColor colorWithHue:0.08f saturation:0.74f brightness:1.00f alpha:1.00f];
    mySwitch2.rounded = NO;
    [self.view addSubview:mySwitch2];
    
    // turn the switch on with animation
    [mySwitch2 setOn:YES animated:YES];
    
    // Example of color customization
    CAFFImageSwitch *mySwitch3 = [[CAFFImageSwitch alloc] initWithFrame:CGRectZero];
    mySwitch3.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 + 70);
    [mySwitch3 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch3];
    
    //self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
    mySwitch3.thumbTintColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
    mySwitch3.activeColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
    mySwitch3.inactiveColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
    mySwitch3.onTintColor = [UIColor colorWithRed:0.45f green:0.58f blue:0.67f alpha:1.00f];
    mySwitch3.borderColor = [UIColor clearColor];
    mySwitch3.shadowColor = [UIColor blackColor];
}

- (void)switchChanged:(CAFFImageSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
}

@end
