//
//  BBDownloadOperation.h
//  BBSDWebImage
//
//  Created by 王二 on 17/4/18.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 自定义下载操作类
 */
@interface BBDownloadOperation : NSOperation

//下载图片的地址
@property(nonatomic,copy)NSString *urlString;

//执行完成任务之后的回调block
@property(nonatomic,copy)void (^finishedBlock)(UIImage *img);

/**
 构造器方法

 @param urlString     图片的地址
 @param finishedBlock 下载完成回调block

 @return 下载操作对象
 */
+ (instancetype)downloaderOperationWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *image))finishedBlock;

@end
