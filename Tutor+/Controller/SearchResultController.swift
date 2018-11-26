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
    
    var schoolCourse:[String:String] = [:]
    var tutorArray: [FirebaseUser.ProfileStruct] = []
    var tutorImageDict = [String: UIImage]()
    
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var tutorListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugHelpPrint(type: .SearchResultController, str: "school:\(schoolCourse["school"] ?? "") course:\(schoolCourse["course"] ?? "")")
        downloadTutorData()
    }
    private func downloadTutorImage(){
        for tutor in tutorArray{
            if let imageURL = tutor.imageURL{
                FirebaseTrans.shared.downloadImageAndCache(url: imageURL, completion: {(image) in
                    if let image = image{
                        self.tutorImageDict[imageURL] = image
                        self.tutorListView.reloadData()
                    }
                })
            }
            
        }
    }
    private func downloadTutorData(){
        if let school = schoolCourse["school"], let course = schoolCourse["course"]{
            FirebaseTrans.shared.downloadAllDocumentsBySchoolAndCourse(school: school, course: course, completion: {(data) in
                if let data = data{
                    self.tutorArray = data
                    self.tutorListView.reloadData()
                    
                    // Image downloading
                    debugHelpPrint(type: .SearchResultController, str: data.description)
                    self.downloadTutorImage()
                }
            })
        }else{
            AlertHelper.showAlert(fromController: self, message: "Downloading tutor data goes problems", buttonTitle: "OK")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultTableCell
        
        cell.tutorName.text = tutorArray[indexPath.row].name
        cell.className.text = classes[indexPath.row]
        if let url = tutorArray[indexPath.row].imageURL{
            if let image = tutorImageDict[url]{
                cell.img.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchResultTutorProfileController") as? SearchResultTutorProfileController
        vc?.image1 = UIImage(named: name[indexPath.row])!
        vc?.tName = name[indexPath.row]
        //vc?.cName = classes[indexPath.row]
        var data = Dictionary<String, String>()
        self.performSegue(withIdentifier: "SearchResultToTutorNav", sender: data)
    }
    
    // ------------------------------------------------------------------------------------
    // Other
    
    // override segue to pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SearchResultToTutorNav"){
            let nav = segue.destination as! UINavigationController
            let dest = nav.viewControllers.first as! SearchResultTutorProfileController
            let data = sender as! [String:Any]
            dest.data = data
            
        }
    
    }
}
