//
//  Memo.Swift
//  tanngo
//
//  Created by 山邉瑛愛 on 2021/06/13.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var tango: String = ""
    @objc dynamic var imi: String = ""
    @objc dynamic var gazou: String = ""
}

struct MemoModel {
    let tango: String
    let imi: String
    let gazou: String
}
