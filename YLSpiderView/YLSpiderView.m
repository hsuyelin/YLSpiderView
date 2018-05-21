//
//  YLSpiderView.m
//  YLSpiderView
//
//  Created by hsuyelin on 2018/5/16.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

#import "YLSpiderView.h"

#import "CAShapeLayer+YL.h"

@interface YLSpiderView ()

/// 能力图半径
@property (nonatomic, assign) CGFloat yl_radius;
/// 能力图的起点坐标
@property (nonatomic, assign) CGPoint yl_originPoint;
/// 默认区域填充颜色
@property (nonatomic, strong) UIColor *yl_defaultFillColor;
/// 默认区域边界颜色
@property (nonatomic, strong) UIColor *yl_defaultBorderColor;

/// 存放能力值多边形图容器数据的数组
@property (nonatomic, strong) NSMutableArray<NSArray *> *yl_bgPointMArr;
/// 存放实际能力值真实数据的数组
@property (nonatomic, strong) NSMutableArray<NSArray *> *yl_valuePointMArr;

@end

@implementation YLSpiderView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self yl_defaultConfig];
    }
    
    return self;
}

#pragma mark - public
- (void)yl_configSpiderView
{
    [self yl_getContainerData];
    [self yl_getTrueValueData];
    [self yl_drawBgContainer];
    [self yl_drawTrueValue];
}

- (void)yl_reloadData
{
    NSMutableArray *sublayerMArr = [NSMutableArray arrayWithArray:self.layer.sublayers];
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            CAShapeLayer *shapeLayer = (CAShapeLayer *)obj;
            if (shapeLayer.isValueShapeLayer && obj) {
                [sublayerMArr removeObject:obj];
            }
        }
    }];
    self.layer.sublayers = [sublayerMArr mutableCopy];
    [self yl_getTrueValueData];
    [self yl_drawTrueValue];
}

- (void)yl_reloadDataAtIndex:(NSUInteger)index
{
    NSMutableArray *sublayerMArr = [NSMutableArray arrayWithArray:self.layer.sublayers];
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            CAShapeLayer *shapeLayer = (CAShapeLayer *)obj;
            if (shapeLayer.isValueShapeLayer && shapeLayer.index == index && obj) {
                [sublayerMArr removeObject:obj];
            }
        }
    }];
    self.layer.sublayers = [sublayerMArr mutableCopy];
    [self yl_getTrueValueData];
    [self yl_drawTrueValue];
}

#pragma mark - private
- (void)yl_defaultConfig
{
    self.backgroundColor = [UIColor whiteColor];
    _areaCount = 4;
    /// 为了能让能力描述标签完全显示，要减去一定的偏差值，来适应
    _yl_radius = (self.frame.size.height - 50 * 2.0) / 2.0;
    _yl_originPoint = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) / 2.0);
    _yl_defaultFillColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    _yl_defaultBorderColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    _separatorLineColor = [UIColor whiteColor];
    _maxValue = 100.0;
    _descFont = [UIFont systemFontOfSize:12.0];
    _descColor = [UIColor colorWithRed:119 / 255.0 green:119 / 255.0 blue:119 / 255.0 alpha:1.0];
    _valueBorderColorArr = @[[UIColor colorWithRed:234 / 255.0 green:74 / 255.0 blue:54 / 255.0 alpha:1.0]];
}

- (void)yl_getContainerData
{
    if (self.yl_bgPointMArr.count > 0) {
        [self.yl_bgPointMArr removeAllObjects];
    }
    
    if (_valueDescArr.count == 0) {
        return;
    }
    
    CGFloat perAreaRadius = _yl_radius / _areaCount;
    CGFloat perAreaAngle = M_PI * 2 / _valueDescArr.count;
    
    for (NSInteger i = 0; i < _areaCount; i ++) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        CGFloat tmpLength = (i + 1) * perAreaRadius;
        
        for (NSInteger j = 0; j < _valueDescArr.count; j ++) {
            CGPoint tmpPoint = CGPointMake(_yl_originPoint.x + tmpLength * sin(j * perAreaAngle), _yl_originPoint.y - tmpLength * cos(j * perAreaAngle));
            NSValue *tmpValue = [NSValue valueWithCGPoint:tmpPoint];
            [tmpArr addObject:tmpValue];
            
            if (i == _areaCount - 1) {
                CGFloat descLabelWidth = [self yl_getTextWidth:_valueDescArr[j] font:_descFont];
                UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, descLabelWidth, 20.0)];
                descLabel.font = _descFont;
                descLabel.text = _valueDescArr[j] ? : @"null";
                descLabel.textColor = _descColor;
                /// + 5 是为了让能力标签不紧贴蜘蛛图，单纯为了美观
                descLabel.center = CGPointMake(_yl_originPoint.x + (_yl_radius + descLabelWidth / 2 + 5) * sin(j * perAreaAngle) ,_yl_originPoint.y - (_yl_radius + 20 / 2 + 5) * cos(j * perAreaAngle));
                [self addSubview:descLabel];
            }
        }
        
        [self.yl_bgPointMArr addObject:[tmpArr copy]];
        [tmpArr removeAllObjects];
    }
}

