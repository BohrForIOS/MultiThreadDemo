//
//  SimpleCellModel.m
//  BBSDWebImage
//
//  Created by 王二 on 17/4/18.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import "SimpleCellModel.h"

/**
 cell展示的模型数据
 */
@implementation SimpleCellModel

+ (instancetype)cellModelWithDict:(NSDictionary *)dict {
    SimpleCellModel *cellModel = [[self alloc] init];
    [cellModel setValuesForKeysWithDictionary:dict];
    return cellModel;
}

@end
