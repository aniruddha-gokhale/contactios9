//
//  AddNewContactVC.h
//  Remy
//
//  Created by GDB Consultants on 29/04/16.
//  Copyright © 2016 GDB Consultants. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewContactVC : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UITextField *mobileno;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)savecontact:(id)sender;
- (IBAction)cancle:(id)sender;

@end
