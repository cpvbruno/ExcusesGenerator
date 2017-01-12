import Foundation
import Alamofire
import SwiftyJSON
import Realm

class ExcusesJob {
    
    func ExcusesJob() {
        
    }
    
    func MainJob() {
        erasaRealmData()
        var arrRes = [[String:AnyObject]]() //Array of dictionary
        Alamofire.request(.GET, "https://spreadsheets.google.com/feeds/list/18-mEkpUsKm5O7XyXdhM95iUEmdCDOI_PYNa4adfDECQ/od6/public/basic?alt=json", parameters: [:])
            .responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    // print(swiftyJsonVar)
                    let feed = swiftyJsonVar["feed"]
                    let entry = feed["entry"]
                    for (key, subJson) in entry {
                        if let title = entry.arrayObject {
                            arrRes = title as! [[String:AnyObject]]
                            let index:Int? = Int(key)
                            let items = arrRes[index!]["title"]
                            //print(items!["$t"])
                            var item:String = items!["$t"] as! String
                            self.updateRealmData(item)
                            var excuses: RLMResults {
                                get {
                                    print(ExcuseItem.allObjects())
                                    return ExcuseItem.allObjects()
                                }
                            }
                            print(excuses)
                           
                        }
                    }
                }
        }

    }
    func updateRealmData(item:String) {
        let realm = RLMRealm.defaultRealm()
        let newExcuseItem = ExcuseItem()
        newExcuseItem.excuseName = item
        try! realm.transactionWithBlock() {
            realm.addObject(newExcuseItem)
        }
        /*var excuses: RLMResults {
            get {
                print(ExcuseItem.allObjects())
                return ExcuseItem.allObjects()
            }
        }
        print(excuses)*/
    }
    func erasaRealmData() {
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.deleteAllObjects()
        try! realm.commitWriteTransaction()
    }
    
}