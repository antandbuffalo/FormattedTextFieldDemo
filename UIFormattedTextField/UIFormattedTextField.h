//
//  CICSUICurrencyTextField.h
//  CICSurveyorIPAD
//
//  Created by antandbuffalo Mobility on 3/28/12.
//  Copyright (c) 2012 antandbuffalo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFormattedTextField : UITextField
{
    NSUInteger numberOfDecimalPlaces;
    NSString *type;    //Currency, Number, FormattedNumber, PhoneNumber, SSN, Percentage
    NSString *formatPattern;
}

@property(nonatomic, strong) NSString *formatPattern;
@property(nonatomic, strong) NSString *type;
@property(nonatomic) NSUInteger numberOfDecimalPlaces;

-(void)setText:(NSString *)text;
-(NSString *)plainText;

-(BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
