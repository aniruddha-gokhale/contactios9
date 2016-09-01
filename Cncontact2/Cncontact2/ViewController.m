//
//  ViewController.m
//  Cncontact2
//
//  Created by GDB Consultants on 13/04/16.
//  Copyright © 2016 GDB Technologies. All rights reserved.
//

#import "ViewController.h"
#import <Contacts/Contacts.h>

@interface ViewController ()

@end

@implementation ViewController{
    
    
}

-(NSMutableArray *) contactList{
    if(!_contactList){
        
        _contactList = [[NSMutableArray alloc]init];
    }
    return _contactList;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self fetchcontacts];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchcontacts{
    
    CNContactStore * store = [[CNContactStore alloc]init];
    NSArray * keytoFetch =@[CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey];
    NSError *err = nil;
    NSString *containerId = store.defaultContainerIdentifier;
    NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
    NSArray *arrFetchedRecord  = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keytoFetch error:&err];
    NSString *phone;
    NSMutableString *phonenumber;
    NSString *fullName;
    NSString *firstName;
    NSString *lastName;
    // NSMutableArray *contactNumbersArray=[[NSMutableArray alloc]init];
    self.contactList=nil;
    for (int i=0;i<arrFetchedRecord.count;i++) {
        
        CNContact *contact=[arrFetchedRecord objectAtIndex:i];
        
        firstName = contact.givenName;
        lastName =contact.familyName;
        if (lastName == nil) {
            fullName=[NSString stringWithFormat:@"%@",firstName];
            
        }else if (firstName == nil){
            fullName=[NSString stringWithFormat:@"%@",lastName];
        }
        else{
            fullName=[NSString stringWithFormat:@"%@ %@",firstName,lastName];
            
        }
        for (CNLabeledValue *label in contact.phoneNumbers) {
            phone = [label.value stringValue];
            
            phonenumber = [NSMutableString stringWithCapacity:phone.length];
            
            NSScanner *scanner = [NSScanner scannerWithString:phone];
            NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            
            while ([scanner isAtEnd] == NO)
            {
                NSString *buffer;
                if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
                {
                    [phonenumber appendString:buffer];
                }
                else
                {
                    [scanner setScanLocation:([scanner scanLocation] + 1)];
                }
            }
            
            if ([phonenumber length] > 0) {
                NSDictionary *personDict = [[NSDictionary alloc] initWithObjectsAndKeys: fullName,@"fullName",phonenumber,@"PhoneNumbers", nil];
                [self.contactList addObject:personDict];
            }
        }
        
    }
    // sort alphabetically
    [self.contactList sortUsingDescriptors:
     [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"fullName"
                                                            ascending:YES
                                                             selector:@selector(caseInsensitiveCompare:)]]];
    
    NSLog(@"%@",self.contactList);
    
    
        
}
        
        

    



@end
