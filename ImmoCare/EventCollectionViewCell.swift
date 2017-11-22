import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!

    // get title and description of events
    func configureCellWith(event: Event) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
    } // function configureCellWith
} // class
