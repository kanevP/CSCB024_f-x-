//
//  OprationsManager.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 2/5/16.
//  Copyright © 2016 Petar Kanev. All rights reserved.
//

#import "OperationsManager.h"
@interface OperationsManager()

@property (strong, nonatomic) NSMutableArray *operations;

@end


@implementation OperationsManager

+ (instancetype)sharedInstance
{
    static OperationsManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        instance.operations = [NSMutableArray new];
    });
    return instance;
}

#pragma Mark managed operations
- (NSString *)currentOperation
{
    return [self.operations lastObject];
}

- (NSInteger)totalOperations
{
    return self.operations.count;
}
- (NSString *)operationForIndex:(NSInteger)index
{
    if (index >= self.operations.count) {
        return @"";
    }
    return [self.operations objectAtIndex:index];
}

- (void)updateLastOperation:(NSString *)operation
{
    if ([self.operations count] > 0) {
        self.operations[[self.operations count] -1] = operation;
    }else{
        self.operations[0] = operation;
    }
    if ([self.delegate respondsToSelector:@selector(operationManagerDidFinalizeOperation)])
    {
        [self.delegate oparationManagerDidUpdateOperation];
    }
}

- (void)finalizeLastOperation
{
    [self.operations addObject:@""];
    if ([self.delegate respondsToSelector:@selector(operationManagerDidFinalizeOperation)])
    {
        [self.delegate operationManagerDidFinalizeOperation];
    }
}

@end
