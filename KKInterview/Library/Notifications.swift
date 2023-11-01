//
//  Notifications.swift
//  KKInterview
//
//  Created by 鍾秉辰 on 2023/11/1.
//

import Foundation

public enum CurrentUserNotifications {
    public static let userUpdated = "CurrentUserNotifications.userUpdated"
}

extension Notification.Name {
    
    public static let kk_userUpdated = Notification.Name(rawValue: CurrentUserNotifications.userUpdated)
}
