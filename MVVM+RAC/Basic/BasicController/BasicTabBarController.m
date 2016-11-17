//
//  BasicTabBarController.m
//  MVVM+RAC
//
//  Created by hzl on 2016/11/11.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import "BasicTabBarController.h"
#import "WildViewController.h"
#import "InterestVIewController.h"
#import "MineVIewController.h"

@interface BasicTabBarController ()

@end

@implementation BasicTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadControllers];
    
}

- (void)loadControllers {
    
    NSArray *titleArray = @[@"狂欢城", @"兴趣", @"我的"];
    NSArray *imageNameArray = @[@"狂欢城", @"兴趣", @"我的"];
    NSArray *selectedImageNameArray = @[@"狂欢城_on", @"兴趣_on", @"我的_on"];
    NSArray *classArray = @[[WildViewController class], [InterestVIewController class], [MineVIewController class]];
    
    NSMutableArray *navArray = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < classArray.count; i++) {
        BasicViewController *vc = [[classArray[i] alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [navArray addObject:nav];
    }
    
    self.viewControllers = navArray;
    
    for (NSInteger i = 0; i < self.tabBar.items.count; i++) {
        UIImage *image = [[UIImage imageNamed:imageNameArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:selectedImageNameArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = self.tabBar.items[i];
        item = [item initWithTitle:titleArray[i] image:image selectedImage:selectedImage];
        
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1]} forState:UIControlStateSelected];
    
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
