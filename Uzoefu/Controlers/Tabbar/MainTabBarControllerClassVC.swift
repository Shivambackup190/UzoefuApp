import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        tabBar.tintColor = #colorLiteral(red: 0.4941176471, green: 0.8235294118, blue: 0, alpha: 1)
     
        tabBar.unselectedItemTintColor = UIColor.gray
        
       
        tabBar.barTintColor = UIColor.white
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            appearance.stackedLayoutAppearance.selected.iconColor = .systemGreen
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
            
            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
            
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
