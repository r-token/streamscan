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
    
    var items = [UIImage(named: "DirecTVNowPlus"), UIImage(named: "DirecTVNowMax"), UIImage(named: "Fubo"), UIImage(named: "Hulu"), UIImage(named: "Philo"), UIImage(named: "SlingBlue"), UIImage(named: "SlingOrange"), UIImage(named: "VueAccess"), UIImage(named: "VueCore"), UIImage(named: "YouTubeTV")]
    var subtitles: [String] = ["Now Plus", "Now Max", "Fubo TV", "Hulu + Live TV", "Philo", "Sling Blue", "Sling Orange", "Vue Access", "Vue Core", "YouTube TV"]
    
    private let api = API() // Instantiate my API class
    
    private let dtvNowPlus = "dtvnow-plus" // DirecTV Now - Plus Package
    private let dtvNowMax = "dtvnow-max" // DirecTV Now - Max Package
    private let fubo = "fubo" // Fubo TV
    private let hulu = "hulu" // Hulu with Live TV
    private let philo = "philo" // Philo
    private let slingBlue = "sling-blue" // Sling TV - Blue Package
    private let slingOrange = "sling-orange" // Sling TV - Orange Package
    private let vueAccess = "vue-access" // PlayStation Vue - Access Package
    private let vueCore = "vue-core" //PlayStation Vue - Core Package
    private let yttv = "yttv" // YouTube TV
    
    private var dtvNowPlusPrice: String = ""
    private var dtvNowPlusChannels: [String] = []
    
    private var dtvNowMaxPrice: String = ""
    private var dtvNowMaxChannels: [String] = []
    
    private var fuboPrice: String = ""
    private var fuboChannels: [String] = []
    
    private var huluPrice: String = ""
    private var huluChannels: [String] = []
    
    private var philoPrice: String = ""
    private var philoChannels: [String] = []
    
    private var slingBluePrice: String = ""
    private var slingBlueChannels: [String] = []
    
    private var slingOrangePrice: String = ""
    private var slingOrangeChannels: [String] = []
    
    private var vueAccessPrice: String = ""
    private var vueAccessChannels: [String] = []
    
    private var vueCorePrice: String = ""
    private var vueCoreChannels: [String] = []
    
    private var yttvPrice: String = ""
    private var yttvChannels: [String] = []
    
    // Get all channels from my API endpoints and save them to huluChannels/vueChannels/yttvChannels
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getChannels(from: dtvNowPlus, priceCompletionHandler: { [weak self] price in
            self?.dtvNowPlusPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.dtvNowPlusChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: dtvNowMax, priceCompletionHandler: { [weak self] price in
            self?.dtvNowMaxPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.dtvNowMaxChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: fubo, priceCompletionHandler: { [weak self] price in
            self?.fuboPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.fuboChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: hulu, priceCompletionHandler: { [weak self] price in
            self?.huluPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.huluChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: philo, priceCompletionHandler: { [weak self] price in
            self?.philoPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.philoChannels = channels ?? ["Could not retrieve channels for Hulu"]
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
        
        api.getChannels(from: vueAccess, priceCompletionHandler: { [weak self] price in
            self?.vueAccessPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.vueAccessChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: vueCore, priceCompletionHandler: { [weak self] price in
            self?.vueCorePrice = price ?? "Could not retrieve price for Vue"
            }, channelCompletionHandler: { [weak self] channels in
                self?.vueCoreChannels = channels ?? ["Could not retrieve channels for Vue"]
        })
        
        api.getChannels(from: yttv, priceCompletionHandler: { [weak self] price in
            self?.yttvPrice = price ?? "Could not retrieve price for YouTube TV"
            }, channelCompletionHandler: { [weak self] channels in
                self?.yttvChannels = channels ?? ["Could not retrieve channels for YouTube TV"]
        })
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
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
    
    // Change background color when user touches cell
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    
    // Change background color back when user releases touch
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }
    
    // MARK: - Prepare for segue and perform segue
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDTVNowPlus", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "DirecTV Now Plus"
            controller.priceLabel = dtvNowPlusPrice
            controller.channels = dtvNowPlusChannels
            controller.color = UIColor.Colors.Blue.CuriousBlue
        }
        
        if segue.identifier == "ShowDTVNowMax", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "DirecTV Now Max"
            controller.priceLabel = dtvNowMaxPrice
            controller.channels = dtvNowMaxChannels
            controller.color = UIColor.Colors.Blue.CuriousBlue
        }
        
        if segue.identifier == "ShowFubo", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Fubo TV"
            controller.priceLabel = fuboPrice
            controller.channels = fuboChannels
            controller.color = UIColor.Colors.Orange.Fubo
        }
        
        if segue.identifier == "ShowHulu", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Hulu + Live TV"
            controller.priceLabel = huluPrice
            controller.channels = huluChannels
            controller.color = UIColor.Colors.Green.MountainMeadow
        }
        
        if segue.identifier == "ShowPhilo", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Philo"
            controller.priceLabel = philoPrice
            controller.channels = philoChannels
            controller.color = UIColor.Colors.Blue.Philo
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
        
        if segue.identifier == "ShowVueAccess", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Vue Access"
            controller.priceLabel = vueAccessPrice
            controller.channels = vueAccessChannels
            controller.color = UIColor.Colors.Blue.PlayStation
        }
        
        if segue.identifier == "ShowVueCore", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Vue Core"
            controller.priceLabel = vueCorePrice
            controller.channels = vueCoreChannels
            controller.color = UIColor.Colors.Blue.PlayStation
        }
        
        if segue.identifier == "ShowYTTV", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "YouTube TV"
            controller.priceLabel = yttvPrice
            controller.channels = yttvChannels
            controller.color = UIColor.Colors.Red.YouTubeTV
        }
    }
    
    //perform segue
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            self.performSegue(withIdentifier: "ShowDTVNowPlus", sender: self)
        } else if indexPath.item == 1 {
            self.performSegue(withIdentifier: "ShowDTVNowMax", sender: self)
        } else if indexPath.item == 2 {
            self.performSegue(withIdentifier: "ShowFubo", sender: self)
        } else if indexPath.item == 3 {
            self.performSegue(withIdentifier: "ShowHulu", sender: self)
        } else if indexPath.item == 4 {
            self.performSegue(withIdentifier: "ShowPhilo", sender: self)
        } else if indexPath.item == 5 {
            self.performSegue(withIdentifier: "ShowSlingBlue", sender: self)
        } else if indexPath.item == 6 {
            self.performSegue(withIdentifier: "ShowSlingOrange", sender: self)
        } else if indexPath.item == 7 {
            self.performSegue(withIdentifier: "ShowVueAccess", sender: self)
        } else if indexPath.item == 8 {
            self.performSegue(withIdentifier: "ShowVueCore", sender: self)
        } else if indexPath.item == 9 {
            self.performSegue(withIdentifier: "ShowYTTV", sender: self)
        } else {
            print("Somehow we tapped nothing?")
        }
    }
    
}