- (void)yl_getTrueValueData
{
    if (self.yl_valuePointMArr.count > 0) {
        [self.yl_valuePointMArr removeAllObjects];
    }
    
    if (_valueArr.count == 0) {
        return;
    }
    
    CGFloat perAreaAngle = M_PI * 2 / _valueDescArr.count;
    
    for (NSInteger i = 0; i < _valueArr.count; i ++) {
        NSArray *tmpValueArr = _valueArr[i];
        NSMutableArray *tmpArr = [NSMutableArray array];
        
        for (NSInteger j = 0; j < tmpValueArr.count; j ++) {
            CGFloat value = [tmpValueArr[j] floatValue];
            value = value > _maxValue ? _maxValue : value;
            
            CGPoint tmpPoint = CGPointMake(_yl_originPoint.x + value / _maxValue * _yl_radius * sin(j * perAreaAngle), _yl_originPoint.y - value / _maxValue * _yl_radius * cos(j * perAreaAngle));
            NSValue *tmpValue = [NSValue valueWithCGPoint:tmpPoint];
            [tmpArr addObject:tmpValue];
        }
        
        [self.yl_valuePointMArr addObject:[tmpArr copy]];
        [tmpArr removeAllObjects];
    }
}

- (void)yl_drawBgContainer
{
    for (NSInteger i = self.yl_bgPointMArr.count - 1; i >= 0; i --) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        NSArray *tmpArr = [self.yl_bgPointMArr[i] copy];
        
        for (NSInteger j = 0; j < tmpArr.count; j ++) {
            CGPoint tmpPoint = [tmpArr[j] CGPointValue];
            
            if (j == 0) {
                [path moveToPoint:tmpPoint];
            }
            else if (j == tmpArr.count) {
                [path addLineToPoint:tmpPoint];
                [path moveToPoint:tmpPoint];
            }
            else {
                [path addLineToPoint:tmpPoint];
            }
        }
        
        [path closePath];
        shapeLayer.path = path.CGPath;
        if (_areaFillColorArr.count == _areaCount) {
            shapeLayer.fillColor = _areaFillColorArr[i].CGColor;
        }
        else {
            shapeLayer.fillColor = [UIColor colorWithWhite:0.5 alpha:0.3].CGColor;
        }
        
        if (_areaBorderColorArr.count == _areaCount) {
            shapeLayer.borderColor = _areaBorderColorArr[i].CGColor;
        }
        else {
            shapeLayer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.3].CGColor;
        }
        
        [self.layer addSublayer:shapeLayer];
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_yl_originPoint];
    NSArray *tmpMArr = [[self.yl_bgPointMArr lastObject] copy];
    for (NSInteger k = 0; k < tmpMArr.count; k ++) {
        CGPoint tmpCurrentPoint = [tmpMArr[k] CGPointValue];
        
        [path addLineToPoint:tmpCurrentPoint];
        [path moveToPoint:_yl_originPoint];
    }
    
    [path closePath];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = _separatorLineColor.CGColor;
    [self.layer addSublayer:shapeLayer];
}

- (void)yl_drawTrueValue
{
    if (self.yl_valuePointMArr.count == 0) {
        return;
    }
    
    for (NSInteger i = 0; i < self.yl_valuePointMArr.count; i ++) {
        NSArray *tmpArr = [self.yl_valuePointMArr[i] copy];
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        for (NSInteger j = 0; j < tmpArr.count; j ++) {
            if (j == 0) {
                [path moveToPoint:[tmpArr[j] CGPointValue]];
            }
            else{
                [path addLineToPoint:[tmpArr[j] CGPointValue]];
            }
        }
        
        [path closePath];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.borderWidth = 1.0;
        shapeLayer.lineWidth = 1.5;
        shapeLayer.isValueShapeLayer = YES;
        shapeLayer.index = i;
        UIColor *fillColor = [UIColor clearColor];
        if (_valueFillColorArr.count > i) {
            fillColor = _valueFillColorArr[i];
        }
        shapeLayer.fillColor = fillColor.CGColor;
        
        UIColor *borderColor = [UIColor colorWithRed:234 / 255.0 green:74 / 255.0 blue:54 / 255.0 alpha:1.0];
        if (_valueBorderColorArr.count > i) {
            borderColor = _valueBorderColorArr[i];
        }
        shapeLayer.strokeColor = borderColor.CGColor;
        
        [self.layer addSublayer:shapeLayer];
    }
}

#pragma mark - utils
- (CGFloat)yl_getTextWidth:(NSString *)string font:(UIFont *)font
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

#pragma mark - setter
- (void)setAreaCount:(NSInteger)areaCount
{
    if (areaCount <= 0) {
        return;
    }
    
    _areaCount = areaCount;
}

#pragma mark - lazy
- (NSMutableArray<NSArray *> *)yl_bgPointMArr
{
    if (!_yl_bgPointMArr) {
        _yl_bgPointMArr = [NSMutableArray array];
    }
    return _yl_bgPointMArr;
}

- (NSMutableArray<NSArray *>  *)yl_valuePointMArr
{
    if (!_yl_valuePointMArr) {
        _yl_valuePointMArr = [[NSMutableArray alloc] init];
    }
    return _yl_valuePointMArr;
}

@end
