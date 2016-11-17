//
//  PathTools.m
//  MVVM+RAC
//
//  Created by hzl on 2016/11/16.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import "PathTools.h"

@implementation PathTools

+ (NSString *)dateBasePathFile {
    
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"date_m.db"];
}

@end
