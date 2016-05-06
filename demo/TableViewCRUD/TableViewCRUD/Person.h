//
//  Person.h
//  TableViewCRUD
//
//  Created by Tin Blanc on 4/28/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property ( nonatomic, readonly) NSString* name;
@property ( nonatomic, readonly) int age;

-(instancetype) initName:(NSString*) name andAge:(int) age;
@end
