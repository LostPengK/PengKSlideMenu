//
//  PengKSlideMenu.h
//  TEST
//
//  Created by pengkang on 16/11/4.
//  Copyright © 2016年 pengkang. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MenuAnimationType) {
    MenuAnimationTypeNone,
    MenuAnimationTypeNormal,
    MenuAnimationTypeGradient,
};

typedef NS_ENUM(NSUInteger, UnderlineViewWidthType) {
    UnderlineViewWidthTypeDefault,//default is eqaul to button title width
    UnderlineViewWidthTypeExpand,//under lind width is equal to button width
};

@interface PengKSlideMenu : UIView

@property(nonatomic,strong)UIColor *backColor;

//item unselected color
@property(nonatomic,strong)UIColor *titleColor;

//item selected color,default is blue.
@property(nonatomic,strong)UIColor *titleSelectedColor;

@property(nonatomic,strong)UIColor *underlineColor;

//default is 2.0
@property(nonatomic,assign)CGFloat underlineHeight;

//curret index
@property(nonatomic,assign)NSInteger currentIndex;

//target index
@property(nonatomic,assign)NSInteger targetIndex;

//default is NO ,if yes ,use it with property equalItemWidth
@property(nonatomic,assign)BOOL itemEqualWidth;

//default is zero, if not zero
@property(nonatomic,assign)CGFloat equalItemWidth;

//button title left and right offset ,default is 15.0; it works only when itemEqualWidth is no;
@property(nonatomic,assign)CGFloat titleOffset;

//default is 15.0
@property(nonatomic,strong)UIFont *itemFont;

@property(nonatomic,strong)NSArray *titlesArr;

// animation time default is 0.35.
@property(nonatomic,assign)CGFloat duration;

@property(nonatomic,assign)UnderlineViewWidthType underlineViewWidthType;

@property(nonatomic,assign)MenuAnimationType animationType;
//+(PengKSlideMenu *)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr animationType:(MenuAnimationType)type;



@property(nonatomic,copy)void(^menuClickBlcok)(NSInteger fromIndex,NSInteger targetIndex);

-(void)layout;

@property(nonatomic,copy)void (^clickAtIndexBlock)(NSInteger index);
@end
