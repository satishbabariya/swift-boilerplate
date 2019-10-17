import Async
import Foundation
import UserNotifications

struct PushNotification {
   var id: String?
   var alert: String?
   var badge: String?

   init?(raw: [AnyHashable: Any]) {
       if let aps: [String: Any] = raw["aps"] as? [String: Any] {
           if let alert: String = aps["alert"] as? String {
               self.alert = alert
           }
           if let badge: String = aps["badge"] as? String {
               self.badge = badge
           }
       }
   }
}

/// Push Notification Management
final class PushNotificationService {
    // MARK: - Attributes -
    fileprivate static let delegate = UserNotificationCenterDelegate()

    // MARK: - Methods -
    /// Setup Push Notification
    static func setupNotificationCenter() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        notificationCenter.delegate = delegate
        notificationCenter.requestAuthorization(options: options) { granted, _ in
            guard granted else {
                return
            }
            // Do some stuff
            self.getNotificationSettings()
        }
    }

    fileprivate static func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                return
            }
            Async.main {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}

extension PushManager {
    // MARK: Handle Token
    fileprivate static func handleDeviceToken(deviceToken: Data) {
        // Do some stuff with token
    }

    // MARK: Handle Notification
   fileprivate static func handleNotification(request: UNNotificationRequest) {
       self.handleNotification(raw: request.content.userInfo, id: request.identifier)
   }

   fileprivate static func handleNotification(raw: [AnyHashable: Any], id: String? = nil) {
    
       guard var notification = PushNotification(raw: raw) else {
           return
       }
       notification.id = id
       self.handleNotification(notification)
   }

   fileprivate static func handleNotification(_ notification: PushNotification) {
       switch UIApplication.shared.applicationState {
       case .active:
           if let title: String = notification.alert {
            //    Show Notification Alert
            //    MessageManager.topMessage(message: title, type: .info, id: notification.id)
           }
           break
       case .inactive:
           break
       case .background:
           break
       }
   }
}

// MARK: - UNUserNotificationCenterDelegate -
/// UNUserNotificationCenterDelegate Class
final class UserNotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler _: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        PushManager.handleNotification(request: notification.request)
    }

    func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler _: @escaping () -> Swift.Void) {
         PushManager.handleNotification(request: response.notification.request)
    }
}

// MARK: - AppDelegate -
extension AppDelegate {
    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PushManager.handleDeviceToken(deviceToken: deviceToken)
    }

    func application(_: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler _: @escaping (UIBackgroundFetchResult) -> Void) {
        PushManager.handleNotification(raw: userInfo)
    }
}
