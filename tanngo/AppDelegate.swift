//
//  AppDelegate.swift
//  tanngo
//
//  Created by 山邉瑛愛 on 2021/05/30.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //変更したほうがエラー出にくいかも...
        let config = Realm.Configuration(schemaVersion: 0,migrationBlock: { miragration, oldSchemaVersion in
            if(oldSchemaVersion < 1) {
                                            
            }
    })
        

        Realm.Configuration.defaultConfiguration = config
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
          schemaVersion: 4,
          migrationBlock: { migration, oldSchemaVersion in
            migration.enumerateObjects(ofType: Memo.className()) { oldObject, newObject in
              if oldSchemaVersion < 3 {
                newObject!["gazou"] = ""
              }
            }
            migration.enumerateObjects(ofType: Memo.className()) { oldObject, newObject in
              if oldSchemaVersion < 4 {
                newObject!["imi"] = ""
              }
            }

            migration.enumerateObjects(ofType: Memo.className()) { oldObject, newObject in
              if oldSchemaVersion < 4 {
                newObject!["tango"] = ""
              }
            }

          })
        
        
        let realm = try! Realm()
        
        //try! realm.write {
            //realm.deleteAll()
       //}
        
        if realm.objects(Memo.self).count == 0 {
        let newMemo = Memo()
                    newMemo.tango = "apple"
                    newMemo.imi = "りんご"
        var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        if documentDirectoryFileURL != nil {
        // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
                        let path = documentDirectoryFileURL.appendingPathComponent("apple.png")
                        documentDirectoryFileURL = path
                    }
        //pngで保存する場合
                    let pngImageData = UIImage(named: "apple.png")?.pngData()
        do {
        try pngImageData!.write(to: documentDirectoryFileURL)
                    } catch {
        //エラー処理
                        print("エラー")
                    }
        do{
        try newMemo.gazou = documentDirectoryFileURL.absoluteString
                    } catch {
        print("画像の保存に失敗しました")
                    }
        try! realm.write {
                        realm.add(newMemo)
                    }
                }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


