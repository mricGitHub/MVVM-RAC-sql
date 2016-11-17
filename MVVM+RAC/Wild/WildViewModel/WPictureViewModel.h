//
//  WPictureVIewModel.h
//  MVVM+RAC
//
//  Created by hzl on 2016/11/11.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import "BasicViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface WPictureViewModel : BasicViewModel

@property (nonatomic, strong, readonly) RACCommand *CMD_Picture_URL;

@end
