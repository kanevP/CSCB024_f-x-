//
//  OprationsManager.h
//  f(x)_Calc
//
//  Created by Petar Kanev on 2/5/16.
//  Copyright © 2016 Petar Kanev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OperationsManagerProtocol <NSObject>

- (void) oparationManagerDidUpdateOperation;
- (void) operationManagerDidFinalizeOperation;

@end

@interface OperationsManager : NSObject

@property (weak, nonatomic) id<OperationsManagerProtocol> delegate;

+ (instancetype)sharedInstance;

- (NSString *)currentOperation;
- (NSInteger)totalOperations;
- (void)updateLastOperation:(NSString *)operation;
- (NSString *)operationForIndex:(NSInteger)index;
- (void)finalizeLastOperation;

@end
