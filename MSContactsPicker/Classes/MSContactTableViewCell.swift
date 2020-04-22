//
//  MSContactTableViewCell.swift
//  MSContactsPicker
//
//  Created by Matías Spinelli on 20/04/2020.
//

import UIKit

class MSContactTableViewCell: UITableViewCell {

    @IBOutlet weak var imageProfileView: UIView! {
        didSet {
            imageProfileView.layer.cornerRadius = imageProfileView.frame.size.width/2
        }
    }
    
    @IBOutlet weak var initialsLabel: UILabel! {
        didSet {
            // set font
        }
    }
    
    @IBOutlet weak var imageProfile: UIImageView! {
        didSet {
            imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        }
    }
    
    @IBOutlet weak var nameContact: UILabel! {
        didSet {
            // set font
        }
    }
    
    @IBOutlet weak var numberContact: UILabel! {
        didSet {
            // set font
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configuereWithContact(contact: MSContact) {
        nameContact.text = contact.displayName()
        numberContact.text = contact.displayPhoneNumer()
        
        if let profileImage = contact.profileImage {
            imageProfile.image = profileImage
            initialsLabel.isHidden = true
            imageProfile.isHidden = false
            initialsLabel.text = ""
        } else {
            imageProfile.image = nil
            imageProfile.isHidden = true
            initialsLabel.isHidden = false
            initialsLabel.text = contact.contactInitials()
        }
        
        imageProfileView.backgroundColor = randomColor()
    }
        
    private func randomColor() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1),  blue: .random(in: 0...1), alpha: 1.0)
    }
}
