//
//  DisplayTableView.h
//  f(x)_Calc
//
//  Created by Petar Kanev on 1/3/16.
//  Copyright © 2016 Petar Kanev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayTableView : UITableView<UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *operationStrings;

@end
