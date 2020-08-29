import UIKit

class HistoryTableViewController: UITableViewController, ApiCallback {
    
    @IBOutlet var historyTableView: UITableView!
    var model : Dictionary<String, [OperationModel]>! = nil
    var name : String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let logo = UIImage(named: "Logo.png")
        navigationItem.titleView = UIImageView(image:logo)
        
        let request = GetNameHistoryApiRequest()
        request.delegate = self
        request.DispatchWithName(name: name)
    }


    // MARK: - UITableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        if model != nil && model.count > 0 {
            return 1
        }
        return 0
    }

    ov