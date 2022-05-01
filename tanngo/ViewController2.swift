//
//  ViewController2.swift
//  tanngo
//
//  Created by 山邉瑛愛 on 2021/07/11.
//

import UIKit
import RealmSwift

class ViewController2: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet var eitangolabel :UILabel!
    @IBOutlet var nihongolabel :UILabel!
    @IBOutlet var tangokakusubutton :UIButton!
    @IBOutlet var nihongodasubutton :UIButton!
    @IBOutlet var showImageView: UIImageView!
    @IBOutlet var TangokakusuButton: UIButton!
    @IBOutlet var NihongodasuButton: UIButton!
    
    var a : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TangokakusuButton.layer.cornerRadius = 50
        NihongodasuButton.layer.cornerRadius = 50
        
        //変更
        let memo: Results<Memo>? = read()
        if let memo = memo {
            if memo[a].gazou != ""{
                //URL型にキャスト
                let fileURL = URL(string: memo[a].gazou)
                //パス型に変換
                let filePath = fileURL?.path
                showImageView.image = UIImage(contentsOfFile: filePath!)
            } else {
                showImageView.image = UIImage(named: "noimage.jpeg")
            }
            eitangolabel.text = memo[a].tango
            nihongolabel.text = memo[a].imi
        }
    }
    //変更
    func read() -> Results<Memo>?{
        return realm.objects(Memo.self)
    }
   
    
    @IBAction func mae(){
        //変更
        let memo: Results<Memo>? = read()
        if let memo = memo {
            if a > 0{
                a = a - 1
            }else{
                a = memo.count - 1
            }
        }
        setUI()
    }
    
    @IBAction func tugi(){
        //変更
        let memo: Results<Memo>? = read()
        if let memo = memo {
            if a < memo.count - 1 {
                a = a + 1
            } else {
                a = 0
            }
        }
        setUI()
    }
    func setUI(){
        //変更
        let memo: Results<Memo>? = read()
        if let memo = memo {
            eitangolabel.text = memo[a].tango
            nihongolabel.text = memo[a].imi
            if memo[a].gazou != ""{
                //URL型にキャスト
                let fileURL = URL(string: memo[a].gazou)
                //パス型に変換
                let filePath = fileURL?.path
                showImageView.image = UIImage(contentsOfFile: filePath!)
            } else {
                showImageView.image = UIImage(named: "noimage.jpeg")
            }
        }
    }
    
    @IBAction func tangokakusu() {
        
        if eitangolabel.isHidden == false {
            eitangolabel.isHidden = true
            tangokakusubutton.setTitle("単語を出す", for: .normal)
        }else{
            eitangolabel.isHidden = false
            tangokakusubutton.setTitle("単語を隠す", for: .normal)
        }
        
    }
    
    @IBAction func nihongokakusu() {
        
        if nihongolabel.isHidden == false {
            nihongolabel.isHidden = true
            nihongodasubutton.setTitle("日本語を出す", for: .normal)
            }else{
                nihongolabel.isHidden = false
                nihongodasubutton.setTitle("日本語を隠す", for: .normal)
            }
        
    }
    
    
    

        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
