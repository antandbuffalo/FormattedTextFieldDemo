//
//  UIFormattedLabel.h
//  IllustratorIPADApp
//
//  Created by antandbuffalo Mobility on 4/30/12.
//  Copyright (c) 2012 antandbuffalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFormattedLabel : UILabel
{
    NSString *type; //Currency, Number, FormattedNumber, PhoneNumber, SSN, Percentage
    int numberOfDecimalPlaces;
}

@property(nonatomic, assign) int numberOfDecimalPlaces;
@property(nonatomic, retain) NSString *type;

-(void)setText:(NSString *)text;

@end
