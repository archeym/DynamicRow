//
//  ViewController.swift
//  DynamicRow
//
//  Created by Arkadijs Makarenko on 16/06/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var tableData1: [String] = ["Archie", "Mack","Mick","Todd", "Key", "Kim is from Philippines. He's a Filiphino and He like basketball","Max"]
    var tableData2: [String] = ["Archie", "Mack", "Key","Mack","Mick","Todd", "Key", "Kim is from Philippines. He's a Filiphino and He like basketball","Max"]
    var tableData3: [String] = ["Archie", "Mack", "Key", "Mack","Archie", "Mick","Todd","Archie", "Key","Kim is from Philippines and He like basketball. He's a Filiphino","Max", "Kim is from Philippines and He like basketball."]
    
    var sectionData: [Int: [String]] = [:]
    
    let sectionTitles: [String] = ["Rejected", "Pending", "Approved"]
    let sectionImages: [UIImage] = [#imageLiteral(resourceName: "no"),#imageLiteral(resourceName: "wait"),#imageLiteral(resourceName: "yes")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        sectionData = [0 : tableData1, 1 : tableData2, 2 : tableData3]
        refreshControl.tintColor = UIColor.orange
        refreshControl.addTarget(self, action: #selector(ViewController.refreshData), for: UIControlEvents.valueChanged)
        checkiOS()
    }
    
    func checkiOS(){
        if #available(iOS 10.0, *){
            tableView.refreshControl = refreshControl
        }else{
            tableView.addSubview(refreshControl)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = (scrollView.contentOffset.y * -1)
        var message: String = "Fetching Data ."
        
        switch offset{
            case 0...50:
            message = "Fetching Data ."
            case 50...70:
            message = "Fetching Data .."
            case 70...80:
            message = "Fetching Data ..."
            case 80...90:
            message = "Fetching Data ...."
            case 90...100:
            message = "Fetching Data ....."
            case 100...110:
            message = "Fetching Data ......"
            case 110...120:
            message = "Fetching Data ......."
            case 120...130:
            message = "Fetching Data ........"
            case 130...140:
            message = "Fetching Data ........."
            case 140...150:
            message = "Fetching Data .........."
        case _ where offset > 150:
            message = "Fething Completed"
        default: break
        }
            refreshControl.attributedTitle = NSAttributedString(string: message, attributes: [NSForegroundColorAttributeName : refreshControl.tintColor])

        refreshControl.backgroundColor = UIColor.darkGray
    }
    
    func refreshData(){
//        tableData1.append("New Note Here")
//        tableData2.append("New Note Again")
//        tableData3.append("New Note Again and Again")
//        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionData[section]?.count)!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.cyan
        
        let image = UIImageView(image: sectionImages[section])
        image.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        view.addSubview(image)
        
        let label = UILabel()
        label.text = sectionTitles[section]
        label.frame = CGRect(x: 45, y: 5, width: 100, height: 35)
        view.addSubview(label)

        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
        }
        cell?.textLabel?.text = sectionData[indexPath.section]![indexPath.row]
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    
    
}//end

