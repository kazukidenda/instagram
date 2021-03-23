//
//  TabBarControllerViewController.swift
//  Instagram
//
//  Created by 傳田和樹 on 2021/03/13.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//タブアイコンの色
        self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        //タブバーの背景色
        self.tabBar.barTintColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        //UITabBarControllerDelegateプロトコルのメソッドをこのクラスで処理する
        self.delegate = self
        
        // Do any additional setup after loading the view.
    }
    //タブバーのアイコンがタップされた時に呼ばれるdelegateメソッドを処理する
   
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("投稿ボタンが押された")
        if viewController is ImageSelectViewController {
       //ImageSelectViewControllerはタブ切り替えではなくモーダル画面遷移する
            let imageSelectViewController = storyboard!.instantiateViewController(withIdentifier: "ImageSelect")
            present(imageSelectViewController, animated: true)
            return false
            
        
        }else{
            //その他のViewControllerは通常のタブ切り替えを実施
            return true
            
        
        }
    }
    
override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
    
    //currentUserがnilならログインしない
    if Auth.auth().currentUser == nil {
        //ログインしてない時の処理
        let LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(LoginViewController!, animated: true, completion: nil)
    }
}
}
