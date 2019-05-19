//
//  ViewController.swift
//  Streamr
//
//  Created by Ryan Token on 5/17/19.
//  Copyright © 2019 Ryan Token. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    var items = [UIImage(named: "Hulu"), UIImage(named: "Vue"), UIImage(named: "YouTubeTV"), UIImage(named: "SlingBlue"), UIImage(named: "SlingOrange")]
    var subtitles: [String] = ["Hulu + Live TV", "Vue Access", "YouTube TV", "Sling Blue", "Sling Orange"]
    
    private let api = API() // Instantiate my API class
    
    private let hulu = "hulu" // Hulu with Live TV
    private let vue = "vue" // PlayStation Vue Access
    private let yttv = "yttv" // YouTube TV
    private let slingBlue = "sling-blue" // Sling Blue Package
    private let slingOrange = "sling-orange" // Sling Orange Package
    
    private var huluPrice: String = ""
    private var huluChannels: [String] = []
    
    private var vuePrice: String = ""
    private var vueChannels: [String] = []
    
    private var yttvPrice: String = ""
    private var yttvChannels: [String] = []
    
    private var slingBluePrice: String = ""
    private var slingBlueChannels: [String] = []
    
    private var slingOrangePrice: String = ""
    private var slingOrangeChannels: [String] = []
    
    // Get all channels from my API endpoints and save them to huluChannels/vueChannels/yttvChannels
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getChannels(from: hulu, priceCompletionHandler: { [weak self] price in
            self?.huluPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.huluChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: vue, priceCompletionHandler: { [weak self] price in
            self?.vuePrice = price ?? "Could not retrieve price for Vue"
            }, channelCompletionHandler: { [weak self] channels in
                self?.vueChannels = channels ?? ["Could not retrieve channels for Vue"]
        })
        
        api.getChannels(from: yttv, priceCompletionHandler: { [weak self] price in
            self?.yttvPrice = price ?? "Could not retrieve price for YouTube TV"
            }, channelCompletionHandler: { [weak self] channels in
                self?.yttvChannels = channels ?? ["Could not retrieve channels for YouTube TV"]
        })
        
        api.getChannels(from: slingBlue, priceCompletionHandler: { [weak self] price in
            self?.slingBluePrice = price ?? "Could not retrieve price for Sling Blue"
            }, channelCompletionHandler: { [weak self] channels in
                self?.slingBlueChannels = channels ?? ["Could not retrieve channels for Sling Blue"]
        })
        
        api.getChannels(from: slingOrange, priceCompletionHandler: { [weak self] price in
            self?.slingOrangePrice = price ?? "Could not retrieve price for Sling Orange"
            }, channelCompletionHandler: { [weak self] channels in
                self?.slingOrangeChannels = channels ?? ["Could not retrieve channels for Orange"]
        })
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.cellImage.image = self.items[indexPath.item]
        cell.cellImage.layer.borderColor = UIColor.lightGray.cgColor
        cell.cellImage.layer.borderWidth = 1
        
        cell.cellSubtitle.text = self.subtitles[indexPath.item]
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowHulu", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Hulu + Live TV"
            controller.priceLabel = huluPrice
            controller.channels = huluChannels
            controller.color = UIColor.Colors.Green.MountainMeadow
        }
        
        if segue.identifier == "ShowVue", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Vue Access"
            controller.priceLabel = vuePrice
            controller.channels = vueChannels
            controller.color = UIColor.Colors.Blue.PlayStation
        }
        
        if segue.identifier == "ShowYTTV", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "YouTube TV"
            controller.priceLabel = yttvPrice
            controller.channels = yttvChannels
            controller.color = UIColor.Colors.Red.YouTubeTV
        }
        
        if segue.identifier == "ShowSlingBlue", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Sling Blue"
            controller.priceLabel = slingBluePrice
            controller.channels = slingBlueChannels
            controller.color = UIColor.Colors.Blue.Mariner
        }
        
        if segue.identifier == "ShowSlingOrange", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Sling Orange"
            controller.priceLabel = slingOrangePrice
            controller.channels = slingOrangeChannels
            controller.color = UIColor.Colors.Orange.Sun
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if indexPath.item == 0 {
            self.performSegue(withIdentifier: "ShowHulu", sender: self)
        } else if indexPath.item == 1 {
            self.performSegue(withIdentifier: "ShowVue", sender: self)
        } else if indexPath.item == 2 {
            self.performSegue(withIdentifier: "ShowYTTV", sender: self)
        } else if indexPath.item == 3 {
            self.performSegue(withIdentifier: "ShowSlingBlue", sender: self)
        } else if indexPath.item == 4 {
            self.performSegue(withIdentifier: "ShowSlingOrange", sender: self)
        }
    }
    
    // change background color when user touches cell
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    
    // change background color back when user releases touch
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }
    
}
