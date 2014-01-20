How to use the component in your project:

1. Drag and drop the “UIFormattedTextField.h” and “UIFormattedTextField.m” files to your project.

2. Import the header in your class, where do you want to use it.

#import “UIFormattedTextField.h”

3. If you are using xib or storyboard, change the class of the text field in the “Identity inspector” to UIFormattedTextField.

4. Create an instance variable to access the text field.

IBOutlet UIFormattedTextField *currency;

5. Set the type and delegate of the text field. Don’t forget to import the delegate <UITextFieldDelegate>

currency.type = @”Currency”;

currency.delegate = self;

currency.numberOfDecimalPlaces = 3;

6. You have to change the delegate function ,
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
return YES;
}

to

-(BOOL)textField:(UIFormattedTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
return [textField shouldChangeCharactersInRange:range replacementString:string];
}

7. You are done.
