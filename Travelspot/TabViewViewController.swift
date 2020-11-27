//
//  TabViewViewController.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 11/26/20.
//

import UIKit
import SOTabBar

class TabViewViewController: SOTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let homeView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeView")
        let feedView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedView")
        let addView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddView")
        let discoverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiscoverView")
        let profileView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileView")
        
        
        homeView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        feedView.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "group"), selectedImage: UIImage(named: "group"))
        addView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "add"), selectedImage: UIImage(named: "add"))
        discoverView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "search"), selectedImage: UIImage(named: "search"))
        profileView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "face"), selectedImage: UIImage(named: "face"))
        
        viewControllers = [homeView,feedView,addView,discoverView,profileView]

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
