//
//  BBDownloaderOperationManager.h
//  BBSDWebImage
//
//  Created by 王二 on 17/4/18.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 下载操作管理类
 */
@interface BBDownloaderOperationManager : NSObject

//单列
+ (instancetype)sharedManager;
//下载图片
- (void)downloadWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *image))finishedBlock;

//取消操作
- (void)cancelOperation:(NSString *)urlString;

@end
