//
//  CICSUICurrencyTextField.m
//  CICSurveyorIPAD
//
//  Created by antandbuffalo Mobility on 3/28/12.
//  Copyright (c) 2012 antandbuffalo. All rights reserved.
//

#import "UIFormattedTextField.h"

@implementation UIFormattedTextField

@synthesize formatPattern;
@synthesize type;
@synthesize numberOfDecimalPlaces;

//Currency, Number, FormattedNumber, PhoneNumber, SSN, Percentage
#define kUIFormattedTextFieldTypeCurrency @"Currency"
#define kUIFormattedTextFieldTypeNumber @"Number"
#define kUIFormattedTextFieldTypeFormattedNumber @"FormattedNumber"
#define kUIFormattedTextFieldTypePhoneNumber @"PhoneNumber"
#define kUIFormattedTextFieldTypeSSN @"SSN"
#define kUIFormattedTextFieldTypePercentage @"Percentage"
#define kUIFormattedTextFieldTypeDynamic @"Dynamic"


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



-(BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([type isEqualToString:kUIFormattedTextFieldTypeCurrency])
    {
        BOOL returnValue = NO; 
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:numberOfDecimalPlaces];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setLocale:[NSLocale currentLocale]];
        
        // the appropriate decimalSeperator and currencySymbol for the current locale
        // can be found with help of the
        // NSNumberFormatter and NSLocale classes.
        
        NSCharacterSet *numberWithDecimalSeparator = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@", @"0123456789", [numberFormatter decimalSeparator]]];
        NSCharacterSet *nonNumberSetWithOutDecimalSeparator = [numberWithDecimalSeparator invertedSet];    
        
        NSString *currentText = [self text];
        
        NSMutableString *currentMText = [currentText mutableCopy];
        
        if([string stringByTrimmingCharactersInSet:nonNumberSetWithOutDecimalSeparator].length <= 0) //not a number
        {
            if(string.length == 0)  //backspace
            {
                [currentMText deleteCharactersInRange:range];
                if([currentMText rangeOfString:@"."].length)
                {
                    numberFormatter = nil;
                    return YES;
                }
                //            [currentMText insertString:@"" atIndex:range.location];
                returnValue = NO;
            }
            else
            {
                returnValue = NO;
            }
        }
        else    //a number or dot
        {
            if([string isEqualToString:@"."])   //dot entered
            {
                if([currentMText rangeOfString:@"."].length) //if dot present already
                {
                    numberFormatter = nil;
                    return NO;
                    //                returnValue = NO;
                }
                else
                {
                    [currentMText insertString:string atIndex:range.location];
                    numberFormatter = nil;
                    return YES;
                    //                returnValue = NO;
                }
            }
            else    //number entered
            {
                if([string isEqualToString:@"0"])   // 0 is entered
                {
                    if([currentMText rangeOfString:@"."].length) //if dot present already then no formatting
                    {
                        numberFormatter = nil;                        
                        return YES;
                    }
                }
                
                [currentMText insertString:string atIndex:range.location];  //inserting entered text
                
                //cleaning the string
                currentMText = [[[currentMText stringByTrimmingCharactersInSet:nonNumberSetWithOutDecimalSeparator] stringByReplacingOccurrencesOfString:numberFormatter.currencyGroupingSeparator withString:@""] mutableCopy];
                
                if([currentMText rangeOfString:numberFormatter.currencySymbol].length == 0)
                {
                    [currentMText insertString:numberFormatter.currencySymbol atIndex:0];            
                }                
                
                NSNumber *number = [numberFormatter numberFromString:currentMText];
                currentMText = [[numberFormatter stringFromNumber:number] mutableCopy];
                NSLog(@"number %@", [numberFormatter stringFromNumber:number]);    
                
                returnValue = NO;
            }
        }
        
        self.text = currentMText;
        numberFormatter = nil;
        return returnValue; 
    }
    else if([type isEqualToString:kUIFormattedTextFieldTypeFormattedNumber])
    {
        BOOL returnValue = NO; 
                
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:numberOfDecimalPlaces];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setLocale:[NSLocale currentLocale]];
        
        NSCharacterSet *numberWithDecimalSeparator = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@", @"0123456789", [numberFormatter decimalSeparator]]];
        NSCharacterSet *nonNumberSetWithOutDecimalSeparator = [numberWithDecimalSeparator invertedSet];                    
        
        NSString *currentText = [self text];
        
        NSMutableString *currentMText = [currentText mutableCopy];
        
        if([string stringByTrimmingCharactersInSet:nonNumberSetWithOutDecimalSeparator].length <= 0) //not a number
        {
            if(string.length == 0)  //backspace
            {
                [currentMText deleteCharactersInRange:range];
                if([currentMText rangeOfString:@"."].length)
                {
                    numberFormatter = nil;
                    return YES;
                }                
                returnValue = NO;
            }
            else
            {
                returnValue = NO;
            }
        }
        else
        {
            if([string isEqualToString:@"."])   //dot entered
            {
                if([currentMText rangeOfString:@"."].length) //if dot present already
                {
                    numberFormatter = nil;
                    return NO;
                    //                returnValue = NO;
                }
                else
                {
                    numberFormatter = nil;
                    return YES;
                    //                returnValue = NO;
                }
            }
            else    //number entered
            {
                if([string isEqualToString:@"0"])   // 0 is entered
                {
                    if([currentMText rangeOfString:@"."].length) //if dot present already then no formatting
                    {
                        numberFormatter = nil;                        
                        return YES;
                    }
                }
                [currentMText insertString:string atIndex:range.location];  //inserting entered text            
            }
        }
        
        self.text = currentMText;
        numberFormatter = nil;
        return returnValue;         
        
        // the appropriate decimalSeperator and currencySymbol for the current locale
        // can be found with help of the
        // NSNumberFormatter and NSLocale classes.
    }
    else if([type isEqualToString:kUIFormattedTextFieldTypePhoneNumber])
    {
        BOOL returnValue = NO; 
                
        NSCharacterSet *numberWithSeparator = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *nonNumberSetWithOutSeparator = [numberWithSeparator invertedSet];                    
        
        NSString *currentText = [self text];
        
        NSMutableString *currentMText = [currentText mutableCopy];
        
        if([string stringByTrimmingCharactersInSet:nonNumberSetWithOutSeparator].length <= 0) //not a number
        {
            if(string.length == 0)  //backspace
            {
                [currentMText deleteCharactersInRange:range];
                returnValue = NO;
            }
            else
            {
                returnValue = NO;
            }
        }
        else
        {
            if(currentMText.length > 11)
            {
                returnValue = NO;
            }
            else
            {
                [currentMText insertString:string atIndex:range.location];  //inserting entered text                            
            }
        }
        
        self.text = currentMText;
        return returnValue;
    }
    else if ([type isEqualToString:kUIFormattedTextFieldTypeNumber])
    {
        BOOL returnValue = NO; 
                
        NSCharacterSet *numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *nonNumberSet = [numberSet invertedSet];                    
        
        NSString *currentText = [self text];
        
        NSMutableString *currentMText = [currentText mutableCopy];
        
        if([string stringByTrimmingCharactersInSet:nonNumberSet].length <= 0) //not a number
        {
            if(string.length == 0)  //backspace
            {
                [currentMText deleteCharactersInRange:range];
                returnValue = NO;
            }
            else
            {
                returnValue = NO;
            }
        }
        else
        {
            [currentMText insertString:string atIndex:range.location];  //inserting entered text            
        }
        
        self.text = currentMText;
        return returnValue;                 
    }
    else if ([type isEqualToString:kUIFormattedTextFieldTypeSSN])
    {
        BOOL returnValue = NO; 
        
        NSCharacterSet *numberWithSeparator = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *nonNumberSetWithOutSeparator = [numberWithSeparator invertedSet];                    
        
        NSString *currentText = [self text];
        
        NSMutableString *currentMText = [currentText mutableCopy];
        
        if([string stringByTrimmingCharactersInSet:nonNumberSetWithOutSeparator].length <= 0) //not a number
        {
            if(string.length == 0)  //backspace
            {
                [currentMText deleteCharactersInRange:range];
                returnValue = NO;
            }
            else
            {
                returnValue = NO;
            }
        }
        else
        {
            if(currentMText.length > 10)
            {
                returnValue = NO;
            }
            else
            {
                [currentMText insertString:string atIndex:range.location];  //inserting entered text                            
            }
        }
        
        self.text = currentMText;
        return returnValue;        
    }
    else if ([type isEqualToString:kUIFormattedTextFieldTypePercentage])
    {
        BOOL returnValue = NO; 
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:numberOfDecimalPlaces];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setLocale:[NSLocale currentLocale]];
                
        NSCharacterSet *numberWithDecimalSeparator = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@", @"0123456789", [numberFormatter decimalSeparator]]];
        NSCharacterSet *nonNumberSetWithOutDecimalSeparator = [numberWithDecimalSeparator invertedSet];    
        
        NSString *currentText = [self text];
        
        NSMutableString *currentMText = [currentText mutableCopy];
        
        if([string stringByTrimmingCharactersInSet:nonNumberSetWithOutDecimalSeparator].length <= 0) //not a number
        {
            if(string.length == 0)  //backspace
            {
                [currentMText deleteCharactersInRange:range];
                if([currentMText rangeOfString:@"."].length)
                {
                    numberFormatter = nil;
                    return YES;
                }                                
                //            [currentMText insertString:@"" atIndex:range.location];
                returnValue = NO;
            }
            else
            {
                returnValue = NO;
            }
        }
        else    //a number or dot
        {
            if([string isEqualToString:@"."])   //dot entered
            {
                if([currentMText rangeOfString:@"."].length) //if dot present already
                {
                    numberFormatter = nil;
                    return NO;
                    //                returnValue = NO;
                }
                else
                {
                    [currentMText insertString:string atIndex:range.location];
                    numberFormatter = nil;
                    return YES;
                    //                returnValue = NO;
                }
            }
            else    //number entered
            {
                if([string isEqualToString:@"0"])   // 0 is entered
                {
                    if([currentMText rangeOfString:@"."].length) //if dot present already then no formatting
                    {
                        numberFormatter = nil;                        
                        return YES;
                    }
                }                
                [currentMText insertString:string atIndex:range.location];  //inserting entered text
                if([currentMText floatValue] > 100)
                {
                    [currentMText deleteCharactersInRange:NSMakeRange(range.location, 1)];
                }
                returnValue = NO;
            }
        }
 
