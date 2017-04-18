//
//  UIImageView+BBWebCache.m
//  BBSDWebImage
//
//  Created by 王二 on 17/4/18.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import "UIImageView+BBWebCache.h"
#import "BBDownloaderOperationManager.h"
#import <objc/runtime.h>

@interface UIImageView ()

//当前的显示图片的地址
@property(nonatomic,copy)NSString *currentURLString;

@end

@implementation UIImageView (BBWebCache)

/**
 设置图片
 
 @param urlString 图片urlString
 */
- (void)bb_setImageWithUrlString:(NSString *)urlString {
    //防止连续设置图片，UIImageView上的图片频繁切换
    //判断当前点击的图片地址和上一次图片的地址是否一样，如果不一样取消上一次操作
    if (![urlString isEqualToString:self.currentURLString]) {
        //取消上一次操作
        //[self.operationCache[self.currentURLString] cancel];
        [[BBDownloaderOperationManager sharedManager] cancelOperation:self.currentURLString];
    }
    //记录上一次的图片地址
    self.currentURLString = urlString;
    //下载图片
    [[BBDownloaderOperationManager sharedManager]downloadWithURLString:urlString finishedBlock:^(UIImage *image) {
        self.image = image;
    }];
}

/**
 设置图片，带有占位图
 
 @param urlString      图片urlString
 @param placeholderStr 占位图
 */
- (void)bb_setImageWithUrlString:(NSString *)urlString withPlaceHolderImageName:(NSString *)placeholderStr {
    self.image = [UIImage imageNamed:placeholderStr];
    [self bb_setImageWithUrlString:urlString];
}

#pragma mark - runtime给分类添加属性

- (void)setCurrentURLString:(NSString *)currentURLString {
    objc_setAssociatedObject(self, @"currentURLString", currentURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)currentURLString {
    return  objc_getAssociatedObject(self, @"currentURLString");
}

@end
