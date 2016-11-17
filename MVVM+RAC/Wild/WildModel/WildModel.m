//
//  WildModel.m
//  MVVM+RAC
//
//  Created by hzl on 2016/11/14.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import "WildModel.h"

@implementation WildModel

- (instancetype)init {
    if (self = [super init]) {
        _tags = [NSMutableArray array];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
