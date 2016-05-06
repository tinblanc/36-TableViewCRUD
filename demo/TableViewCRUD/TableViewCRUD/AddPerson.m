//
//  AddPerson.m
//  TableViewCRUD
//
//  Created by Tin Blanc on 4/29/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "AddPerson.h"
#import "UIColor+Extend.h"
#import "Person.h"


@implementation AddPerson {

    Person* person;
    BOOL validFirstname, validLastname, validAge;
}



-(void) viewDidLoad {
    [super viewDidLoad];
    
    _txtFirstname.delegate = self;
    _txtLastname.delegate = self;
    _txtAge.delegate = self;
    
    validFirstname = false;
    validLastname = false;
    validAge = false;

    // draw line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 130, self.view.bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(15, 190, self.view.bounds.size.width, 0.5)];
    lineView1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 252, self.view.bounds.size.width, 0.5)];
    lineView2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView2];

    
    // Set Title for Navigation bar
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"CREATE", @"");
    [label sizeToFit];
    
    
    // Button Create
    UIButton* btnCreate = [[UIButton alloc] initWithFrame:CGRectMake(15, 5, 65, 30)];
    [btnCreate addTarget:self action:@selector(onCreate) forControlEvents:UIControlEventTouchUpInside];
    
    btnCreate.layer.borderWidth = 0.5;
    btnCreate.layer.borderColor = [[[UIColor alloc] initWithHex:@"c26d88" alpha:1.0] CGColor];
    btnCreate.layer.cornerRadius = 3.0;
    btnCreate.backgroundColor = [[UIColor alloc] initWithHex:@"ea5a6f" alpha:1.0];
    [btnCreate setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btnCreate setTitle:@"Create" forState:UIControlStateNormal];
    btnCreate.titleLabel.font = [UIFont systemFontOfSize:14.0];;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnCreate];
    
    
    
}


-(void) onCreate {
    
    
    if (!validFirstname) {
        _lblMessageFN.text = @"*";
        
    }
    
    if (!validLastname) {
        _lblMessageLN.text = @"*";
        
    }
    
    if (!validAge) {
        _lblMessageAge.text = @"*";
    }
    

    if (validFirstname && validLastname && validAge) {
        
        NSString* name = [NSString stringWithFormat:@"%@ %@", _txtFirstname.text, _txtLastname.text];
        
        NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:name  forKey:@"name"];
        [userInfo setObject:[NSNumber numberWithInt:[_txtAge.text intValue]] forKey:@"age"];
      
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"PersonPopped" object:self userInfo:userInfo];
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *inputString = [textField.text stringByReplacingCharactersInRange: range withString: string];
    
    // do not the first character to be space
    if ([string isEqualToString:@" "]) {
        if (!textField.text.length) {
            return NO;
        }
    }
  
    // Check Firstname
    if (textField == _txtFirstname) {
        
        // Check empty
        if (inputString.length > 0) {
            _lblMessageFN.text = nil;
            validFirstname = true;
        }else{
            _lblMessageFN.text = @"*";
            validFirstname = false;
        }
        
    }
    
    
    // Check Lastname
    if (textField == _txtLastname) {

        if (inputString.length > 0) {
            _lblMessageLN.text = nil;
            validLastname = true;
        }else {
            _lblMessageLN.text = @"*";
            validLastname = false;
        }
        
    }
    
    // Check Age
    if (textField == _txtAge) {
        
        if (inputString.length > 0) {
            
            // Check number
            int val;
            NSScanner *scan = [NSScanner scannerWithString: inputString];
            if ([scan scanInt: &val] && [scan isAtEnd]) {
                if ([inputString intValue]> 0 && [inputString intValue] < 120) {
                    _lblMessageAge.text = nil;
                    validAge = true;
                }else{
                    _lblMessageAge.text = @"*";
                    validAge = false;

                }
            }else {
                _lblMessageAge.text = @"*";
                validAge = false;
            }

            
        }else {
            _lblMessageAge.text = @"*";
            validAge = false;
        }
        
        
        
    }
    

    return YES;
}




//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//   
//    cell.labelLeft.text = arrayLabel[indexPath.row];
//    cell.txtMid.placeholder = arrayTextField[indexPath.row];
//    cell.labelRequire.text = @"*";
//    cell.txtMid.delegate = self;
//    cell.txtMid.tag = 100 + indexPath.row;
//    
////    cell.labelRequire.tag =
//    return cell;
//    
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"123");
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 55;
//}

@end



























