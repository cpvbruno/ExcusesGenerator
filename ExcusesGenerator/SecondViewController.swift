import UIKit
import Realm

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var lblJoke: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Just do it!"
        
        let mainJob = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(mainJob, 0)) {
            let job = ExcusesJob()
            job.MainJob()
            dispatch_async(dispatch_get_main_queue()) {
                print("Will print before")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

