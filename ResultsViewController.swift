//
//  ResultsViewController.swift
//  Streamr
//
//  Created by Ryan Token on 5/15/19.
//  Copyright © 2019 Ryan Token. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let reuseIdentifier = "resultCell"
    
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
    
    var dtvNowPlusPrice: String = ""
    var dtvNowPlusChannels: [String] = []
    
    var dtvNowMaxPrice: String = ""
    var dtvNowMaxChannels: [String] = []
    
    var fuboPrice: String = ""
    var fuboChannels: [String] = []
    
    var huluPrice: String = ""
    var huluChannels: [String] = []
    
    var philoPrice: String = ""
    var philoChannels: [String] = []
    
    var slingBluePrice: String = ""
    var slingBlueChannels: [String] = []
    
    var slingOrangePrice: String = ""
    var slingOrangeChannels: [String] = []
    
    var vueAccessPrice: String = ""
    var vueAccessChannels: [String] = []
    
    var vueCorePrice: String = ""
    var vueCoreChannels: [String] = []
    
    var yttvPrice: String = ""
    var yttvChannels: [String] = []
    
    var dtvNowPlusScore = 0
    var dtvNowMaxScore = 0
    var fuboScore = 0
    var huluScore = 0
    var philoScore = 0
    var slingBlueScore = 0
    var slingOrangeScore = 0
    var vueAccessScore = 0
    var vueCoreScore = 0
    var yttvScore = 0
    
    var dtvNowPlusResults: [String] = []
    var dtvNowMaxResults: [String] = []
    var fuboResults: [String] = []
    var huluResults: [String] = []
    var philoResults: [String] = []
    var slingBlueResults: [String] = []
    var slingOrangeResults: [String] = []
    var vueAccessResults: [String] = []
    var vueCoreResults: [String] = []
    var yttvResults: [String] = []
    
    var segues: [String] = []
    var winners: [String] = []
    var winnerSubtitles: [String] = []
    var servicesWithAllUserChannels: [String] = []
    
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var resultsLabel1: UILabel!
    @IBOutlet var resultsLabel2: UILabel!
    @IBOutlet var resultsLabel3: UILabel!
    @IBOutlet var resultsLabel4: UILabel!
    @IBOutlet var resultsLabel5: UILabel!
    @IBOutlet var resultsLabel6: UILabel!
    @IBOutlet var resultsLabel7: UILabel!
    @IBOutlet var resultsLabel8: UILabel!
    @IBOutlet var resultsLabel9: UILabel!
    @IBOutlet var resultsLabel10: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsLabel1.text = ""
        resultsLabel2.text = ""
        resultsLabel3.text = ""
        resultsLabel4.text = ""
        resultsLabel5.text = ""
        resultsLabel6.text = ""
        resultsLabel7.text = ""
        resultsLabel8.text = ""
        resultsLabel9.text = ""
        resultsLabel10.text = ""

        /// Return messages ///
        if servicesWithAllUserChannels.count == 1 {
            headerLabel.text = "\(servicesWithAllUserChannels.joined()) has all of the channels you're looking for!"
            
        } else if servicesWithAllUserChannels.count > 0 {
            headerLabel.text = "\(servicesWithAllUserChannels.joined(separator: ", ")) have all of the channels you're looking for!"
            
        } else if winners.count == 1 {
            headerLabel.text = "None of our TV services have every channel you want, but \(winnerSubtitles.joined()) has the most"
            
            for winner in winnerSubtitles {
                if winner == "Now Plus" {
                    resultsLabel1.text = "\(winner) has \(dtvNowPlusScore) of your channels: \(dtvNowPlusResults.joined(separator: ", "))"
                } else if winner == "Now Max" {
                    resultsLabel2.text = "\(winner) has \(dtvNowMaxScore) of your channels: \(dtvNowMaxResults.joined(separator: ", "))"
                } else if winner == "Fubo TV" {
                    resultsLabel3.text = "\(winner) has \(fuboScore) of your channels: \(fuboResults.joined(separator: ", "))"
                } else if winner == "Hulu + Live TV" {
                    resultsLabel4.text = "\(winner) has \(huluScore) of your channels: \(huluResults.joined(separator: ", "))"
                } else if winner == "Philo" {
                    resultsLabel5.text = "\(winner) has \(philoScore) of your channels: \(philoResults.joined(separator: ", "))"
                } else if winner == "Sling Blue" {
                    resultsLabel6.text = "\(winner) has \(slingBlueScore) of your channels: \(slingBlueResults.joined(separator: ", "))"
                } else if winner == "Sling Orange" {
                    resultsLabel7.text = "\(winner) has \(slingOrangeScore) of your channels: \(slingOrangeResults.joined(separator: ", "))"
                } else if winner == "Vue Access" {
                    resultsLabel8.text = "\(winner) has \(vueAccessScore) of your channels: \(vueAccessResults.joined(separator: ", "))"
                } else if winner == "Vue Core" {
                    resultsLabel9.text = "\(winner) has \(vueCoreScore) of your channels: \(vueCoreResults.joined(separator: ", "))"
                } else if winner == "YouTube TV" {
                    resultsLabel10.text = "\(winner) has \(yttvScore) of your channels: \(yttvResults.joined(separator: ", "))"
                } else {
                    resultsLabel1.text = " "
                }
            }
            
        } else if winners.count > 1 {
            headerLabel.text = "None of our TV services have every channel you want, but \(winnerSubtitles.joined(separator: ", ")) have the most."
            
            for winner in winnerSubtitles {
                
                if winner == "Now Plus" {
                    resultsLabel1.text = "\(winner) has \(dtvNowPlusScore) of your channels: \(dtvNowPlusResults.joined(separator: ", "))"
                } else if winner == "Now Max" {
                    resultsLabel2.text = "\(winner) has \(dtvNowMaxScore) of your channels: \(dtvNowMaxResults.joined(separator: ", "))"
                } else if winner == "Fubo TV" {
                    resultsLabel3.text = "\(winner) has \(fuboScore) of your channels: \(fuboResults.joined(separator: ", "))"
                } else if winner == "Hulu + Live TV" {
                    resultsLabel4.text = "\(winner) has \(huluScore) of your channels: \(huluResults.joined(separator: ", "))"
                } else if winner == "Philo" {
                    resultsLabel5.text = "\(winner) has \(philoScore) of your channels: \(philoResults.joined(separator: ", "))"
                } else if winner == "Sling Blue" {
                    resultsLabel6.text = "\(winner) has \(slingBlueScore) of your channels: \(slingBlueResults.joined(separator: ", "))"
                } else if winner == "Sling Orange" {
                    resultsLabel7.text = "\(winner) has \(slingOrangeScore) of your channels: \(slingOrangeResults.joined(separator: ", "))"
                } else if winner == "Vue Access" {
                    resultsLabel8.text = "\(winner) has \(vueAccessScore) of your channels: \(vueAccessResults.joined(separator: ", "))"
                } else if winner == "Vue Core" {
                    resultsLabel9.text = "\(winner) has \(vueCoreScore) of your channels: \(vueCoreResults.joined(separator: ", "))"
                } else if winner == "YouTube TV" {
                    resultsLabel10.text = "\(winner) has \(yttvScore) of your channels: \(yttvResults.joined(separator: ", "))"
                } else {
                    resultsLabel1.text = ""
                }
            }
            
        } else {
            headerLabel.text = "Sorry - none of our TV services have any of the channels you want ☹️"
            
        }
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return winners.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        if winners.count > 0 {
            cell.resultCellImage.image = UIImage(named: winners[indexPath.item])
            cell.resultCellImage.layer.borderColor = UIColor.lightGray.cgColor
            cell.resultCellImage.layer.borderWidth = 1
            
            cell.resultCellSubtitle.text = winnerSubtitles[indexPath.item]
            
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDTVNowPlusChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "DirecTV Now Plus"
            controller.priceLabel = dtvNowPlusPrice
            controller.channels = dtvNowPlusChannels
            controller.color = UIColor.Colors.Blue.CuriousBlue
        }
        
        if segue.identifier == "ShowDTVNowMaxChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "DirecTV Now Max"
            controller.priceLabel = dtvNowMaxPrice
            controller.channels = dtvNowMaxChannels
            controller.color = UIColor.Colors.Blue.CuriousBlue
        }
        
        if segue.identifier == "ShowFuboChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Fubo TV"
            controller.priceLabel = fuboPrice
            controller.channels = fuboChannels
            controller.color = UIColor.Colors.Orange.Fubo
        }
        
        if segue.identifier == "ShowHuluChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Hulu + Live TV"
            controller.priceLabel = huluPrice
            controller.channels = huluChannels
            controller.color = UIColor.Colors.Green.MountainMeadow
        }
        
        if segue.identifier == "ShowPhiloChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Philo"
            controller.priceLabel = philoPrice
            controller.channels = philoChannels
            controller.color = UIColor.Colors.Blue.Philo
        }
        
        if segue.identifier == "ShowSlingBlueChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Sling Blue"
            controller.priceLabel = slingBluePrice
            controller.channels = slingBlueChannels
            controller.color = UIColor.Colors.Blue.Mariner
        }
        
        if segue.identifier == "ShowSlingOrangeChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Sling Orange"
            controller.priceLabel = slingOrangePrice
            controller.channels = slingOrangeChannels
            controller.color = UIColor.Colors.Orange.Sun
        }
        
        if segue.identifier == "ShowVueAccessChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Vue Access"
            controller.priceLabel = vueAccessPrice
            controller.channels = vueAccessChannels
            controller.color = UIColor.Colors.Blue.PlayStation
        }
        
        if segue.identifier == "ShowVueCoreChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "Vue Core"
            controller.priceLabel = vueCorePrice
            controller.channels = vueCoreChannels
            controller.color = UIColor.Colors.Blue.PlayStation
        }
        
        if segue.identifier == "ShowYTTVChannels", let controller = segue.destination as? ChannelTableViewController {
            controller.titleLabel = "YouTube TV"
            controller.priceLabel = yttvPrice
            controller.channels = yttvChannels
            controller.color = UIColor.Colors.Red.YouTubeTV
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            self.performSegue(withIdentifier: "\(segues[0])", sender: self)
        } else if indexPath.item == 1 {
            self.performSegue(withIdentifier: "\(segues[1])", sender: self)
        } else if indexPath.item == 2 {
            self.performSegue(withIdentifier: "\(segues[2])", sender: self)
        } else if indexPath.item == 3 {
            self.performSegue(withIdentifier: "\(segues[3])", sender: self)
        } else if indexPath.item == 4 {
            self.performSegue(withIdentifier: "\(segues[4])", sender: self)
        } else if indexPath.item == 5 {
            self.performSegue(withIdentifier: "\(segues[5])", sender: self)
        } else if indexPath.item == 6 {
            self.performSegue(withIdentifier: "\(segues[6])", sender: self)
        } else if indexPath.item == 7 {
            self.performSegue(withIdentifier: "\(segues[7])", sender: self)
        } else if indexPath.item == 8 {
            self.performSegue(withIdentifier: "\(segues[8])", sender: self)
        } else if indexPath.item == 9 {
            self.performSegue(withIdentifier: "\(segues[9])", sender: self)
        } else {
            print("Somehow we tapped nothing?")
        }
    }
    
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }

}
