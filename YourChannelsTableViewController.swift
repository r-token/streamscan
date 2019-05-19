//
//  SearchTableViewController.swift
//  Streamr
//
//  Created by Ryan Token on 5/12/19.
//  Copyright © 2019 Ryan Token. All rights reserved.
//

import UIKit
import CoreData

class YourChannelsTableViewController: UITableViewController {
    
    private let api = API() // Instantiate my API class
    
    private let hulu = "hulu" // Hulu with Live TV
    private let vue = "vue" // PlayStation Vue
    private let yttv = "yttv" // YouTube TV
    private let slingBlue = "sling-blue" // Sling Blue resource for API call
    private let slingOrange = "sling-orange" // Sling Orange resource for API call
    
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
    
    private var huluScore = 0
    private var vueScore = 0
    private var yttvScore = 0
    private var slingBlueScore = 0
    private var slingOrangeScore = 0
    
    private var huluResults: [String] = []
    private var vueResults: [String] = []
    private var yttvResults: [String] = []
    private var slingBlueResults: [String] = []
    private var slingOrangeResults: [String] = []
    
    private var winners: [String] = []
    private var winnerSubtitles: [String] = []
    private var servicesWithAllUserChannels: [String] = []
    
    private var userChannels: [NSManagedObject] = []
    
    // Get all channels from my API endpoints and save them to huluChannels/vueChannels/yttvChannels/etc
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Channels"
        navigationItem.largeTitleDisplayMode = .automatic
        self.tableView.sectionHeaderHeight = 118
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Channel")
        
