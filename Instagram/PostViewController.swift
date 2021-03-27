//
//  PostViewController.swift
//  Instagram
//
//  Created by 傳田和樹 on 2021/03/12.
//

import UIKit
import Firebase
import SVProgressHUD

class PostViewController: UIViewController {
    
    var image: UIImage!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    //投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handlePostButton(_ sender: Any) {
        //画像をjpeg形式に変換する
        let imageData = image.jpegData(compressionQuality: 0.75)
        //画像と投稿データの保管場所を定義する
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postRef.documentID + ".jpg")
        //HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        //ストレージに画像をアップロードする
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(imageData!, metadata: metadata) { (metadata, error) in if error != nil {
            //画像のアップロード失敗
            print(error!)
            SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
            //投稿処理をキャンセルし先頭画面に戻る
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
            return
            
        }
        //FireStoneに投稿データを保存する
        let name = Auth.auth().currentUser?.displayName
        let postDic = [
            "name":name!,
            "caption": self.textField.text!,
            "date": FieldValue.serverTimestamp(),
        ] as [String : Any]
        postRef.setData(postDic)
        //HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        //投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    //キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        //加工画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //受け取った画像をImageViewに設定する
        imageView.image = image
    }
    
}

