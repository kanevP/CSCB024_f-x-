//
//  ButtonsPad.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 11/7/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import "ButtonsPad.h"
#import "Masonry.h"
@implementation ButtonsPad

- (instancetype)init
{
    if (self = [super init]) {
        self.buttons = [NSMutableArray new];
        for (int i = 0; i < 30; i++) {
            [self.buttons addObject:[self buttonForIndex:i]];
            [self addSubview:self.buttons[i]];
        }
        self.backgroundColor = [UIColor redColor];
//        [self setNeedsUpdateConstraints];
        
    }
    return self;
}


- (void)updateConstraints
{
    for (int i = 0; i < 30; i++) {
        NSInteger col = i%6;
        [self.buttons[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            if (col > 0) {
                make.leading.equalTo([self.buttons[i-1] mas_trailing]).with.offset(5);
            }else {
              make.leading.equalTo(self.mas_leading);  
            }
            
            make.width.equalTo([self buttonWidthForIndex:i]);
            make.height.equalTo([self buttonHeightForIndex:i]);
            
            if (i < 6) {
                make.bottom.equalTo(self.mas_bottom);
            }else {
                make.bottom.equalTo([self.buttons[i-6] mas_top]).with.offset(-5);
            }
        }];
    }
    
    [super updateConstraints];
}

- (NSNumber *)buttonHeightForIndex:(NSInteger)index
{
    return @((CGRectGetWidth([UIScreen mainScreen].bounds) - 20 - 30 - 30)/5);
}

- (NSNumber *)buttonWidthForIndex:(NSInteger)index
{
    if (index%6 == 5) {
        return @30;
    }else{
        return @((CGRectGetWidth([UIScreen mainScreen].bounds) - 20 - 30 - 30)/5);
    }
}

- (UIButton *)buttonForIndex:(NSInteger)index
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [[self buttonWidthForIndex:0] floatValue], [[self buttonWidthForIndex:0] floatValue])];
    [button setTitle:[self titleForIndex:index] forState:UIControlStateNormal];
    [button addTarget:self.delegate action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    button.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 4;
    
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    
    return button;
    
}

- (NSString *)titleForIndex: (NSInteger)index
{
    switch (index) {
        case 0:
            return @"ln";
            break;
        case 1:
            return @"  ";
            break;
        case 2:
            return @"0";
            break;
        case 3:
            return @".";
            break;
        case 4:
            return @"00";
            break;
        case 5:
            return @"=";
            break;
        case 6:
            return @"cos";
            break;
        case 7:
            return @"Mod";
            break;
        case 8:
            return @"1";
            break;
        case 9:
            return @"2";
            break;
        case 10:
            return @"3";
            break;
        case 11:
            return @"  ";
            break;
        case 12:
            return @"tan";
            break;
        case 13:
            return @"x2";
            break;
        case 14:
            return @"4";
            break;
        case 15:
            return @"5";
            break;
        case 16:
            return @"6";
            break;
        case 17:
            return @"+";
            break;
        case 18:
            return @"sin";
            break;
        case 19:
            return @"⎷";
            break;
        case 20:
            return @"7";
            break;
        case 21:
            return @"8";
            break;
        case 22:
            return @"9";
            break;
        case 23:
            return @"-";
            break;
        case 24:
            return @"log";
            break;
        case 25:
            return @"~";
            break;
        case 26:
            return @"C";
            break;
        case 27:
            return @"%";
            break;
        case 28:
            return @"*";
            break;
        case 29:
            return @"/";
            break;
        default:
            return @" ";
            break;
    }
}
@end
