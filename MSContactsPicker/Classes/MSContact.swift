//
//  MSContact.swift
//  MSContactsPicker
//
//  Created by Matías Spinelli on 20/04/2020.
//

import UIKit
import Contacts

public class MSContact: NSObject {

    private var firstName: String
    private var lastName: String
    private var company: String
    private var thumbnailProfileImage: UIImage?
    public var profileImage: UIImage?
    private var birthday: Date?
    private var birthdayString: String?
    private var contactId: String?
    private var phoneNumbers = [(phoneNumber: String, phoneLabel: String)]()
    private var emails = [(email: String, emailLabel: String )]()
    
    public init (contact: CNContact) {
        firstName = contact.givenName
        lastName = contact.familyName
        company = contact.organizationName
        contactId = contact.identifier
        
        if let thumbnailImageData = contact.thumbnailImageData {
            thumbnailProfileImage = UIImage(data:thumbnailImageData)
        }
        
        if let imageData = contact.imageData {
            profileImage = UIImage(data:imageData)
        }
        
        if let birthdayDate = contact.birthday {
            birthday = Calendar(identifier: Calendar.Identifier.gregorian).date(from: birthdayDate)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM aa"
            birthdayString = dateFormatter.string(from: birthday!)
        }
        
        for phoneNumber in contact.phoneNumbers {
            var phoneLabel = "phone"
            if let label = phoneNumber.label {
                phoneLabel = label
            }
            let phone = phoneNumber.value.stringValue
            
            phoneNumbers.append((phone,phoneLabel))
        }
        
        for emailAddress in contact.emailAddresses {
            guard let emailLabel = emailAddress.label else { continue }
            let email = emailAddress.value as String
            
            emails.append((email,emailLabel))
        }
    }
    
    public func displayName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    public func contactInitials() -> String {
        var initials = String()
        
        if let firstNameFirstChar = firstName.first {
            initials.append(firstNameFirstChar)
        }
        
        if let lastNameFirstChar = lastName.first {
            initials.append(lastNameFirstChar)
        }
        
        return initials
    }
    
    public func displayPhoneNumer() -> String {
        return phoneNumbers.first!.phoneNumber
    }
    
    
}
