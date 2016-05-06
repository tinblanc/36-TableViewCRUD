//
//  Person.m
//  TableViewCRUD
//
//  Created by Tin Blanc on 4/28/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "Person.h"

@implementation Person

NSArray* firstNames;
NSArray* lastNames;




-(id) init {
    

    static dispatch_once_t dispatch_Once;
    
    // Chỉ chạy duy nhất 1 lần trong chương trình, những lần init khác ko gọi đến
    dispatch_once(&dispatch_Once, ^{
        firstNames = @[@"Adams", @"John", @"Blake", @"Jack", @"Anna", @"Marry", @"Mariana", @"Henry", @"Madonna", @"Elvis", @"Jacko", @"Kenedy"];
        lastNames = @[@"Tale", @"Johnson", @"Nickson", @"Ducati", @"Monster", @"Vancuver",@"Montoya",@"Garcia", @"Malinois", @"Francesco", @"Cudicini", @"Philips",@"Mecina"];
    });
    
    if (self = [super init]) {
        // name được random bởi 2 mảng firstname và lastname
        _name = [NSString stringWithFormat:@"%@ %@", firstNames[arc4random_uniform((int)firstNames.count)],lastNames[arc4random_uniform((int) lastNames.count)]];
        _age = 4 + arc4random_uniform(80);
    }
    
    return self;
    
}


-(instancetype) initName:(NSString *)name andAge:(int)age {
    if (self == [super init]) {
        _name = name;
        _age = age;
    }
    return self;
}

@end
