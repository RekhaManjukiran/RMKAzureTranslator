//
//  RMKAzureTokenManager.h
//  RMKAzureTranslatorDemo
//
//  Created by Rekha Manju Kiran on 16/01/17.
//  Copyright © 2017 RMK Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMKAzureTokenManager : NSObject

- (instancetype)initWithAzureKey:(NSString *)azureKey;
- (void)fetchTokenForAzureKey:(NSString *)azureKey
                 onCompletion:(void (^)(NSString *azureToken, NSError *error))completionHandler;

@end
