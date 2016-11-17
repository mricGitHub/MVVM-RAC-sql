//
//  FMManager.h
//  MVVM+RAC
//
//  Created by hzl on 2016/11/16.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface DateManager : NSObject

+ (instancetype)sharedDateManager;
+ (void)inDateBase:(void(^)(FMDatabase *db))block;
- (void)inDateBase:(void(^)(FMDatabase *db))block;
@end
