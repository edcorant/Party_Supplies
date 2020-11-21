//
//  FriendRequestTableViewCell.swift
//  Party Supplies
//
//  Created by Andre Guiraud on 11/14/20.
//

import UIKit
import Parse

class FriendRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    var request: PFObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func ignoreRequest(_ sender: Any) {
        UIView.animate(withDuration: 0.3,
            delay: 0,
            options: [.curveLinear, .allowUserInteraction, .beginFromCurrentState],
            animations: {
                self.alpha = 0
            }, completion: nil)
        if let friendRequest = request {
            let friendRequestId = friendRequest.objectId!
            let query = PFQuery(className: "friendRequest")
            query.whereKey("objectId", equalTo: friendRequestId)
            query.getFirstObjectInBackground { (request, error) in
                if let error = error {
                    print("Could not find request. \(error.localizedDescription)")
                } else {
                    request!["status"] = "rejected"
                    request?.saveInBackground()
                }
            }
        }
    }

    @IBAction func acceptRequest(_ sender: Any) {
        UIView.animate(withDuration: 0.3,
            delay: 0,
            options: [.curveLinear, .allowUserInteraction, .beginFromCurrentState],
            animations: {
                self.alpha = 0
            }, completion: nil)
        
        if let friendRequest = request {
            
            let toUser = request!["toUser"] as! PFUser
            let fromUser = request!["fromUser"] as! PFUser
            
            let friendRequestId = friendRequest.objectId!
            let toUserId = toUser.objectId!
            let fromUserId = fromUser.objectId!
            
            PFCloud.callFunction(inBackground: "addFriendToFriendsRelation", withParameters: (["friendRequest":friendRequestId,"toUserId":toUserId,"fromUserId":fromUserId])) { (response, error) in
                if let error = error {
                    print("Failed to establish relationship with \(error.localizedDescription)")
                }
                else {
                    let friendsRelation = toUser.relation(forKey: "friends")
                    friendsRelation.add(fromUser)
                    toUser.saveInBackground()
                    let query = PFQuery(className: "friendRequest")
                    query.whereKey("objectId", equalTo: friendRequestId)
                    query.getFirstObjectInBackground { (request, error) in
                        if let error = error {
                            print("Could not find request. \(error.localizedDescription)")
                        } else {
                            request!["status"] = "accepted"
                            request?.saveInBackground()
                        }
                    }
                }
            }
        }
    }
}

