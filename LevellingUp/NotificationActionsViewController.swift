//
// Copyright 2015 Scott Logic
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit

class NotificationActionsViewController: UIViewController {
  
  @IBOutlet weak var lastAskedLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Request authorisation for local notifications
    let requestedTypes = UIUserNotificationType.Alert
    let settingsRequest = UIUserNotificationSettings(forTypes: requestedTypes, categories: nil)
    UIApplication.sharedApplication().registerUserNotificationSettings(settingsRequest)
    
    // Handle local notifications being fired
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleLocalNotificationReceived:", name: localNotificationFiredKey, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  @IBAction func handleAskMeLaterPressed(sender: AnyObject) {
    // Cancel any existing notifications
    UIApplication.sharedApplication().cancelAllLocalNotifications()
    
    // Create a new notification
    let notification = UILocalNotification()
    notification.fireDate = NSDate(timeIntervalSinceNow: 3)
    notification.alertBody = "Asking you now"
    
    // Schedule Notification
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
  }
  
  
  // Notification handling
  func handleLocalNotificationReceived(notification: NSNotification) {
    if let userInfo = notification.userInfo,
      let localNotification = userInfo["notification"] as? UILocalNotification {
        lastAskedLabel.text = "You Answered!"
    }
  }

}
