//
//  RNZendesk.swift
//  FonosMobile
//
//  Created by Tai Kim on 10/22/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

import Foundation

import SupportSDK
import ZendeskCoreSDK
import ChatSDK
import ChatProvidersSDK
import CommonUISDK
import AnswerBotSDK
import AnswerBotProvidersSDK
//import MessagingSDK
import ZendeskSDKMessaging



func _navigate(viewController: UIViewController) -> Void {
  var topController = UIApplication.shared.keyWindow?.rootViewController
  while ((topController?.presentedViewController) != nil) {
      topController = topController?.presentedViewController
  }

  let navControl = UINavigationController(rootViewController: viewController)
  topController?.present(navControl, animated: true)
}


@objc(RNZendesk)
class RNZendesk: NSObject{
  
  @objc
  func setPrimaryColor(_ hexColor: String) -> Void {
    CommonTheme.currentTheme.primaryColor = UIColor()
  }

  @objc
  func initialize(_ options: NSDictionary) -> Void {
    Zendesk.initialize(appId: options["appId"] as! String, clientId: options["clientId"] as! String, zendeskUrl: options["zendeskUrl"] as! String)
    Support.initialize(withZendesk: Zendesk.instance)
    AnswerBot.initialize(withZendesk: Zendesk.instance, support: Support.instance!)
    Chat.initialize(accountKey: options["accountKey"] as! String, queue: DispatchQueue.main)
    
  }
  
  @objc
  func setUserIdentity(_ visitorInfo: NSDictionary) -> Void {
    let identity = Identity.createAnonymous(name: visitorInfo["name"] as? String, email: visitorInfo["email"] as? String)
    Zendesk.instance?.setIdentity(identity)
  }
  
  @objc
  func showGuides() -> Void {
    // Should set visitor?
    let helpCenterUI = HelpCenterUi.buildHelpCenterOverviewUi(withConfigs: [])
    _navigate(viewController: helpCenterUI)
  }
  
  @objc
  func showTicketList() -> Void {
    let ticketListUI = RequestUi.buildRequestList(with: [])
    _navigate(viewController: ticketListUI)
  }
  
  @objc
  func showTicketCreation(_ config: NSDictionary) -> Void {
    let _config = RequestUiConfiguration()
    _config.subject = (config["subject"] != nil) ? config["subject"] as! String : "New ticket"
    _config.tags = (config["tags"] != nil) ? config["tags"] as! [String] : ["unknown"]
    
    let addTicketUI = RequestUi.buildRequestUi(with: [_config])
    
    _navigate(viewController: addTicketUI)
  
  }
  
  @objc
  func showLiveChat(_ config: NSDictionary) -> Void {
    do {
      let messagingConfugration = MessagingConfiguration()
      messagingConfugration.name = "Fonos Help"
      
      let chatEngine = try ChatEngine.engine()
      let answerBotEngine = try AnswerBotEngine.engine()
      let supportEngine = try SupportEngine.engine()
      let liveChatUI = try Messaging.instance.buildUI(engines: [answerBotEngine, chatEngine, supportEngine], configs: [])
      
      
      _navigate(viewController: liveChatUI)
    } catch let error as NSError {
      print("\(error.localizedDescription)")
    }
  }
  
  @objc
  func createTicket(_ request: NSDictionary, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    let _request = ZDKCreateRequest()
    let _provider = ZDKRequestProvider()
    // TODO: Set custom fields.
    _request.subject = request["subject"] as? String
    _request.tags = request["tags"] as? [Any]
    _request.requestDescription = request["description"] as? String
    
    _provider.createRequest(_request) {result, error in
      if ((error) != nil) {
        return reject("ERROR", "CREATE TICKET ERROR", error)
      }
      return resolve("ok")
    }
  }
  
  @objc
  func registerForNotifications(_ deviceToken: Data) {
    Chat.registerPushToken(deviceToken)
  }
 
}
