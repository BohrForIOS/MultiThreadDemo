//
//  UIImageView+BBWebCache.h
//  BBSDWebImage
//
//  Created by 王二 on 17/4/18.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BBWebCache)

/**
 设置图片

 @param urlString 图片urlString
 */
- (void)bb_setImageWithUrlString:(NSString *)urlString;


/**
 设置图片，带有占位图

 @param urlString      图片urlString
 @param placeholderStr 占位图
 */
- (void)bb_setImageWithUrlString:(NSString *)urlString withPlaceHolderImageName:(NSString *)placeholderStr;

@end
