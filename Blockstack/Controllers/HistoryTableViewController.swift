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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model != nil && model.count > 0 {
            return model.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyReusableCell", for: indexPath)
        cell.textLabel?.text = Array(model)[indexPath.row].value[0].operation
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = "Block #\(Array(model)[indexPath.row].key)"
        cell.detailTextLabel?.textColor = .white
        return cell
    }
    
    //  MARK: - ApiCallback

    func resultReceived(data: Any!) {
        model = data as! 