import UIKit

class HistoryTableViewController: UITableViewController, ApiCallback {
    
    @IBOutlet var historyTableView: UITableView!
    var model : Dictionary<String, [OperationModel]>! = nil
    var name : String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let logo = UIImage(named: "Logo.png")
        navigat