//
//  UIFormattedLabel.m
//  IllustratorIPADApp
//
//  Created by antandbuffalo Mobility on 4/30/12.
//  Copyright (c) 2012 antandbuffalo. All rights reserved.
//

#import "UIFormattedLabel.h"

//Currency, Number, FormattedNumber, PhoneNumber, SSN, Percentage
#define kUIFormattedTextFieldTypeCurrency @"Currency"
#define kUIFormattedTextFieldTypeNumber @"Number"
#define kUIFormattedTextFieldTypeFormattedNumber @"FormattedNumber"
#define kUIFormattedTextFieldTypePhoneNumber @"PhoneNumber"
#define kUIFormattedTextFieldTypeSSN @"SSN"
#define kUIFormattedTextFieldTypePercentage @"Percentage"

@implementation UIFormattedLabel

@synthesize numberOfDecimalPlaces;
@synthesize type;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        numberOfDecimalPlaces = 2;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        numberOfDecimalPlaces = 2;
    }
    return self;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        numberOfDecimalPlaces = 2;
    }
    return self;
}

-(void)setText:(NSString *)text
{
    if([type isEqualToString:kUIFormattedTextFieldTypeCurrency])
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:numberOfDecimalPlaces];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setLocale:[NSLocale currentLocale]];
        
        NSCharacterSet *numberWithDecimalSeparator = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@", @"0123456789", [numberFormatter decimalSeparator]]];
        NSCharacterSet *nonNumberSetWithOutDecimalSeparator = [numberWithDecimalSeparator invertedSet];    
        
        NSString *plainText = [[text stringByTrimmingCharactersInSet:nonNumberSetWithOutDecimalSeparator] stringByReplacingOccurrencesOfString:numberFormatter.groupingSeparator withString:@""];
        
        NSString *textWithCurrencySymbol = [NSString stringWithFormat:@"%@%@", numberFormatter.currencySymbol, plainText];
        
        NSNumber *number = [numberFormatter numberFromString:textWithCurrencySymbol];
        [super setText:[numberFormatter stringFromNumber:number]];
        numberFormatter = nil;
        //    text = [numberFormatter stringFromNumber:number];
    }
    else if([type isEqualToString:kUIFormattedTextFieldTypeFormattedNumber])
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:numberOfDecimalPlaces];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setLocale:[NSLocale currentLocale]];
        
        NSCharacterSet *numberWithDecimalSeparator = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@", @"0123456789", [numberFormatter decimalSeparator]]];
        NSCharacterSet *nonNumberSetWithOutDecimalSeparator = [numberWithDecimalSeparator invertedSet];    
        
        NSString *plainText = [[text stringByTrimmingCharactersInSet:nonNumberSetWithOutDecimalSeparator] stringByReplacingOccurrencesOfString:numberFormatter.groupingSeparator withString:@""];
        
        NSNumber *number = [numberFormatter numberFromString:plainText];
        [super setText:[numberFormatter stringFromNumber:number]];
        numberFormatter = nil;
    }
    else if([type isEqualToString:kUIFormattedTextFieldTypePhoneNumber])
    {
        NSCharacterSet *numberWithSeparator = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *nonNumberSetWithOutSeparator = [numberWithSeparator invertedSet];  
        
        NSString *plainText = [text stringByTrimmingCharactersInSet:nonNumberSetWithOutSeparator];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"-" withString:@""];
        //        NSLog(@"plain %@", plainText);
        NSMutableString *currentMText = [plainText mutableCopy];
        
        for (int i=0; i<currentMText.length; i++)
        {
            if(i == 3 || i == 7)
            {
                [currentMText insertString:@"-" atIndex:i];                                
            }            
        }
        
        [super setText:currentMText];
    }
    else if([type isEqualToString:kUIFormattedTextFieldTypeNumber])
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:numberOfDecimalPlaces];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setLocale:[NSLocale currentLocale]];
        
        NSCharacterSet *numberWithDecimalSeparator = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@", @"0123456789", [numberFormatter decimalSeparator]]];
        NSCharacterSet *nonNumberSetWithOutDecimalSeparator = [numberWithDecimalSeparator invertedSet];    
        
        NSString *plainText = [[text stringByTrimmingCharactersInSet:nonNumberSetWithOutDecimalSeparator] stringByReplacingOccurrencesOfString:numberFormatter.groupingSeparator withString:@""];
        
        [super setText:plainText];
        numberFormatter = nil;
    }    
    else if([type isEqualToString:kUIFormattedTextFieldTypeSSN])
    {
        NSCharacterSet *numberWithSeparator = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *nonNumberSetWithOutSeparator = [numberWithSeparator invertedSet];  
        
        NSString *plainText = [text stringByTrimmingCharactersInSet:nonNumberSetWithOutSeparator];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"-" withString:@""];
        //        NSLog(@"plain %@", plainText);
        NSMutableString *currentMText = [plainText mutableCopy];
        
        for (int i=0; i<currentMText.length; i++)
        {
            if(i == 3 || i == 6)
            {
                [currentMText insertString:@"-" atIndex:i];                                
            }            
        }
        
        [super setText:currentMText];        
    }
    else if ([type isEqualToString:kUIFormattedTextFieldTypePercentage])
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:numberOfDecimalPlaces];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setLocale:[NSLocale currentLocale]];
        
        NSCharacterSet *numberWithDecimalSeparator = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@", @"0123456789", [numberFormatter decimalSeparator]]];
        NSCharacterSet *nonNumberSetWithOutDecimalSeparator = [numberWithDecimalSeparator invertedSet];    
        
        NSLog(@"actual %@", text);        
        NSString *plainText = [[text stringByTrimmingCharactersInSet:nonNumberSetWithOutDecimalSeparator] stringByReplacingOccurrencesOfString:numberFormatter.groupingSeparator withString:@""];
        NSLog(@"plain *%@*", plainText);
        
        //        NSString *textWithPercentSymbol = [NSString stringWithFormat:@"%@%@", plainText, numberFormatter.percentSymbol];
        //        NSLog(@"sym %@", textWithPercentSymbol);        
        
        NSNumber *number = [numberFormatter numberFromString:plainText];
        NSLog(@"num %f", [number floatValue]);                
        
        [super setText:[numberFormatter stringFromNumber:number]];
        numberFormatter = nil;
    }    
    /*    
     else if ([type isEqualToString:@"Email"])
     {
     NSError *error = NULL;
     NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[+\\w\\.\\-']+@[a-zA-Z0-9-]+(\\.[a-zA-Z]{2,})+$" options:NSRegularExpressionCaseInsensitive error:&error];
     NSUInteger numberOfMatches = [regex numberOfMatchesInString:text options:0 range:NSMakeRange(0, text.length)];
     
     if(numberOfMatches == 1)
     {
     isValid = YES;
     }
     else
     {
     isValid = NO;
     }
     [super setText:text];        
     } 
     */ 
    else
    {
        [super setText:text];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
