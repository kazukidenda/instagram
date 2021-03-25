//
//  PostData.swift
//  Instagram
//
//  Created by 傳田和樹 on 2021/03/17.
//

import UIKit
import Firebase

class PostData: NSObject {

    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [String] = []
    
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.caption = postDic["caption"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let comments = postDic["comments"] as? [String] {
        self.comments = comments
        
        }
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
    
        }
        if let myid = Auth.auth().currentUser?.uid {
            //Likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているのかを判断
            if self.likes.firstIndex(of: myid) != nil {
                //myidがあればいいねを押していると認識する
                self.isLiked = true
               
            }
        }
    }
}

