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
    
    var huluScore = 0
    var vueScore = 0
    var yttvScore = 0
    var slingBlueScore = 0
    var slingOrangeScore = 0
    
    var huluResults: [String] = []
    var vueResults: [String] = []
    var yttvResults: [String] = []
    var slingBlueResults: [String] = []
    var slingOrangeResults: [String] = []
    
    var winners: [String] = []
    var winnerSubtitles: [String] = []
    var servicesWithAllUserChannels: [String] = []
    
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var resultsLabel1: UILabel!
    @IBOutlet var resultsLabel2: UILabel!
    @IBOutlet var resultsLabel3: UILabel!
    @IBOutlet var resultsLabel4: UILabel!
    @IBOutlet var resultsLabel5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsLabel1.text = ""
        resultsLabel2.text = ""
        resultsLabel3.text = ""
        resultsLabel4.text = ""
        resultsLabel5.text = ""

        /// Return messages ///
        if servicesWithAllUserChannels.count == 1 {
            headerLabel.text = "\(servicesWithAllUserChannels.joined()) has all of the channels you're looking for!"
            
        } else if servicesWithAllUserChannels.count > 0 {
            headerLabel.text = "\(servicesWithAllUserChannels.joined(separator: " & ")) have all of the channels you're looking for!"
            
        } else if winners.count == 1 {
            headerLabel.text = "None of our TV services have every channel you want, but \(winnerSubtitles.joined()) has the most"
            
            for winner in winnerSubtitles {
                if winner == "Hulu + Live TV" {
                    resultsLabel1.text = "\(winner) has \(huluScore) of your channels: \(huluResults.joined(separator: ", "))"
                }
                if winner == "Vue Access" {
                    resultsLabel2.text = "\(winner) has \(vueScore) of your channels: \(vueResults.joined(separator: ", "))"
                }
                if winner == "YouTube TV" {
                    resultsLabel3.text = "\(winner) has \(yttvScore) of your channels: \(yttvResults.joined(separator: ", "))"
                }
                if winner == "Sling Blue" {
                    resultsLabel4.text = "\(winner) has \(slingBlueScore) of your channels: \(slingBlueResults.joined(separator: ", "))"
                }
                if winner == "Sling Orange" {
                    resultsLabel5.text = "\(winner) has \(slingOrangeScore) of your channels: \(slingOrangeResults.joined(separator: ", "))"
                }
            }
            
        } else if winners.count > 1 {
            headerLabel.text = "None of our TV services have every channel you want, but \(winnerSubtitles.joined(separator: " & ")) have the most."
            
            for winner in winnerSubtitles {
                if winner == "Hulu + Live TV" {
                    resultsLabel1.text = "\(winner) has \(huluScore) of your channels: \(huluResults.joined(separator: ", "))"
                }
                if winner == "Vue Access" {
                    resultsLabel2.text = "\(winner) has \(vueScore) of your channels: \(vueResults.joined(separator: ", "))"
                }
                if winner == "YouTube TV" {
                    resultsLabel3.text = "\(winner) has \(yttvScore) of your channels: \(yttvResults.joined(separator: ", "))"
                }
                if winner == "Sling Blue" {
                    resultsLabel4.text = "\(winner) has \(slingBlueScore) of your channels: \(slingBlueResults.joined(separator: ", "))"
                }
                if winner == "Sling Orange" {
                    resultsLabel5.text = "\(winner) has \(slingOrangeScore) of your channels: \(slingOrangeResults.joined(separator: ", "))"
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

}
