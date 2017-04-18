//
//  BBDownloadOperation.m
//  BBSDWebImage
//
//  Created by 王二 on 17/4/18.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import "BBDownloadOperation.h"
#import "NSString+Path.h"

/**
 自定义下载操作类
 */
@implementation BBDownloadOperation

//重写main方法  操作添加到队列的时候会调用该方法
- (void)main{
    //创建自动释放池：因如果是异步操作，无法访问主线程的自动释放池
    @autoreleasepool {
        //断言
        //添加断言后，if (self.finishedBlock) 不用再设置，如果为空了，程序会崩溃，同时会提醒：finishedBlock不能为空
        NSAssert(self.finishedBlock != nil, @"finishedBlock不能为空");
        
        //下载网络图片
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        //缓存到沙盒中
        if (data) {
            [data writeToFile:[self.urlString appendCacheDir] atomically:YES];
        }
        //这里是子线程
        //NSLog(@"下载图片 %@ %@",self.urlString,[NSThread currentThread]);
        NSLog(@"从网络下载图片");
        
        //判断操作是否被取消
        //如果取消，直接return。放在耗时操作之后和合理一些，取消操作的时候，不会拦截耗时操作，耗时操作依然可以执行。下次想显示图像的时候，耗时操作也执行完毕
        if (self.isCancelled) {
            return;
        }
        //图片下载完成回到主线程更新UI  通过使用断言，这里就不用使用if (self.finishedBlock) 判断了
        //if (self.finishedBlock) {
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            UIImage *img = [UIImage imageWithData:data];
            self.finishedBlock(img);
        }];
        //}
        
    }
}

/**
 构造器方法
 
 @param urlString     图片的地址
 @param finishedBlock 下载完成回调block
 
 @return 下载操作对象
 */
+ (instancetype)downloaderOperationWithURLString:(NSString *)urlString finishedBlock:(void (^)(UIImage *image))finishedBlock {
    
    BBDownloadOperation *op = [[BBDownloadOperation alloc]init];
    op.urlString = urlString;
    op.finishedBlock = finishedBlock;
    return op;
}

@end
