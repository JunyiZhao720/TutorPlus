//
//  TutorResultListView.swift
//  Tutor+
//
//  Created by Bo Lan  on 10/26/18.
//  Copyright © 2018 JunyiZhao. All rights reserved.
//

import UIKit

class SearchResultController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var name = ["blue_background", "landscape","ppp","square"]
    var classes = ["CMPS115", "CMPS121 CMPS122 CMPS123 CMPS124 CMPS125","CMPS126","CMPS127"]
    
    var schoolCourse:[String:String]?
    
    @IBOutlet weak var TutorListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugHelpPrint(type: .SearchResultController, str: "school\(schoolCourse?["school"] ?? "") \(schoolCourse?["course"] ?? "")")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchResultTutorProfileTableViewCell
        cell?.tutorName.text = name[indexPath.row]
        cell?.className.text = classes[indexPath.row]
        cell?.img.image = UIImage(named: name[indexPath.row])
        
        //cell?.img.image = [UIImage, imageNamed,:[name objectAtIndex:indexpath.row]]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchResultTutorDetailProfile") as? SearchResultTutorDetailProfile
        vc?.image1 = UIImage(named: name[indexPath.row])!
        vc?.tName = name[indexPath.row]
        vc?.cName = classes[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
