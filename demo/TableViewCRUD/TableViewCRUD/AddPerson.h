//
//  AddPerson.h
//  TableViewCRUD
//
//  Created by Tin Blanc on 4/29/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPerson : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;

@property (weak, nonatomic) IBOutlet UITextField *txtLastname;

@property (weak, nonatomic) IBOutlet UITextField *txtAge;

@property (weak, nonatomic) IBOutlet UILabel *lblMessageFN;

@property (weak, nonatomic) IBOutlet UILabel *lblMessageLN;

@property (weak, nonatomic) IBOutlet UILabel *lblMessageAge;


@end
