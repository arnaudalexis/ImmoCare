import Foundation
import UIKit

class EventManagerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var data = DataList()
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.eventsList.count
    }  // protocol collectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let eventsList = data.eventsList[section]
        return eventsList.events.count
    }  // protocol collectionView
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EventCollectionViewCell
        
        cell.deleteBtn.layer.setValue(indexPath.row, forKey: "index")
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(EventManagerController.deleteEvent(_:)), for: UIControlEvents.touchUpInside)
        cell.deleteBtn.isHidden = true;
        
        let event = eventAtIndexPath(indexPath: indexPath as NSIndexPath)
        cell.configureCellWith(event: event)
        
        return cell
    } // protocol collectionView
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let event = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Event", for: indexPath) as! EventTitleCollectionReusableView
        return event
    } // protocol collectionView
    
    
    // delete event
    @objc func deleteEvent(_ sender:UIButton!) {
        
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        print(i);
        data.eventsList.remove(at: i)
        self.collectionView?.reloadData()
    } // function deleteEvent
    
    // prepare segue to go to another view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowDetail")
        {
            let eventDetail = segue.destination as! EventDetailViewController
            if let indexPath = self.collectionView!.indexPath(for: sender as! EventCollectionViewCell) {
                eventDetail.event = eventAtIndexPath(indexPath: indexPath as NSIndexPath)
            }
        }
        else if (segue.identifier == "AddEvent")
        {
            let addEvent = segue.destination as! AddEventViewController
            addEvent.getData(data: data)
        }
    } // function prepare
    
    func eventAtIndexPath(indexPath: NSIndexPath) -> Event {
        let eventsList = data.eventsList[indexPath.section]
        return eventsList.events[indexPath.row]
    } // protocol collectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picDimension = self.view.frame.size.width / 3.0
        return CGSize(width: picDimension, height: picDimension)
    } // protocol collectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = self.view.frame.size.width / 10.0
        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    } // protocol collectionView
    
} // class
