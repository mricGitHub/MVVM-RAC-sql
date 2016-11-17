//
//  WildViewController.m
//  MVVM+RAC
//
//  Created by hzl on 2016/11/11.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import "WildViewController.h"
#import "WPictureViewModel.h"
#import "WildModel.h"
#import "DateManager.h"

@interface WildViewController ()

@property (nonatomic, strong) WPictureViewModel *pictureVM;
@property (nonatomic, strong) NSNumber *loadReset;// clearn the dataArray and reload :: YES -- NO
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation WildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self testDateManager];
}


- (void)loadData {
    
    [[self.pictureVM.CMD_Picture_URL execute:self.loadReset] subscribeNext:^(NSArray<WildModel *> *responder) {
       
        NSLog(@"%@", responder);
        self.loadReset = @(NO);
        
    }];
    
    
}

- (void)testDateManager {
    DateManager *manager = [DateManager sharedDateManager];
    [manager inDateBase:^(FMDatabase *db) {
       
        if (![db executeUpdate:@"CREATE TABLE IF NOT EXISTS table_wild(id text primary key,name text,age integer)"]) {
            NSLog(@"db open false");
        };
        
        if (![db executeUpdate:@"INSERT INTO table_wild(id,name,age) VALUES(?,?,?)", @"0612", @"hzl", @(24)]) {
            NSLog(@"insert false");
        }
        
        FMResultSet *set = [db executeQuery:@"SELECT *FROM table_wild WHERE id = ?", @"0612"];
        while ([set next]) {
            NSLog([NSString stringWithFormat:@"id = %@  name = %@  age = %ld", [set stringForColumn:@"id"], [set stringForColumn:@"name"], [set longForColumn:@"age"]], nil);
        }
        
        
    }];
}

#pragma mark - lazyLoading

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSNumber *)loadReset {
    if (!_loadReset) {
        _loadReset = @(NO);
    }
    return _loadReset;
}

- (WPictureViewModel *)pictureVM {
    if (!_pictureVM) {
        _pictureVM = [[WPictureViewModel alloc] init];
    }
    return _pictureVM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
