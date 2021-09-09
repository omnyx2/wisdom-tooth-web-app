//
//  ViewController.swift
//  WisdomToothWebApp
//
//  Created by 류현석 on 2021/08/25.
//

import UIKit

import WebKit

@objc(ViewController)
class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
//    ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ
    override func loadView() {
                super.loadView()
                if Reachability.isConnectedToNetwork() {
                    print("Internet connection OK")
                } else {
                    print("Internet connection FAILED")
                    var alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                webView = WKWebView(frame: self.view.frame)
                webView.uiDelegate = self
                webView.navigationDelegate = self
                self.view = self.webView
            }

        override func viewDidLoad() {
            
            super.viewDidLoad()
           
            let url = URL(string: "http://invisionlab.xyz:5008/")
            let request = URLRequest(url: url!)
            //self.webView?.allowsBackForwardNavigationGestures = true  //뒤로가기 제스쳐 허용
            webView.configuration.preferences.javaScriptEnabled = true  //자바스크립트 활성화
            webView.load(request)
//
//            NotificationCenter.default.addObserver(
//              self,
//              selector: #selector(displayFCMToken(notification:)),
//              name: Notification.Name("FCMToken"),
//              object: nil
//            )

        }
        
        override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() } //모달창 닫힐때 앱 종료현상 방지.
        
        //alert 처리
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
            self.present(alertController, animated: true, completion: nil) }

        //confirm 처리
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
            self.present(alertController, animated: true, completion: nil) }
        
        // href="_blank" 처리
//        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//            if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }
//            return nil }
    
//
//    //fcm 처리
//    @IBAction func handleLogTokenTouch(_ sender: UIButton) {
//       // [START log_fcm_reg_token]
//       let token = Messaging.messaging().fcmToken
//       print("FCM token: \(token ?? "")")
//       // [END log_fcm_reg_token]
//       fcmTokenMessage.text = "Logged FCM token: \(token ?? "")"
//
//       // [START log_iid_reg_token]
//       Messaging.messaging().token { token, error in
//         if let error = error {
//           print("Error fetching remote FCM registration token: \(error)")
//         } else if let token = token {
//           print("Remote instance ID token: \(token)")
//           self.remoteFCMTokenMessage.text = "Remote FCM registration token: \(token)"
//         }
//       }
//       // [END log_iid_reg_token]
//     }
//
//     @IBAction func handleSubscribeTouch(_ sender: UIButton) {
//       // [START subscribe_topic]
//       Messaging.messaging().subscribe(toTopic: "weather") { error in
//         print("Subscribed to weather topic")
//       }
//       // [END subscribe_topic]
//     }
//
//     @objc func displayFCMToken(notification: NSNotification) {
//       guard let userInfo = notification.userInfo else { return }
//       if let fcmToken = userInfo["token"] as? String {
//         fcmTokenMessage.text = "Received FCM token: \(fcmToken)"
//       }
//     }
    }
