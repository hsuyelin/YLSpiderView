//
//  YLSpiderView.h
//  YLSpiderView
//
//  Created by hsuyelin on 2018/5/16.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLSpiderView : UIView

/// 能力值数组
@property (nonatomic, copy) NSArray<NSArray *> *valueArr;

/// 能力值描述数组
@property (nonatomic, copy) NSArray<NSString *> *valueDescArr;

/// 蜘蛛图需要分几个区，默认4个分区
@property (nonatomic, assign) NSInteger areaCount;

/// 最大能力值，输入的能力值数组会以这个最大能力得出比例，然后显示相应的长度
@property (nonatomic, assign) CGFloat maxValue;

/// 分区填充颜色，从里到外的填充颜色
@property (nonatomic, copy) NSArray<UIColor *> *areaFillColorArr;

/// 分区边界颜色，从里到外的边界颜色
@property (nonatomic, copy) NSArray<UIColor *> *areaBorderColorArr;

/// 真实数据填充颜色
@property (nonatomic, copy) NSArray<UIColor *> *valueFillColorArr;

/// 真实数据边界颜色
@property (nonatomic, copy) NSArray<UIColor *> *valueBorderColorArr;

/// 分隔线颜色
@property (nonatomic, strong) UIColor *separatorLineColor;

/// 能力值描述标签 字体 默认 12号字体
@property (nonatomic, strong) UIFont *descFont;

/// 能力值描述标签 颜色 默认RGB 119 119 119 1.0
@property (nonatomic, strong) UIColor *descColor;

/// 配置能力图相关数据, 切记在初始化所有参数之后调用
- (void)yl_configSpiderView;

/// 刷新所有数据
- (void)yl_reloadData;

/// 刷新指定数据, 数据和之前的数据应该对应, 仅 index 下标的数据发生改变
- (void)yl_reloadDataAtIndex:(NSUInteger)index;

@end
