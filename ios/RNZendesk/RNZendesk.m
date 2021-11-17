//
//  RNZendesk.m
//  FonosMobile
//
//  Created by Tai Kim on 10/22/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"

#import <AnswerBotSDK/AnswerBotSDK.h>
#import <AnswerBotProvidersSDK/AnswerBotProvidersSDK.h>
#import <ChatSDK/ChatSDK.h>
#import <ChatProvidersSDK/ChatProvidersSDK.h>
#import <MessagingSDK/MessagingSDK.h>
#import <CommonUISDK/CommonUISDK.h>
#import <SupportSDK/SupportSDK.h>
#import <SupportProvidersSDK/SupportProvidersSDK.h>
#import <ZendeskCoreSDK/ZendeskCoreSDK.h>
#import <ZendeskSDKMessaging/ZendeskSDKMessaging.h>


#import "AppDelegate.h"

@interface RCT_EXTERN_MODULE(RNZendesk, NSObject)

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXTERN_METHOD(setPrimaryColor:(String *)hexColor)
RCT_EXTERN_METHOD(initialize:(NSDictionary *)options)
RCT_EXTERN_METHOD(setUserIdentity:(NSDictionary *)visitorInfo)
RCT_EXTERN_METHOD(showLiveChat: (NSDictionary *)config)
RCT_EXTERN_METHOD(showGuides)
RCT_EXTERN_METHOD(showTicketList)
RCT_EXTERN_METHOD(showTicketCreation:(NSDictionary *)ticketConfig)
RCT_EXTERN_METHOD(createTicket: (NSDictionary *)ticketConfig
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(registerForNotifications:(String *)deviceToken)
@end
