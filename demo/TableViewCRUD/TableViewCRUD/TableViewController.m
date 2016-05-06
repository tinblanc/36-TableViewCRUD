//
//  TableViewController.m
//  TableViewCRUD
//
//  Created by Tin Blanc on 4/28/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "TableViewController.h"
#import "Person.h"
#import "UIColor+Extend.h"
#import "AddPerson.h"

@interface TableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewController
{
    NSMutableArray* arrayData;
    UIView* viewAddPerson;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Set Title for Navigation bar
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"PERSON", @"");
    [label sizeToFit];
    
    // Set background for Navigation Bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithHex:@"33a5dd" alpha:1.0];
    
    
    
    arrayData = [[NSMutableArray alloc] initWithCapacity:5];
    
    
    for (int i = 0 ; i < 5; i++) {
        Person* personData = [[Person alloc] init];
        [arrayData addObject:personData];
    }
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_user"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(onAdd)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit_user"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onEdit)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(personData:)
                                                 name:@"PersonPopped"
                                               object:nil];
    
    
    
}

- (void) personData:(NSNotification *) notification
{
    
    NSDictionary* userInfo = notification.userInfo;
    int age = [[userInfo objectForKey:@"age"] intValue];
    NSString* name = [userInfo objectForKey:@"name"];
    
    Person* person = [[Person alloc] initName:name andAge:age];
    [arrayData addObject:person];
    [self.tableView reloadData];
    
    
    if (arrayData.count > 0 ) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit_user"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(onEdit)];
    }
    
}

#pragma mark - CRUD

// Add Row
-(void) onAdd {
//    Person* personData = [[Person alloc] init];
//    [arrayData addObject:personData];
//    
//    [self.tableView reloadData];
//    
//    if (arrayData.count > 0 ) {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit_user"]
//                                                                                 style:UIBarButtonItemStylePlain
//                                                                                target:self
//                                                                                action:@selector(onEdit)];
//    }
    
    AddPerson *addPersonVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPerson"];
    
    
    [self.navigationController pushViewController:addPersonVC animated:YES];
    
}






-(void) onEdit {
    
    if (self.tableView.editing) { // Nếu tableView đang ở trạng tháng Editing
        [self.tableView setEditing:false animated:YES]; // Chuyển trạng thái editing = false
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_user"]
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(onAdd)];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit_user"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(onEdit)];
        

    } else {
        [self.tableView setEditing:true animated:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete"]
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(onDelete)];
        
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(onEdit)];
    }
    }
    
    

-(void) onDelete {
    NSArray* selectedRows;
    selectedRows = self.tableView.indexPathsForSelectedRows; // Mảng này lưu trữ các chỉ số indexpath những row được chọn
    
    if (selectedRows.count > 0 ) { // có trên 1 cột được chọn
        NSMutableIndexSet* indicesOfItemsToDelete = [[NSMutableIndexSet alloc] init];
        
        for (NSIndexPath* selectedIndex in selectedRows) {
            [indicesOfItemsToDelete addIndex:selectedIndex.row]; // add các index row được chọn vào mang mutableArray
        }
        
        [arrayData removeObjectsAtIndexes:indicesOfItemsToDelete];
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic]; // xóa tất cả các Row được chọn với hiệu ứng Animation
    }
    
    if (arrayData.count == 0) {
        [self.tableView setEditing:false animated:YES];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_user"]
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(onAdd)];
        
    }
}


#pragma mark - TableViewDataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayData.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Person* personData = [[Person alloc] init];
    personData = arrayData[indexPath.row];
    cell.textLabel.text = personData.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", personData.age];

    return cell;
}


// Delete Row
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrayData removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
    }
}

// Move Row
-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    Person* person = [Person new];
    person = arrayData[sourceIndexPath.row] ; // gán giá trị cho person
    [arrayData removeObjectAtIndex:sourceIndexPath.row];
    [arrayData insertObject:person atIndex:destinationIndexPath.row];
}






@end
