import UIKit

class EventDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var starDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = event?.title
        descriptionTextView.text = event?.description
        starDateLabel.text = event?.startDate
        endDateLabel.text = event?.endDate
    }
}
