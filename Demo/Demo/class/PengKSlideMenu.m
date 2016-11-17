//
//  PengKSlideMenu.m
//  TEST
//
//  Created by pengkang on 16/11/4.
//  Copyright © 2016年 pengkang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PengKSlideItem : UIButton

@property(nonatomic,assign) CGFloat itemWidth;

@property(nonatomic,assign) CGFloat titleOrign;

@property(nonatomic,assign) CGFloat titleMaxX;

@property(nonatomic,assign) CGFloat titleWidth;
@end



@implementation PengKSlideItem


@end

#import "PengKSlideMenu.h"

@interface PengKSlideMenu()

@property (nonatomic,strong) UIView *indicatorView;

@property (nonatomic,strong) UIScrollView *containerView;

@property (nonatomic,strong) NSMutableArray *buttonArr;

@end

@implementation PengKSlideMenu

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubview];
    }
    return self;
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubview];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubview];
    }
    return self;
}

-(void)initSubview{
    
    for (UIView *vv in self.subviews) {
        [vv removeFromSuperview];
    }
    
    self.itemEqualWidth = NO;
    self.titleOffset = 15.0;
    self.underlineHeight = 2.0;
    self.underlineColor = [UIColor cyanColor];
    self.itemFont = [UIFont systemFontOfSize:15];
    self.underlineColor = [UIColor lightGrayColor];
    self.duration = 0.35;
    self.titleColor = [UIColor lightGrayColor];
    self.titleSelectedColor = [UIColor blueColor];
    self.currentIndex = 0;
    self.targetIndex = 0;
    
    [self addSubview:self.containerView];
    [self addSubview:self.indicatorView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
}

-(void)creatBtn{
    [self.buttonArr removeAllObjects];
    
    for (NSInteger i = 0; i < self.titlesArr.count; i++) {
        PengKSlideItem *button = [PengKSlideItem buttonWithType:UIButtonTypeCustom];
        [self.buttonArr addObject:button];
        [button setTitle:self.titlesArr[i] forState:UIControlStateNormal];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:self.itemFont];
        button.tag = i + 100;
        if (i==0) {
            button.selected = YES;
        }
    }

}

-(void)layout{
    
    self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-self.underlineHeight);
    
    CGFloat itemOrginx = 0;
    for (NSInteger i = 0; i < self.buttonArr.count; i++) {
        PengKSlideItem *item = self.buttonArr[i];
        [self.containerView addSubview:item];
        
        NSString *title = self.titlesArr[i];
        CGSize size = [title boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.itemFont} context:nil ].size;
        item.itemWidth = self.titleOffset * 2 + size.width;
        item.titleMaxX  = self.titleOffset + size.width;
        item.titleOrign = self.titleOffset;
        item.titleWidth = size.width;
        
        CGRect frame = CGRectMake(itemOrginx, 0, item.itemWidth, self.frame.size.height-self.underlineHeight);
        if (self.itemEqualWidth) {
            CGFloat buttonWidth = self.frame.size.width/self.titlesArr.count;
            frame = CGRectMake(itemOrginx, 0, buttonWidth, self.frame.size.height-self.underlineHeight);
            item.itemWidth = buttonWidth;
            item.titleOrign = (buttonWidth - size.width)/2.0;
            item.titleMaxX  = item.titleOrign + size.width;
        }
        [item setFrame:frame];
        
        itemOrginx += item.itemWidth;
        
       
    }
    
    PengKSlideItem *item = self.buttonArr[0];
    
    CGRect frame = CGRectZero;
    switch (self.underlineViewWidthType) {
        case UnderlineViewWidthTypeDefault:{
            frame = CGRectMake(item.titleOrign, self.frame.size.height-self.underlineHeight, item.titleWidth, self.underlineHeight);
        }
            break;
        case UnderlineViewWidthTypeExpand:{
            frame = CGRectMake(item.frame.origin.x, self.frame.size.height-self.underlineHeight, item.itemWidth, self.underlineHeight);
        }
            break;
        default:
            break;
    }
    self.indicatorView.frame = frame;
    self.indicatorView.backgroundColor = self.underlineColor;
    self.currentIndex = 0;

}

-(void)setUnderlineFromStartIndex:(NSInteger)start endIndex:(NSInteger)endIndex{
    if (start==endIndex) {
        return;
    }
    if (labs(start - endIndex)>=1) {
        PengKSlideItem *item = self.buttonArr[endIndex];
        CGRect frame = item.frame;
        switch (self.underlineViewWidthType) {
            case UnderlineViewWidthTypeDefault:{
                frame = CGRectMake(item.titleOrign+item.frame.origin.x, self.frame.size.height-self.underlineHeight, item.titleWidth, self.underlineHeight);
            }
                break;
            case UnderlineViewWidthTypeExpand:{
                frame = CGRectMake(item.frame.origin.x, self.frame.size.height-self.underlineHeight, item.itemWidth, self.underlineHeight);
            }
                break;
            default:
                break;
        }
        [UIView animateWithDuration:self.duration animations:^{
            self.indicatorView.frame = frame;
        } completion:^(BOOL finished) {
            
            UIButton *button0 = self.buttonArr[start];
            UIButton *button1 = self.buttonArr[endIndex];
            button0.selected = NO;
            button1.selected = YES;

            if (self.menuClickBlcok) {
                self.menuClickBlcok(start,endIndex);
            }
            
        }];
    }
    
    
}

-(void)clickItem:(UIButton *)button{
    NSInteger index = button.tag - 100;
    self.targetIndex = self.currentIndex;
    
    self.currentIndex = index;
    
    if (self.clickAtIndexBlock) {
        self.clickAtIndexBlock(index);
    }

}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    NSInteger fromIndex = self.currentIndex;
    _currentIndex = currentIndex;
    self.targetIndex = currentIndex;
    [self setUnderlineFromStartIndex:fromIndex endIndex:self.targetIndex];

}

#pragma mark getter setter
-(void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.backgroundColor = backColor;
}


-(void)setTitlesArr:(NSArray *)titlesArr{
    _titlesArr = titlesArr;
    [self creatBtn];
}

-(UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [UIView new];
    }
    return _indicatorView;
}

-(UIScrollView *)containerView{
    if (!_containerView) {
        _containerView = [UIScrollView new];
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.showsVerticalScrollIndicator = NO;
    }
    return _containerView;
}

-(NSMutableArray *)buttonArr{
    if (!_buttonArr) {
        _buttonArr = @[].mutableCopy;
    }
    return _buttonArr;
}

@end
