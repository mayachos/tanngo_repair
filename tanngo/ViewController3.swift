//
//  ViewController3.swift
//  tanngo
//
//  Created by 山邉瑛愛 on 2021/08/08.
//

import UIKit
import AVFoundation
import RealmSwift

class ViewController3: UIViewController, UITableViewDataSource {
    
    
    //Realmを宣言
    let realm = try! Realm()
    
    //StoryBoadで扱うTableViewを宣言
    @IBOutlet var table: UITableView!
    
    //単語を見れるようにする配列
    var tangoArray = [String]()
    //単語を見れるようにする配列
    var imiArray = [String]()
    //単語のファイル名を入れるための配列
    var fileNameArray = [String]()
    //単語の画像を入れるための配列
    var imageArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memo: Results<Memo>? = read()
        for i in 0..<memo!.count {
            if let memo = memo {
            if memo[i].gazou != ""{
                //URL型にキャスト
                let fileURL = URL(string: memo[i].gazou)
                //パス型に変換
                let filePath = fileURL?.path
                imageArray.append((UIImage(contentsOfFile: filePath!) ?? UIImage(named: "noimage.jpeg"))!)
            } else {
                imageArray.append(UIImage(named: "noimage.jpeg")!)
            }
            tangoArray.append(memo[i].tango)
            imiArray.append(memo[i].imi)
        }
    }
    
    
    
        
        //テーブルビューのデータソースはViewControllerクラスに書くよ、という設定
        table.dataSource = self
        
        //tangoArrayに単語を入れていく
        //tangoArray =  memo.tango
        //tangoArray = memo.imi
    
        //fileNameArrayに単語の画像を入れていく
        //imageArray = []
        
    }
func read() -> Results<Memo>?{
    return realm.objects(Memo.self)
}
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //セルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セルの数をtangoArrayの数にする
        return imiArray.count
    }
    
    //ID付きのセルを取得して、セル付属のtextLabelにテストと表示させてみる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Cell") as! SampleTableViewCell
        
        //セルにtangoArrayの単語を表示する
        cell.tangoLabel?.text = tangoArray[indexPath.row]
        //セルにtangoArrayの単語を表示する
        cell.imiLabel?.text = imiArray[indexPath.row]
        //セルに単語の画像を表示する
        cell.tangoImageView?.image = imageArray[indexPath.row]
        return cell
    }

}
