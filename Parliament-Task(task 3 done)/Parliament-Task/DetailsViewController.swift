//
//  DetailsViewController.swift
//  Parliament-Task
//
//  Created by iosdev on 4.5.2021.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hetekaIdLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var seatNumberLabel: UILabel!
    @IBOutlet weak var ministerLabel: UILabel!
    
    var member: Member?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the cell...
        
        let baseurl = "https://avoindata.eduskunta.fi/"
        let urlString = member?.pictureUrl
        print(baseurl + urlString!)
        downloadImage(from: URL(string: baseurl + urlString!)!)
        let hetekaID = String(member?.hetekaId ?? 0)
        hetekaIdLabel.text = "hetekaId: \(hetekaID)"
        fullNameLabel.text = "Full Name: \(member?.firstname ?? "") \(member?.lastname ?? "")"
        partyLabel.text = "Party Name: \(member?.party ?? "")"
        let seatnumber = String(member?.seatNumber ?? 0)
        seatNumberLabel.text = "SeatNumber: \(seatnumber)"
        let minisTer = String(member?.minister ?? false)
        ministerLabel.text = "Minister: \(minisTer)"
    }
    
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                print(data)
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
    
}

