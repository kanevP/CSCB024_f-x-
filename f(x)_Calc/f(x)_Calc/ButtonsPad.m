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
    [self setupForButton:button forIndex:index];
    
    button.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 4;
    
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    
    return button;
    
}

//- (NSString *)titleForIndex:(NSInteger)index
- (void)setupForButton:(UIButton *)button forIndex:(NSInteger)index
{
    button.tag = NSNotFound;

    switch (index) {
        case 0:
            [button setTitle:@"ln" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(unaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [button setTitle:@"  " forState:UIControlStateNormal];
            break;
        case 2:
            [button setTitle:@"0" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 0;
            break;
        case 3:
            [button setTitle:@"." forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(otherTypeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 4:
            [button setTitle:@"00" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 10;
            break;
        case 5:
            [button setTitle:@"=" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(otherTypeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 6:
            [button setTitle:@"cos" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(unaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        break;
        case 7:
            [button setTitle:@"Mod" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(unaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 8:
            [button setTitle:@"1" forState:UIControlStateNormal];
            button.tag = 1;
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 9:
            [button setTitle:@"2" forState:UIControlStateNormal];
            button.tag = 2;
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 10:
            [button setTitle:@"3" forState:UIControlStateNormal];
            button.tag = 3;
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 11:
            [button setTitle:@"  " forState:UIControlStateNormal];
            break;
        case 12:
            [button setTitle:@"tan" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(unaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 13:
            [button setTitle:@"x2" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(unaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 14:
            [button setTitle:@"4" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 4;
            break;
        case 15:
            [button setTitle:@"5" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 5;
            break;
        case 16:
            [button setTitle:@"6" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 6;
            break;
        case 17:
            [button setTitle:@"+" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(binaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 18:
            [button setTitle:@"sin" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(unaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 19:
            [button setTitle:@"√" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(unaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 20:
            [button setTitle:@"7" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 7;
            break;
        case 21:
            [button setTitle:@"8" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 8;
            break;
        case 22:
            [button setTitle:@"9" forState:UIControlStateNormal];
            button.tag = 9;
            [button addTarget:self.delegate action:@selector(numberButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 23:
            [button setTitle:@"-" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(binaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 24:
            [button setTitle:@"log" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(unaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 25:
            [button setTitle:@"~" forState:UIControlStateNormal];
            break;
        case 26:
            [button setTitle:@"C" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(otherTypeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 27:
            [button setTitle:@"%" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(binaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 28:
            [button setTitle:@"*" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(binaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 29:
            [button setTitle:@"/" forState:UIControlStateNormal];
            [button addTarget:self.delegate action:@selector(binaryOperationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            [button setTitle:@" " forState:UIControlStateNormal];
            break;
    }
}
@end
