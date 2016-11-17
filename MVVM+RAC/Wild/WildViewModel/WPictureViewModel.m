//
//  WPictureVIewModel.m
//  MVVM+RAC
//
//  Created by hzl on 2016/11/11.
//  Copyright © 2016年 hzl. All rights reserved.
//

#import "WPictureViewModel.h"
#import "HTTP_CNNECT.h"
#import <AFNetworking/AFNetworking.h>
#import "WildModel.h"

@interface WPictureViewModel ()

@property (nonatomic, assign) NSInteger loadCode;

@end

@implementation WPictureViewModel


- (instancetype)init {
    if (self = [super init]) {
        [self initBind];
    }
    return self;
}

- (void)initBind {
    _CMD_Picture_URL = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *input) {
        
        if ([input integerValue] == 1) {
            _loadCode = 0;
        }
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:PICTURE_URL, _loadCode] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               
                //-----------------------------------
                NSMutableArray<WildModel *> *modelArray = [NSMutableArray arrayWithCapacity:20];
                _loadCode = [responseObject[@"info"][@"np"] integerValue];
                NSArray *tempArray = responseObject[@"list"];
                for (NSDictionary *tempDict in tempArray) {
                    WildModel *model = [[WildModel alloc] init];
                    
                    model.text = tempDict[@"text"];
                    model.type = tempDict[@"type"];
                    model.share_url = tempDict[@"share_url"];
                    model.Id = tempDict[@"id"];
                    model.passtime = tempDict[@"passtime"];
                    
                    NSArray *tagArray = tempDict[@"tags"];
                    for (NSDictionary *tagDict in tagArray) {
                        [model.tags addObject:tagDict[@"name"]];
                    }
                    
                    model.content = tempDict[@"top_comment"][@"content"];
                    model.name = tempDict[@"u"][@"name"];
                    model.headerIcon = [tempDict[@"u"][@"header"] firstObject];
                    
                    if ([model.type isEqualToString:@"image"]) {
                        NSDictionary *imageDict = tempDict[@"image"];
                        model.image_big = [imageDict[@"big"] firstObject];
                        model.image_medium = [imageDict[@"medium"] firstObject];
                        model.image_small = [imageDict[@"small"] firstObject];
                        model.width = [imageDict[@"width"] integerValue];
                        model.height = [imageDict[@"height"] integerValue];
                    } else if ([model.type isEqualToString:@"gif"]) {
                        
                        NSDictionary *imageDict = tempDict[@"gif"];
                        model.gif = [imageDict[@"images"] firstObject];
                        model.gif_image = [imageDict[@"gif_thumbnail"]firstObject];
                        model.width = [imageDict[@"width"] integerValue];
                        model.height = [imageDict[@"height"] integerValue];
                        
                    } else if ([model.type isEqualToString:@"text"]) {
                        
                        
                        
                    } else if ([model.type isEqualToString:@"video"]) {
                        
                        NSDictionary *imageDict = tempDict[@"video"];
                        model.video = [imageDict[@"video"] firstObject];
                        model.video_image = [imageDict[@"thumbnail"] firstObject];
                        model.width = [imageDict[@"width"] integerValue];
                        model.height = [imageDict[@"height"] integerValue];
                        
                    } else {
                        NSLog(@"loadData error");
                    }
                    
                    [modelArray addObject:model];
                }
                //-----------------------------------
                
                [subscriber sendNext:modelArray];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendError:error];
                [subscriber sendCompleted];
            }];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"picture_url_rac disposable");
            }];
        }];
        
    }];
}

@end
