import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = #colorLiteral(red: 0, green: 0.4117647059, blue: 0.2509803922, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6526352167, green: 0.6921032071, blue: 0.7097077966, alpha: 1)
        tabBar.barTintColor = .white
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            appearance.stackedLayoutAppearance.selected.iconColor = #colorLiteral(red: 0, green: 0.4117647059, blue: 0.2509803922, alpha: 1)
            
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1)
            ]
            appearance.stackedLayoutAppearance.normal.iconColor = #colorLiteral(red: 0.6526352167, green: 0.6921032071, blue: 0.7097077966, alpha: 1)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: #colorLiteral(red: 0.6526352167, green: 0.6921032071, blue: 0.7097077966, alpha: 1)
            ]
            
            appearance.inlineLayoutAppearance = appearance.stackedLayoutAppearance
            appearance.compactInlineLayoutAppearance = appearance.stackedLayoutAppearance
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

/*
 import UIKit

 class MainTabBarController: UITabBarController {
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         // Selected tab item ka color
         tabBar.tintColor = #colorLiteral(red: 0.0, green: 0.6, blue: 0.3, alpha: 1.0)
         
         // Unselected tab items ka color
         tabBar.unselectedItemTintColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
         
         // Background (optional)
         tabBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
     }
 }

 */
