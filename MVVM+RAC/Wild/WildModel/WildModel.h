//
//  WildModel.h
//  MVVM+RAC
//
//  Created by hzl on 2016/11/14.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import "BasicModel.h"

@interface WildModel : BasicModel

@property (nonatomic, copy) NSString *headerIcon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *passtime;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, copy) NSString *gif;
@property (nonatomic, copy) NSString *gif_image;

@property (nonatomic, copy) NSString *image_small;
@property (nonatomic, copy) NSString *image_big;
@property (nonatomic, copy) NSString *image_medium;

@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *video_image;

@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy) NSString *type;

@end
