//
//  ChannelTableView.swift
//  Streamr
//
//  Created by Ryan Token on 5/12/19.
//  Copyright © 2019 Ryan Token. All rights reserved.
//

import UIKit

class ChannelTableViewController: UITableViewController {
    
    var titleLabel: String = ""
    var channels: [String] = []
    var priceLabel: String = ""
    var color: UIColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .automatic
        self.title = titleLabel
        
        self.tableView.sectionHeaderHeight = 118
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = channels[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // My custom stack view - make a custom class out of this eventually and just inherit from that
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        
        let paddingTop = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 1))
        paddingTop.text = "     "
        self.view.addSubview(paddingTop)
        
        let price = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 50))
        price.text = "  Price: \(priceLabel)"
        price.textColor = .white
        price.font = UIFont.boldSystemFont(ofSize: 25.0)
        price.textAlignment = .left
        self.view.addSubview(price)
        
        let numberOfChannels = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 50))
        if channels.count != 1 { // needed to add this because if it can't retrieve the channels from the API it returns an error message. Error message counts as a channel, and it would say there was one channel
            numberOfChannels.text = "  Number of Channels: \(channels.count)"
        } else {
            numberOfChannels.text = " Number of Channels: 0"
        }
        numberOfChannels.textColor = .white
        numberOfChannels.font = UIFont.boldSystemFont(ofSize: 25.0)
        numberOfChannels.textAlignment = .left
        self.view.addSubview(numberOfChannels)
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = UIStackView.Alignment.top
        stackView.spacing = 8.0
        
        stackView.addArrangedSubview(paddingTop)
        stackView.addArrangedSubview(price)
        stackView.addArrangedSubview(numberOfChannels)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addBackground(color: color)
        self.view.addSubview(stackView)
        
        return view
    }
    
}
