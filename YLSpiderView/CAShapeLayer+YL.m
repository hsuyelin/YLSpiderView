//
//  CAShapeLayer+YL.m
//  YLSpiderView
//
//  Created by hsuyelin on 2018/5/21.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

#import "CAShapeLayer+YL.h"

#import <objc/runtime.h>

static char *YLVALUESHAPELAYERKEY = "yl_valueShapeLayerKey";
static char *YLINDEXKEY           = "yl_indexKey";

@implementation CAShapeLayer (YL)

- (void)setIsValueShapeLayer:(BOOL)isValueShapeLayer
{
    objc_setAssociatedObject(self, YLVALUESHAPELAYERKEY, @(isValueShapeLayer), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isValueShapeLayer
{
   return [objc_getAssociatedObject(self, YLVALUESHAPELAYERKEY) boolValue];
}

- (void)setIndex:(NSUInteger)index
{
    objc_setAssociatedObject(self, YLINDEXKEY, @(index), OBJC_ASSOCIATION_RETAIN);
}

- (NSUInteger)index
{
    return [objc_getAssociatedObject(self, YLINDEXKEY) integerValue];
}

@end
