//
//  HJTextview.m
//  new微博
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 HJ. All rights reserved.
//

#import "HJTextview.h"
@interface HJTextview()
@property (nonatomic,weak)UILabel *placehoderLabel;
@end
@implementation HJTextview
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        [self addSubview:label];
        
        self.placehoderLabel = label;
        //_placehoderColor 这样写就错了 这是get方法
        //self.placehoderColor 这样 写 会调用下面的set方面 重新赋值颜色
        //moren
        self.placehoderColor =[UIColor lightGrayColor];
        //moren
        self.font = [UIFont systemFontOfSize:14];
        //监听输入框 有字符输入的时候 隐藏提醒文字
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeText) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}

- (void)changeText{
    self.placehoderLabel.hidden = self.text.length != 0;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

//重写set方法
- (void)setPlacehoder:(NSString *)placehoder{
    _placehoder = [placehoder copy];
    //设置文字
    _placehoderLabel.text = placehoder;
    //在重新布局一次
    [self setNeedsLayout];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor{
    _placehoderColor = placehoderColor;
    self.placehoderLabel.textColor = placehoderColor;
}

-(void)setFont:(UIFont *)font{
    //调用 父类 的方法 上面会设置font 在父类里面
    [super setFont:font];
    self.placehoderLabel.font = font;
    //在重新布局一次
    [self setNeedsLayout];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.placehoderLabel.top = 7;
    self.placehoderLabel.left = 5;

    self.placehoderLabel.width = self.width - 10;
    // MAXFLOAT 浮点型无限大
    //这个高度 必须要设置无限大 否则给定高度 就会造成 万一超出了限制高度 但得到高度 依然还是给定的高度
    CGSize maxSize = CGSizeMake(self.placehoderLabel.width, MAXFLOAT);
    //
    self.placehoderLabel.height = [self.placehoder sizeWithFont:self.placehoderLabel.font constrainedToSize:maxSize].height;
    /*
     //字符串在指定区域内按照指定的字体显示时,需要的高度和宽度(宽度在字符串只有一行时有用)
     //一般用法:指定区域的宽度而高度用MAXFLOAT,则返回值包含对应的高度
     //如果指定区域的宽度指定,而字符串要显示的区域的高度超过了指定区域的高度,则高度返回0
     //核心:多行显示,指定宽度,获取高度
     */
}
@end