        do {
            userChannels = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userChannels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let channel = userChannels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = channel.value(forKeyPath: "name") as? String
        cell.selectionStyle = .none
    
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        // Present dialog box for user to enter a channel they want
        // Add that to userChannels array
        // 1. Create the alert controller.
        let alert = UIAlertController(title: "Add Channel", message: "Enter one of your favorite channels", preferredStyle: .alert)
        
        // 2. Add the channel
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.keyboardType = .default
            textField.placeholder = "ESPN"
            textField.autocapitalizationType = .words
        })
        
        // 3. Grab the value from the text field, and add it to the the CoreData graph and to our [String] of channels
        alert.addAction(UIAlertAction(title: "Add", style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let channelToSave = textField.text else {
                    return
            }
            
            self.save(name: channelToSave)
            self.tableView.reloadData()
            
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "Channel",
                                       in: managedContext)!
        let channel = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        channel.setValue(name, forKeyPath: "name")
        
        do {
            try managedContext.save()
            userChannels.append(channel)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        // Look at the userChannelsCopy String array and finds the service(s) that have all of the channels the user wants
        // If no service has every channel they list, list the most similar service(s)
        
        huluChannels = cleanArray(array: huluChannels)
        vueChannels = cleanArray(array: vueChannels)
        yttvChannels = cleanArray(array: yttvChannels)
        slingBlueChannels = cleanArray(array: slingBlueChannels)
        slingOrangeChannels = cleanArray(array: slingOrangeChannels)
        
        let coreChannels = cleanCoreData(data: userChannels)
        
        huluScore = 0
        vueScore = 0
        yttvScore = 0
        slingBlueScore = 0
        slingOrangeScore = 0
        
        huluResults = []
        vueResults = []
        yttvResults = []
        slingBlueResults = []
        slingOrangeResults = []
        
        winners = []
        winnerSubtitles = []
        servicesWithAllUserChannels = []
        
        //let allChannels: [String] = huluChannels + vueChannels + yttvChannels
        //let setChannels: Set = Set(allChannels)
        
        // Better way of doing this would probably be to use a set and a hash function
        for userChannel in coreChannels {
            if huluChannels.contains(userChannel) {
                huluScore += 1
                huluResults.append(userChannel)
            }
            if vueChannels.contains(userChannel) {
                vueScore += 1
                vueResults.append(userChannel)
            }
            if yttvChannels.contains(userChannel) {
                yttvScore += 1
                yttvResults.append(userChannel)
            }
            if slingBlueChannels.contains(userChannel) {
                slingBlueScore += 1
                slingBlueResults.append(userChannel)
            }
            if slingOrangeChannels.contains(userChannel) {
                slingOrangeScore += 1
                slingOrangeResults.append(userChannel)
            }
        }
        
        let highScore: Int = max(max(max(max(huluScore, vueScore), yttvScore), slingBlueScore), slingOrangeScore)
        
        /// Append items to the winners array ///
        if highScore == huluScore && huluScore > 0 {
            winners.append("Hulu")
            winnerSubtitles.append("Hulu + Live TV")
            
        }
        
        if highScore == vueScore && vueScore > 0 {
            winners.append("Vue")
            winnerSubtitles.append("Vue Access")
            
        }
        
        if highScore == yttvScore && yttvScore > 0 {
            winners.append("YouTubeTV")
            winnerSubtitles.append("YouTube TV")
            
        }
        
        if highScore == slingBlueScore && slingBlueScore > 0 {
            winners.append("SlingBlue")
            winnerSubtitles.append("Sling Blue")
            
        }
        
        if highScore == slingOrangeScore && slingOrangeScore > 0 {
            winners.append("SlingOrange")
            winnerSubtitles.append("Sling Orange")
            
        }
        /// Stop appending items to the winners and winnerSubtitles array ///
        
        
        
        /// Append items to the servicesWithAllUserChannels array ///
        if huluScore == userChannels.count {
            servicesWithAllUserChannels.append("Hulu + Live TV")
            
        }
        
        if vueScore == userChannels.count {
            servicesWithAllUserChannels.append("Vue Access")
            
        }
        
        if yttvScore == userChannels.count {
            servicesWithAllUserChannels.append("YouTube TV")
            
        }
        
        if slingBlueScore == userChannels.count {
            servicesWithAllUserChannels.append("Sling Blue")
            
        }
        
        if slingOrangeScore == userChannels.count {
            servicesWithAllUserChannels.append("Sling Orange")
            
        }
        /// Stop appending items to the servicesWithAllUserChannelsArray ///
        
        print(slingOrangeScore)
        print(slingOrangeResults)
        print(slingOrangeChannels)
        
        if userChannels.count > 0 {
            self.performSegue(withIdentifier: "ShowResults", sender: self)
            
        } else {
            let alert = UIAlertController(title: "Enter a Channel", message: "You'll need to enter a channel before you can see your results", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: { (textField) -> Void in
                textField.keyboardType = .default
                textField.placeholder = "ESPN"
                textField.autocapitalizationType = .words
            })
            
            alert.addAction(UIAlertAction(title: "Add", style: .default) {
                [unowned self] action in
                
                guard let textField = alert.textFields?.first,
                    let channelToSave = textField.text else {
                        return
                }
                
                self.save(name: channelToSave)
                self.tableView.reloadData()
                
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func cleanArray(array: [String]) -> [String] {
        var cleanArray = array
        cleanArray = cleanArray.map({$0.lowercased()})
        cleanArray = cleanArray.map({$0.filter({ !" \n\t\r !@#$%^&*()-_+={[}]|\'?/>.<,~`".contains($0) }) }) //filter out all white spaces and punctuation/symbols
        
        return cleanArray
    }
    
    func cleanCoreData(data: [NSManagedObject]) -> [String] {
        let cleanData = data
        var cleanPoint: String
        var cleanArray: [String] = []
        
        for point in cleanData {
            cleanPoint = (point.value(forKey: "name") as! String)
            cleanArray.append(cleanPoint)
        }
        
        cleanArray = cleanArray.map({$0.lowercased()})
        cleanArray = cleanArray.map({$0.filter({ !" \n\t\r !@#$%^&*()-_+={[}]|\'?/>.<,~`".contains($0) }) }) //filter out all white spaces and punctuation/symbols
        
        return cleanArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? ResultsViewController {
            controller.huluScore = huluScore
            controller.vueScore = vueScore
            controller.yttvScore = yttvScore
            controller.slingBlueScore = slingBlueScore
            controller.slingOrangeScore = slingOrangeScore
            
            controller.huluResults = huluResults
            controller.vueResults = vueResults
            controller.yttvResults = yttvResults
            controller.slingBlueResults = slingBlueResults
            controller.slingOrangeResults = slingOrangeResults
            
            controller.winners = winners
            controller.winnerSubtitles = winnerSubtitles
            controller.servicesWithAllUserChannels = servicesWithAllUserChannels
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            //userChannels.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
            let entity = "Channel" //Entity Name
            
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let channel = userChannels[indexPath.row]
            
            if editingStyle == .delete {
                managedContext.delete(channel)
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
                
            }
            
            //Code to Fetch New Data From The DB and Reload Table.
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            
            do {
                userChannels = try managedContext.fetch(fetchRequest) as! [Channel]
            } catch let error as NSError {
                print("Error While Fetching Data From DB: \(error.userInfo)")
            }
            tableView.reloadData()
            
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        
        let paddingTop = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 1))
        paddingTop.text = "     "
        self.view.addSubview(paddingTop)
        
        let description1 = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 50))
        description1.text = "  Add channels by tapping ➕"
        description1.textColor = .lightGray
        description1.font = UIFont.boldSystemFont(ofSize: 16.0)
        description1.textAlignment = .left
        self.view.addSubview(description1)
        
        let description2 = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 50))
        description2.text = "  Remove channels by swiping ⬅️"
        description2.textColor = .lightGray
        description2.font = UIFont.boldSystemFont(ofSize: 16.0)
        description2.textAlignment = .left
        self.view.addSubview(description2)
        
        let description3 = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 50))
        description3.text = "  Find the best service for you by tapping 🔍"
        description3.textColor = .lightGray
        description3.font = UIFont.boldSystemFont(ofSize: 16.0)
        description3.textAlignment = .left
        self.view.addSubview(description3)
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = UIStackView.Alignment.top
        stackView.spacing = 8.0
        
        stackView.addArrangedSubview(paddingTop)
        stackView.addArrangedSubview(description1)
        stackView.addArrangedSubview(description2)
        stackView.addArrangedSubview(description3)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
        
        return view
    }

}
