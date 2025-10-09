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

