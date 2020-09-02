
import UIKit

class NamesTableViewController: UITableViewController, ApiCallback {

    
    @IBOutlet weak var namesTableView: UITableView!
    var names:[String] = []
    var apiRequest : GetNamesApiRequest! = nil
    var selectedName : String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "Logo.png")
        navigationItem.titleView = UIImageView(image:logo)
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped)), animated: true)

        apiRequest = GetNamesApiRequest()
        apiRequest.delegate = self
        apiRequest.Dispatch()
    }

//  MARK: - ApiCallback

    func resultReceived(data : Any!) {
        if names.count > 0 {
            names.append(contentsOf: data as! [String])
        }
        else {
            names = data as! [String];
        }
        
        namesTableView.reloadData()
    }

    func failWithError(error : Error!) {
    }
    
    
    // MARK: - UITableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        if names.count > 0 {
            return 1
        }
        return 0
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (names.count - 30)  { //for a smoother experience
            apiRequest.DispatchWithNextPage()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedName = names[indexPath.row]
        return indexPath
    }

    //  MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue" {
            let destinationVC = segue.destination as! ProfileViewController
            destinationVC.name = selectedName
        }
    }
    
    @objc func addButtonTapped(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "searchSegueIdentifier", sender: self)
    }
}