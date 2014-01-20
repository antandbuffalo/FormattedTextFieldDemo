//
//  DemoViewController.m
//  FormattedTextFieldDemo
//
//  Created by antandbuffalo Mobility on 6/25/13.
//  Copyright (c) 2013 antandbuffalo. All rights reserved.
//

#import "DemoViewController.h"
#import "UIFormattedTextField.h"

@interface DemoViewController ()
{
    IBOutlet UIFormattedTextField *currency, *number, *formattedNumber, *ssn1, *percentage, *dynamic;
}

-(IBAction)airprint:(UIButton *)sender;

@end

@implementation DemoViewController

-(IBAction)airprint:(UIButton *)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"];
    NSData *dataFromPath = [NSData dataWithContentsOfFile:path];
    
    UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
    
    if(printController && [UIPrintInteractionController canPrintData:dataFromPath]) {
        
        printController.delegate = self;
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = [path lastPathComponent];
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        printController.printInfo = printInfo;
        printController.showsPageRange = YES;
        printController.printingItem = dataFromPath;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
            }
        };
        
        [printController presentAnimated:YES completionHandler:completionHandler];
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UIFormattedTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [textField shouldChangeCharactersInRange:range replacementString:string];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    currency.type = @"Currency";
    currency.delegate = self;
    currency.numberOfDecimalPlaces = 3;
    
    number.type = @"Number";
    number.delegate = self;
    
    formattedNumber.type = @"FormattedNumber";
    formattedNumber.delegate = self;
    formattedNumber.numberOfDecimalPlaces = 5;
        
    ssn1.type = @"SSN";
    ssn1.delegate = self;
    
    percentage.type = @"Percentage";
    percentage.delegate = self;
    
    dynamic.delegate = self;
    dynamic.type = @"Dynamic";
    dynamic.formatPattern = @"xxx-xxxx-x-xx";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
