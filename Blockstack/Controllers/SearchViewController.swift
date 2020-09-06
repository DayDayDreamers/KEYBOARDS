import UIKit

class SearchViewController: UIViewController, ApiCallback {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var statusStackView: UIStackView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "Logo.png")
        navigationItem.titleView = UIImageView(image:logo)
        
        priceStackView.isHidden = true
        statusStackView.isHidden = true
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        view.endEditing(true)
        priceStackView.isHidden = true
        statusStackView.isHidden = true
        
        let str = searchTextField.text?.trimmingCharacters(in: .whitespaces)
        if str?.count == 0 {
            return
        }
        
        let request = GetNameStatusApiRequest()
        request.delegate = self
        request.DispatchWithName(name: searchTextField.text!.trimmingCharacters(in: .whitespaces).lowercased())
    }
    
    @IBAction func editFinished(_ sender: Any) {
        view.endEditing(true)
    }
    
    //  MARK: - ApiCallback
    
    func resultReceived(data: Any!) {
        if let model = data as? NameModel {
            statusLabel.text = model.status.count > 0 ? model.status : model.error
            statusStackView.isHidden = false
            if model.status == "available" {
                let request = GetNamePriceApiRequest()
                request.delegate = self
                request.Dispa