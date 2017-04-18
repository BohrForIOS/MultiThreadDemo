//
//  SimpleCellModel.h
//  BBSDWebImage
//
//  Created by 王二 on 17/4/18.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 cell展示的模型数据
 */
@interface SimpleCellModel : NSObject

/** 图标 */
@property (nonatomic, strong) NSString *icon;
/** 下载量 */
@property (nonatomic, strong) NSString *download;
/** 名字 */
@property (nonatomic, strong) NSString *name;

+ (instancetype)cellModelWithDict:(NSDictionary *)dict;

@end
