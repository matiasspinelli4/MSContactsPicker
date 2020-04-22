//
//  MSContactsViewController.swift
//  MSContactsPicker
//
//  Created by Matías Spinelli on 20/04/2020.
//

import UIKit
import Contacts

typealias ContactsHandler = (_ contacts : [CNContact] , _ error : NSError?) -> Void

public class MSContactsViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    var contacts: [MSContact] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        
        self.loadContacts()
        
    }
}

// MARK: - Private
extension MSContactsViewController {
 
    private func configureTableView() {
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        
        let MSContactTableViewCell = "MSContactTableViewCell"
        let bundle = Bundle(for: MSContactsViewController.self)
        self.contactsTableView.register(UINib(nibName: MSContactTableViewCell, bundle: bundle), forCellReuseIdentifier: MSContactTableViewCell)
    }
    
    private func loadContacts() {
        let store = CNContactStore()
        do {
            let predicate = CNContact.predicateForContactsInContainer(withIdentifier: store.defaultContainerIdentifier())
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: allowedContactKeys())
                
            print("Fetched contacts: \(contacts)")
            
            self.contacts = contacts.map{ MSContact(contact: $0)}

            self.contactsTableView.reloadData()
        } catch {
            print("Failed to fetch contact, error: \(error)")
            // Handle the error
        }
    }
    
    private func allowedContactKeys() -> [CNKeyDescriptor]{
        //We have to provide only the keys which we have to access. We should avoid unnecessary keys when fetching the contact. Reducing the keys means faster the access.
        return [CNContactNamePrefixKey as CNKeyDescriptor,
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactOrganizationNameKey as CNKeyDescriptor,
            CNContactBirthdayKey as CNKeyDescriptor,
            CNContactImageDataKey as CNKeyDescriptor,
            CNContactThumbnailImageDataKey as CNKeyDescriptor,
            CNContactImageDataAvailableKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor,
            CNContactEmailAddressesKey as CNKeyDescriptor,
        ]
    }
}

extension MSContactsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MSContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MSContactTableViewCell", for: indexPath) as! MSContactTableViewCell
                
        cell.configuereWithContact(contact: self.contacts[indexPath.row])
        
        return cell
    }
    
}

extension MSContactsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
