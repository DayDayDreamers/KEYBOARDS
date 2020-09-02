
import UIKit

class ProfileViewController: UIViewController, ApiCallback, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profilesLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    var model : UserProfileModel! = nil
    var name : String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "Logo.png")
        navigationItem.titleView = UIImageView(image:logo)
        
        profilesLabel.isHidden = true
        imageView.setRadius()
        
        let request = GetUserProfileApiRequest()
        request.delegate = self;
        request.DispatchWithName(name: name)
    }

    func populateHeader(images:[ImageModel], id: String, owner: String, name: String, description: String) {
        if images.count > 0 {
            DispatchQueue.global().async {
                let url = URL(string: images[0].contentUrl)
                let data = try? Data(contentsOf: url!)
                if data != nil {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data!)
                    }
                }
            }
        }
        idLabel.text = id
        ownerLabel.text = owner
        nameLabel.text = name
        descriptionLabel.text = description
    }
    
    // MARK: - ApiCallback
    
    func resultReceived(data : Any!) {
        model = data as! UserProfileModel
        populateHeader(images: model.profile.images, id: name, owner: model.owner, name: model.profile.name, description: model.profile.description)
        
        if model.profile.accounts.count > 0 {
            profileTableView.reloadData()
            profilesLabel.isHidden = false
        }
    }

    func failWithError(error : Error!) {
    }
    
    // MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if model != nil && model.profile.accounts.count > 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model != nil {
            return model.profile.accounts.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileReusableCell", for: indexPath)
        let profile = model.profile.accounts[indexPath.row]
        
        if profile.proofUrl.count > 0 || profile.contentUrl.count > 0 {
            cell.imageView?.image = UIImage(named: "Link")
        }
        cell.textLabel?.text = "\(profile.service)"
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = " \(profile.proofUrl.count > 0 ? profile.proofUrl : profile.identifier)"
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,  didSelectRowAt indexPath: IndexPath) {
        let profile = model.profile.accounts[indexPath.row]
        if profile.proofUrl.count > 0 {
            UIApplication.shared.open(URL(string:profile.proofUrl)!)
        }
        else if profile.contentUrl.count > 0 {
            UIApplication.shared.open(URL(string:profile.contentUrl)!)

        }
    }
    
    //  MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
            let destinationVC = segue.destination as! HistoryTableViewController
            destinationVC.name = name
    }
}