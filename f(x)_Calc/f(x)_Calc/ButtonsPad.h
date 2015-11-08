//
//  ButtonsPad.h
//  f(x)_Calc
//
//  Created by Petar Kanev on 11/7/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol ButtonsPadDelegate <NSObject>

- (void)buttonTapped:(UIButton *)button;

@end

@interface ButtonsPad : UIView

@property (strong, nonatomic) NSMutableArray *buttons;
@property (weak, nonatomic) id<ButtonsPadDelegate> delegate;

@end
