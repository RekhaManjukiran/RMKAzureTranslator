//
//  RMKAzureTokenManager.h
//  RMKAzureTranslatorDemo
//
//  Created by Rekha Manju Kiran on 16/01/17.
//  Copyright © 2017 RMK Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMKAzureTokenManager : NSObject

/**
 Initializes an instance of token manager with the key provided
 
 @params
 azureKey azureKey - Key obtained from Azure Cognitive Services
 
 @returns
 Instance of the token manager (the instance internally calls the function to refresh the token)
 */

- (instancetype)initWithAzureKey:(NSString *)azureKey;

/**
 Fetches Token for the given azureKey
 
 @params
 azureKey azureKey
 completionHandler : Returns the azure token to be used by the Tranlator instance . 
 */

- (void)fetchTokenForAzureKey:(NSString *)azureKey
                 onCompletion:(void (^)(NSString *azureToken, NSError *error))completionHandler;

@end
