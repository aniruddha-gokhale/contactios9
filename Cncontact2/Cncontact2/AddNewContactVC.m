//
//  AddNewContactVC.m
//  Remy
//
//  Created by GDB Consultants on 29/04/16.
//  Copyright © 2016 GDB Consultants. All rights reserved.
//

#import "AddNewContactVC.h"
#import <Contacts/Contacts.h>
@interface AddNewContactVC ()

@end

@implementation AddNewContactVC
    

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstname.delegate=self;
    self.lastname.delegate=self;
    self.mobileno.delegate=self;
    self.email.delegate=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
    
}

- (IBAction)savecontact:(id)sender {
    
    // create contact store object
    CNContactStore *store = [[CNContactStore alloc]init];
    
    // create save request  object
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc]init];
    
    NSError *error;
    
    // create contact object
    CNMutableContact *contact = [[CNMutableContact alloc]init];
    [contact setGivenName:self.firstname.text];
    [contact setFamilyName:self.lastname.text];
    contact.phoneNumbers=[[NSArray alloc]initWithObjects:[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile value:[CNPhoneNumber phoneNumberWithStringValue:self.mobileno.text]], nil];
    contact.emailAddresses=[[NSArray alloc]initWithObjects:[CNLabeledValue labeledValueWithLabel:CNLabelWork value:self.email.text], nil];
    //contact.emailAddresses=[CNLabelWork]
    
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    [store executeSaveRequest:saveRequest error:&error];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)cancle:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
