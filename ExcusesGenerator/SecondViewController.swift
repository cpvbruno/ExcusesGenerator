import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var lblJoke: UITextView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Just do it!"
        /*var someJokes = [String]()
         someJokes.append("My dog broken :/")
         someJokes.append("Its Friday? Should have a better reason?")
         someJokes.append("I'm not felling great today")
         someJokes.append("Car Issues")
         someJokes.append("I will need to stay at home to receive a package")
         //let diceRoll = Int(arc4random_uniform(UInt32(someJokes.count)))*/
        //lblJoke.text = someJokes[diceRoll]
        
        
        Alamofire.request(.GET, "https://spreadsheets.google.com/feeds/list/18-mEkpUsKm5O7XyXdhM95iUEmdCDOI_PYNa4adfDECQ/od6/public/basic?alt=json", parameters: [:])
            .responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    // print(swiftyJsonVar)
                    let feed = swiftyJsonVar["feed"]
                    let entry = feed["entry"]
                    
                    for (key, subJson) in entry {
                        if let title = entry.arrayObject {
                            self.arrRes = title as! [[String:AnyObject]]
                            let index:Int? = Int(key)
                            let items = self.arrRes[index!]["title"]
                            print(items!["$t"])
                        }
                    }
                }
        }
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

