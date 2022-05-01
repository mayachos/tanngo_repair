//
//  ViewController.swift
//  tanngo
//
//  Created by 山邉瑛愛 on 2021/05/30.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //変更
    let realm = try! Realm()
    
    @IBOutlet var tangoTextField: UITextField!
    @IBOutlet var imiTextFiled: UITextField!
    @IBOutlet var cameraImageView : UIImageView!
    
    var eigotext :String = ""
    var nihongotext :String = ""
    
    // ドキュメントディレクトリの「ファイルURL」（URL型）定義
    var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    // ドキュメントディレクトリの「パス」（String型）定義
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        tangoTextField.delegate = self
        imiTextFiled.delegate = self
       
    }
    
    //変更
    func read() -> Results<Memo>?{
        return realm.objects(Memo.self)
    }
    
    //カメラロールにある画像を読み込む時のメソッド
    @IBAction func openAlbum() {
        //カメラロールが使えるかの確認
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            //カメラロールの画像を選択して画像を表示させるまでの一連の流れ
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }
    }
    
    //カメラ、カメラロールを使った時に選択した画像をアプリ内に表示させるためのメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        
        cameraImageView.image = info[.editedImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //保存するためのパスを作成する
    func createLocalDataFile() {
        // 作成するテキストファイルの名前
        let fileName = "\(NSUUID().uuidString).png"
        
        // DocumentディレクトリのfileURLを取得
        if documentDirectoryFileURL != nil {
            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
            let path = documentDirectoryFileURL.appendingPathComponent(fileName)
            documentDirectoryFileURL = path
        }
    }
    
    //画像を保存する関数の部分
    func saveImage() {
        createLocalDataFile()
        if cameraImageView.image != nil{
            //pngで保存する場合
            let pngImageData = cameraImageView.image?.pngData()
            do {
                try pngImageData!.write(to: documentDirectoryFileURL)
            } catch {
                //エラー処理
                print("エラー")
            }
        }
    }
   
    
    @IBAction func save() {
        let tango: String = tangoTextField.text!
        let imi: String = imiTextFiled.text!
        //変更
        saveImage()
        
        let newMemo = Memo()
        newMemo.tango = tango
        newMemo.imi = imi
        
        //変更
        if cameraImageView.image != nil {
            do{
                try newMemo.gazou = documentDirectoryFileURL.absoluteString
            } catch {
                print("画像の保存に失敗しました")
            }
        } else {
            newMemo.gazou = ""
        }
        
        
        try! realm.write {
            realm.add(newMemo)
        }
        for i in 0..<realm.objects(Memo.self).count{
            print(realm.objects(Memo.self)[i].gazou)
        }
        
        let alert: UIAlertController = UIAlertController(title: "完了", message: "保存しました",preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //変更(TextFieldを下げたいなら、このメソッドかも!)
    func textFieldShouldReturn(_ tangoField: UITextField) -> Bool {
        tangoField.resignFirstResponder()
    }


}

