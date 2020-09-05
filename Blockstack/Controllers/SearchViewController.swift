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
        
        let str = searchTextField.text?.trimmingCharacters(in: .whitespace