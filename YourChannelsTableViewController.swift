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
    private var dtvNowPlusCleanChannels: [String] = []
    
    private var dtvNowMaxPrice: String = ""
    private var dtvNowMaxChannels: [String] = []
    private var dtvNowMaxCleanChannels: [String] = []
    
    private var fuboPrice: String = ""
    private var fuboChannels: [String] = []
    private var fuboCleanChannels: [String] = []
    
    private var huluPrice: String = ""
    private var huluChannels: [String] = []
    private var huluCleanChannels: [String] = []
    
    private var philoPrice: String = ""
    private var philoChannels: [String] = []
    private var philoCleanChannels: [String] = []
    
    private var slingBluePrice: String = ""
    private var slingBlueChannels: [String] = []
    private var slingBlueCleanChannels: [String] = []
    
    private var slingOrangePrice: String = ""
    private var slingOrangeChannels: [String] = []
    private var slingOrangeCleanChannels: [String] = []
    
    private var vueAccessPrice: String = ""
    private var vueAccessChannels: [String] = []
    private var vueAccessCleanChannels: [String] = []
    
    private var vueCorePrice: String = ""
    private var vueCoreChannels: [String] = []
    private var vueCoreCleanChannels: [String] = []
    
    private var yttvPrice: String = ""
    private var yttvChannels: [String] = []
    private var yttvCleanChannels: [String] = []
    
    private var dtvNowPlusScore = 0
    private var dtvNowMaxScore = 0
    private var fuboScore = 0
    private var huluScore = 0
    private var philoScore = 0
    private var slingBlueScore = 0
    private var slingOrangeScore = 0
    private var vueAccessScore = 0
    private var vueCoreScore = 0
    private var yttvScore = 0
    
    private var dtvNowPlusResults: [String] = []
    private var dtvNowMaxResults: [String] = []
    private var fuboResults: [String] = []
    private var huluResults: [String] = []
    private var philoResults: [String] = []
    private var slingBlueResults: [String] = []
    private var slingOrangeResults: [String] = []
    private var vueAccessResults: [String] = []
    private var vueCoreResults: [String] = []
    private var yttvResults: [String] = []
    
    private var segues: [String] = []
    private var winners: [String] = []
    private var winnerSubtitles: [String] = []
    private var servicesWithAllUserChannels: [String] = []
    
    private var userChannels: [NSManagedObject] = [] // channels the user picked that are saved with Core Data
    
    // Get all channels from my API endpoints and save them to huluChannels/vueChannels/yttvChannels/etc
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Channels"
        navigationItem.largeTitleDisplayMode = .automatic
        self.tableView.sectionHeaderHeight = 118
        
        api.getChannels(from: dtvNowPlus, priceCompletionHandler: { [weak self] price in
            self?.dtvNowPlusPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.dtvNowPlusChannels = channels ?? ["Could not retrieve channels for Hulu"]
                self?.dtvNowPlusCleanChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: dtvNowMax, priceCompletionHandler: { [weak self] price in
            self?.dtvNowMaxPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.dtvNowMaxChannels = channels ?? ["Could not retrieve channels for Hulu"]
                self?.dtvNowMaxCleanChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: fubo, priceCompletionHandler: { [weak self] price in
            self?.fuboPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.fuboChannels = channels ?? ["Could not retrieve channels for Hulu"]
                self?.fuboCleanChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: hulu, priceCompletionHandler: { [weak self] price in
            self?.huluPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.huluChannels = channels ?? ["Could not retrieve channels for Hulu"]
                self?.huluCleanChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: philo, priceCompletionHandler: { [weak self] price in
            self?.philoPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.philoChannels = channels ?? ["Could not retrieve channels for Hulu"]
                self?.philoCleanChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: slingBlue, priceCompletionHandler: { [weak self] price in
            self?.slingBluePrice = price ?? "Could not retrieve price for Sling Blue"
            }, channelCompletionHandler: { [weak self] channels in
                self?.slingBlueChannels = channels ?? ["Could not retrieve channels for Sling Blue"]
                self?.slingBlueCleanChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: slingOrange, priceCompletionHandler: { [weak self] price in
            self?.slingOrangePrice = price ?? "Could not retrieve price for Sling Orange"
            }, channelCompletionHandler: { [weak self] channels in
                self?.slingOrangeChannels = channels ?? ["Could not retrieve channels for Orange"]
                self?.slingOrangeCleanChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: vueAccess, priceCompletionHandler: { [weak self] price in
            self?.vueAccessPrice = price ?? "Could not retrieve price for Hulu"
            }, channelCompletionHandler: { [weak self] channels in
                self?.vueAccessChannels = channels ?? ["Could not retrieve channels for Hulu"]
                self?.vueAccessCleanChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: vueCore, priceCompletionHandler: { [weak self] price in
            self?.vueCorePrice = price ?? "Could not retrieve price for Vue"
            }, channelCompletionHandler: { [weak self] channels in
                self?.vueCoreChannels = channels ?? ["Could not retrieve channels for Vue"]
                self?.vueCoreChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
        api.getChannels(from: yttv, priceCompletionHandler: { [weak self] price in
            self?.yttvPrice = price ?? "Could not retrieve price for YouTube TV"
            }, channelCompletionHandler: { [weak self] channels in
                self?.yttvChannels = channels ?? ["Could not retrieve channels for YouTube TV"]
                self?.yttvCleanChannels = channels ?? ["Could not retrieve channels for Hulu"]
        })
        
    }
    
    // Get our Core Data
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
    
    // MARK: - Custom functions
    
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
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        // Look at the userChannelsCopy String array and finds the service(s) that have all of the channels the user wants
        // If no service has every channel they list, list the most similar service(s)
        
        dtvNowPlusCleanChannels = cleanArray(array: dtvNowPlusCleanChannels)
        dtvNowMaxCleanChannels = cleanArray(array: dtvNowMaxCleanChannels)
        fuboCleanChannels = cleanArray(array: fuboCleanChannels)
        huluCleanChannels = cleanArray(array: huluCleanChannels)
        philoCleanChannels = cleanArray(array: philoCleanChannels)
        slingBlueCleanChannels = cleanArray(array: slingBlueCleanChannels)
        slingOrangeCleanChannels = cleanArray(array: slingOrangeCleanChannels)
        vueAccessCleanChannels = cleanArray(array: vueAccessCleanChannels)
        vueCoreCleanChannels = cleanArray(array: vueCoreCleanChannels)
        yttvCleanChannels = cleanArray(array: yttvCleanChannels)
        
        let coreChannels = cleanCoreData(data: userChannels)
        
        dtvNowPlusScore = 0
        dtvNowMaxScore = 0
        fuboScore = 0
        huluScore = 0
        philoScore = 0
        slingBlueScore = 0
        slingOrangeScore = 0
        vueAccessScore = 0
        vueCoreScore = 0
        yttvScore = 0
        
        segues = []
        
        dtvNowPlusResults = []
        dtvNowMaxResults = []
        fuboResults = []
        huluResults = []
        philoResults = []
        slingBlueResults = []
        slingOrangeResults = []
        vueAccessResults = []
        vueCoreResults = []
        yttvResults = []
        
        winners = []
        winnerSubtitles = []
        servicesWithAllUserChannels = []
        
        //let allChannels: [String] = huluChannels + vueChannels + yttvChannels
        //let setChannels: Set = Set(allChannels)
        
        // Better way of doing this would probably be to use a set and a hash function
        for userChannel in coreChannels {
            if dtvNowPlusCleanChannels.contains(userChannel) {
                dtvNowPlusScore += 1
                dtvNowPlusResults.append(userChannel)
            }
            if dtvNowMaxCleanChannels.contains(userChannel) {
                dtvNowMaxScore += 1
                dtvNowMaxResults.append(userChannel)
            }
            if fuboCleanChannels.contains(userChannel) {
                fuboScore += 1
                fuboResults.append(userChannel)
            }
            if huluCleanChannels.contains(userChannel) {
                huluScore += 1
                huluResults.append(userChannel)
            }
            if philoCleanChannels.contains(userChannel) {
                philoScore += 1
                philoResults.append(userChannel)
            }
            if slingBlueCleanChannels.contains(userChannel) {
                slingBlueScore += 1
                slingBlueResults.append(userChannel)
            }
            if slingOrangeCleanChannels.contains(userChannel) {
                slingOrangeScore += 1
                slingOrangeResults.append(userChannel)
            }
            if vueAccessCleanChannels.contains(userChannel) {
                vueAccessScore += 1
                vueAccessResults.append(userChannel)
            }
            if vueCoreCleanChannels.contains(userChannel) {
                vueCoreScore += 1
                vueCoreResults.append(userChannel)
            }
            if yttvCleanChannels.contains(userChannel) {
                yttvScore += 1
                yttvResults.append(userChannel)
            }
        }
        
        let highScore: Int = max(max(max(max(max(max(max(max(max(dtvNowPlusScore, dtvNowMaxScore), fuboScore), huluScore), philoScore), slingBlueScore), slingOrangeScore), vueAccessScore), vueCoreScore), yttvScore)
        
        /// Append items to the winners array ///
        if highScore == dtvNowPlusScore && dtvNowPlusScore > 0 {
            winners.append("DirecTVNowPlus")
            winnerSubtitles.append("Now Plus")
            segues.append("ShowDTVNowPlusChannels")
        }
        
        if highScore == dtvNowMaxScore && dtvNowMaxScore > 0 {
            winners.append("DirecTVNowMax")
            winnerSubtitles.append("Now Max")
            segues.append("ShowDTVNowMaxChannels")
            
        }
        if highScore == fuboScore && fuboScore > 0 {
            winners.append("Fubo")
            winnerSubtitles.append("Fubo TV")
            segues.append("ShowFuboChannels")
            
        }
        
        if highScore == huluScore && huluScore > 0 {
            winners.append("Hulu")
            winnerSubtitles.append("Hulu + Live TV")
            segues.append("ShowHuluChannels")
            
        }
        
        if highScore == philoScore && philoScore > 0 {
            winners.append("Philo")
            winnerSubtitles.append("Philo")
            segues.append("ShowPhiloChannels")
            
        }
        
        if highScore == slingBlueScore && slingBlueScore > 0 {
            winners.append("SlingBlue")
            winnerSubtitles.append("Sling Blue")
            segues.append("ShowSlingBlueChannels")
            
        }
        
        if highScore == slingOrangeScore && slingOrangeScore > 0 {
            winners.append("SlingOrange")
            winnerSubtitles.append("Sling Orange")
            segues.append("ShowSlingOrangeChannels")
            
        }
        
        if highScore == vueAccessScore && vueAccessScore > 0 {
            winners.append("VueAccess")
            winnerSubtitles.append("Vue Access")
            segues.append("ShowVueAccessChannels")
            
        }
        
        if highScore == vueCoreScore && vueCoreScore > 0 {
            winners.append("VueCore")
            winnerSubtitles.append("Vue Core")
            segues.append("ShowVueCoreChannels")
            
        }
        
        if highScore == yttvScore && yttvScore > 0 {
            winners.append("YouTubeTV")
            winnerSubtitles.append("YouTube TV")
            segues.append("ShowYTTVChannels")
            
        }
        /// Stop appending items to the winners and winnerSubtitles array ///
        
        
        
        /// Append items to the servicesWithAllUserChannels array ///
        if dtvNowPlusScore == userChannels.count {
            servicesWithAllUserChannels.append("Now Plus")
            
        }
        
        if dtvNowMaxScore == userChannels.count {
            servicesWithAllUserChannels.append("Now Max")
            
        }
        
        if fuboScore == userChannels.count {
            servicesWithAllUserChannels.append("Fubo TV")
            
        }
        
        if huluScore == userChannels.count {
            servicesWithAllUserChannels.append("Hulu + Live TV")
            
        }
        
        if philoScore == userChannels.count {
            servicesWithAllUserChannels.append("Philo")
            
        }
        
        if slingBlueScore == userChannels.count {
            servicesWithAllUserChannels.append("Sling Blue")
            
        }
        
        if slingOrangeScore == userChannels.count {
            servicesWithAllUserChannels.append("Sling Orange")
            
        }
        
        if vueAccessScore == userChannels.count {
            servicesWithAllUserChannels.append("Vue Access")
            
        }
        
        if vueCoreScore == userChannels.count {
            servicesWithAllUserChannels.append("Vue Core")
            
        }
        
        if yttvScore == userChannels.count {
            servicesWithAllUserChannels.append("YouTube TV")
            
        }
        /// Stop appending items to the servicesWithAllUserChannelsArray ///
        
        
        if userChannels.count > 0 {
            self.performSegue(withIdentifier: "ShowResults", sender: self) //perform segue
            
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
    
    // Used in the addButtonPressed and searchButtonPressed functions
    // Saves the channel to Core Data
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
    
    // compare lowercased channels, and filter out all white spaces and punctuation/symbols
    func cleanArray(array: [String]) -> [String] {
        var cleanArray = array
        cleanArray = cleanArray.map({$0.lowercased()})
        cleanArray = cleanArray.map({$0.filter({ !" \n\t\r !@#$%^&*()-_+={[}]|\'?/>.<,~`".contains($0) }) })
        
        return cleanArray
    }
    
    // similar function to cleanArray, but for our core data items
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
                    print("Error While Deleting Channel: \(error.userInfo)")
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
    
    // My custom stack view
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
    
    // MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? ResultsViewController {
            controller.dtvNowPlusPrice = dtvNowPlusPrice
            controller.dtvNowPlusChannels = dtvNowPlusChannels
            controller.dtvNowMaxPrice = dtvNowMaxPrice
            controller.dtvNowMaxChannels = dtvNowMaxChannels
            controller.fuboPrice = fuboPrice
            controller.fuboChannels = fuboChannels
            controller.huluPrice = huluPrice
            controller.huluChannels = huluChannels
            controller.philoPrice = philoPrice
            controller.philoChannels = philoChannels
            controller.slingBluePrice = slingBluePrice
            controller.slingBlueChannels = slingBlueChannels
            controller.slingOrangePrice = slingOrangePrice
            controller.slingOrangeChannels = slingOrangeChannels
            controller.vueAccessPrice = vueAccessPrice
            controller.vueAccessChannels = vueAccessChannels
            controller.vueCorePrice = vueCorePrice
            controller.vueCoreChannels = vueCoreChannels
            controller.yttvPrice = yttvPrice
            controller.yttvChannels = yttvChannels
            
            controller.dtvNowPlusScore = dtvNowPlusScore
            controller.dtvNowMaxScore = dtvNowMaxScore
            controller.fuboScore = fuboScore
            controller.huluScore = huluScore
            controller.philoScore = philoScore
            controller.slingBlueScore = slingBlueScore
            controller.slingOrangeScore = slingOrangeScore
            controller.vueAccessScore = vueAccessScore
            controller.vueCoreScore = vueCoreScore
            controller.yttvScore = yttvScore
            
            controller.dtvNowPlusResults = dtvNowPlusResults
            controller.dtvNowMaxResults = dtvNowMaxResults
            controller.fuboResults = fuboResults
            controller.huluResults = huluResults
            controller.philoResults = philoResults
            controller.slingBlueResults = slingBlueResults
            controller.slingOrangeResults = slingOrangeResults
            controller.vueAccessResults = vueAccessResults
            controller.vueCoreResults = vueCoreResults
            controller.yttvResults = yttvResults
            
            controller.segues = segues
            controller.winners = winners
            controller.winnerSubtitles = winnerSubtitles
            controller.servicesWithAllUserChannels = servicesWithAllUserChannels
        }
    }

}
