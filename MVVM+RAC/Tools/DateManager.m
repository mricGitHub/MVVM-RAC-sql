//
//  FMManager.m
//  MVVM+RAC
//
//  Created by hzl on 2016/11/16.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import "DateManager.h"
#import "PathTools.h"

static DateManager      *_sharedDateManager = 0x00;
static FMDatabaseQueue  *_queue             = 0x00;

@implementation DateManager

+ (instancetype)sharedDateManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_sharedDateManager == nil) {
            _sharedDateManager = [[DateManager alloc] init];
            NSString *datePath = [PathTools dateBasePathFile];// get dateBase filePath
            _queue = [FMDatabaseQueue databaseQueueWithPath:datePath];
        }
    });
    return _sharedDateManager;
    
}

+ (void)inDateBase:(void(^)(FMDatabase *db))block {
    if (_queue != nil) {
        [_queue inDatabase:block];
    } else {
        [DateManager sharedDateManager];
        [DateManager inDateBase:block];
    }
}

- (void)inDateBase:(void(^)(FMDatabase *db))block {
    if (_queue != nil) {
        [_queue inDatabase:block];
    } else {
        [DateManager sharedDateManager];
        [DateManager inDateBase:block];
    }
}

- (void)createTable:(NSString *)table_name {
    // 未完成的任务：用runtime 从model中获得属性加入到数据库中
    [self inDateBase:^(FMDatabase *db) {
        NSString *sql_str = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id text primary key,name text,age integer)", table_name];
        if (![db executeUpdate:sql_str]) {
            NSLog(@"db open false");
        };
    }];
    
}

- (void)insertTable:(NSString *)table_name andModel:(id)model {
    // 未完成的任务：用runtime 从model中获得属性加入到数据库中
    [self inDateBase:^(FMDatabase *db) {
        NSString *sql_str = [NSString stringWithFormat:@"INSERT INTO %@(id,name,age) VALUES(?,?,?)", table_name];
        if (![db executeUpdate:sql_str, @"0612", @"hzl", @(24)]) {
            NSLog(@"insert false");
        }
        
    }];
    
}

- (void)showTheTable:(NSString *)table_name andCondition:(id)condition {
    [self inDateBase:^(FMDatabase *db) {
        NSString *sql_str = [NSString stringWithFormat:@"SELECT *FROM %@ WHERE id = ?", table_name];
        FMResultSet *set = [db executeQuery:sql_str, @"0612"];
        while ([set next]) {
            NSLog([NSString stringWithFormat:@"id = %@  name = %@  age = %ld", [set stringForColumn:@"id"], [set stringForColumn:@"name"], [set longForColumn:@"age"]], nil);
        }
    }];
}

@end