//        NSLog(@"cu %@", currentMText);
        self.text = currentMText;
        numberFormatter = nil;
        return returnValue; 
    }
/*    
    else if ([type isEqualToString:@"Email"])
    {
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[+\\w\\.\\-']+@[a-zA-Z0-9-]+(\\.[a-zA-Z]{2,})+$" options:NSRegularExpressionCaseInsensitive error:&error];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:[self text] options:0 range:NSMakeRange(0, [self text].length)];
        
        return numberOfMatches == 1;
    }    
*/ 
    else if ([type isEqualToString:kUIFormattedTextFieldTypeDynamic])
    {
        BOOL returnValue = NO; 
        
        NSCharacterSet *numberWithSeparator = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *nonNumberSetWithOutSeparator = [numberWithSeparator invertedSet];                    
        
        NSString *currentText = [self text];
        
        NSMutableString *currentMText = [currentText mutableCopy];
        
        if([string stringByTrimmingCharactersInSet:nonNumberSetWithOutSeparator].length <= 0) //not a number
        {
            if(string.length == 0)  //backspace
            {
                [currentMText deleteCharactersInRange:range];
                returnValue = NO;
            }
            else
            {
                returnValue = NO;
            }
        }
        else
        {
            if(currentMText.length >= [formatPattern length])
            {
                returnValue = NO;
            }
            else
            {
                [currentMText insertString:string atIndex:range.location];  //inserting entered text                            
            }
        }    
        self.text = currentMText;
        return returnValue;                
    }
    else
    {
        return YES;
    }
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
    else if ([type isEqualToString:kUIFormattedTextFieldTypeDynamic])
    {
        NSCharacterSet *numberWithSeparator = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *nonNumberSetWithOutSeparator = [numberWithSeparator invertedSet];  
        
        NSString *plainText = [text stringByTrimmingCharactersInSet:nonNumberSetWithOutSeparator];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSMutableString *currentMText = [plainText mutableCopy];
        NSMutableString *targetString = [NSMutableString string];
        
        int j=0;
        for(int i=0; i<currentMText.length; i++)
        {
            if([[formatPattern substringWithRange:NSMakeRange(j, 1)] isEqualToString:@"x"])
            {
                [targetString insertString:[currentMText substringWithRange:NSMakeRange(i, 1)] atIndex:j];
            }
            else 
            {
                [targetString insertString:@"-" atIndex:j++];
                [targetString insertString:[currentMText substringWithRange:NSMakeRange(i, 1)] atIndex:j];                                
            }
            j++;
        }
        [super setText:targetString];
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

-(NSString *)plainText
{
    if([type isEqualToString:kUIFormattedTextFieldTypeCurrency] || [type isEqualToString:kUIFormattedTextFieldTypeNumber] || [type isEqualToString:kUIFormattedTextFieldTypeFormattedNumber] || [type isEqualToString:kUIFormattedTextFieldTypePhoneNumber] || [type isEqualToString:kUIFormattedTextFieldTypeSSN] || [type isEqualToString:kUIFormattedTextFieldTypePercentage] || [type isEqualToString:kUIFormattedTextFieldTypeDynamic])
    {
        NSString *tempText = [super text];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:numberOfDecimalPlaces];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setLocale:[NSLocale currentLocale]];
        
        
        NSCharacterSet *numberWithDecimalSeparator = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@", @"0123456789", [numberFormatter decimalSeparator]]];
        NSCharacterSet *nonNumberSetWithOutDecimalSeparator = [numberWithDecimalSeparator invertedSet];    
        
        tempText = [tempText stringByTrimmingCharactersInSet:nonNumberSetWithOutDecimalSeparator];
        
        tempText = [tempText stringByReplacingOccurrencesOfString:numberFormatter.currencySymbol withString:@""];
        tempText = [tempText stringByReplacingOccurrencesOfString:numberFormatter.groupingSeparator withString:@""];
        tempText = [tempText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        tempText = [tempText stringByReplacingOccurrencesOfString:@"-" withString:@""];
        numberFormatter = nil;
        
        return tempText;    
    }
    else
    {
        return [self text];
    }
}

/*
-(NSString *)text
{
    NSString *tempText = [super text];
    NSCharacterSet *numberWithDot = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    NSCharacterSet *nonNumberSetWithOutDot = [numberWithDot invertedSet];
    tempText = [tempText stringByTrimmingCharactersInSet:nonNumberSetWithOutDot];
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    tempText = [tempText stringByReplacingOccurrencesOfString:[currentLocale objectForKey:NSLocaleCurrencySymbol] withString:@""];
    tempText = [tempText stringByReplacingOccurrencesOfString:[currentLocale objectForKey:NSLocaleGroupingSeparator] withString:@""];
    return tempText;
}
*/

@end
