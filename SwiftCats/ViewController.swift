import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var Ownerdata: [Owner] = []
    var petsdatamale:[String] = []//Male gender cat pets array
    var petsdatafemale:[String] = []//Female gender cat pets array
    var headerTitles:[String] = []//Male and female gender pets

    
    var gender_array : [String] = []//Gender array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Below Code to access NetworkServices
        NetworkService().getOwners { (owners) in
            self.Ownerdata.append(contentsOf: owners)
            for owner in owners {
                self.Ownerdata.append(Owner(name: owner.name, gender: owner.gender, age: owner.age, pets: owner.pets))
            }
            self.genderdata(Ownerdata: owners)
            
            print(self.Ownerdata.count)
            if(self.Ownerdata.count >= 1)
            {
             
                DispatchQueue.main.async {
                    self.Ownerdata = self.Ownerdata.sorted { $0.name < $1.name }
                    self.tableView.reloadData()
                }
            }
        }
        // Register tableView
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
    }
    // Function to get gender info
    func genderdata(Ownerdata: [Owner]){
        for gender_value in Ownerdata {
            self.gender_array.append(gender_value.gender)
        }
        gender_array = gender_array.uniqued()
        var count = 0
        print("count out", count)
        for gender_finalvalue in gender_array{
            headerTitles.append(gender_finalvalue)
            count = count + 1
            print("count in", count)
            for gender_value in Ownerdata {
                print("count here", count)
                
                switch (count) {
                case 1:
                    if(gender_value.gender == gender_finalvalue)
                    {
                        
                        if(gender_value.pets?[0].type == "Cat")
                        {
                            self.petsdatamale.append(gender_value.pets?[0].name ?? "")
                            print("self.petsdatamale",self.petsdatamale)
                        }
                        if(gender_value.pets?[1].type == "Cat")
                        {
                            self.petsdatamale.append(gender_value.pets?[1].name ?? "")
                            print("self.petsdatamale",self.petsdatamale)
                        }
                        
                       
                    }
                    
                case 2:
                    if(gender_value.gender == gender_finalvalue)
                    {
                        
                        if(gender_value.pets?[0].type == "Cat")
                        {
                            self.petsdatafemale.append(gender_value.pets?[0].name ?? "")
                            print("self.petsdatafemale",self.petsdatafemale)
                        }
                        
                       
                    }
                    
                default: break
                    
                }
                
            }
           
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }

        return nil
    }
    // Number of rows in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return petsdatamale.count
        }
        else
        {
            return petsdatafemale.count
        }
        
    }
    //Number of sections in tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // Assign data in tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        print("I am Ownerdata",Ownerdata)
      
        if(indexPath.section == 0)
        {
            cell.nameLabel.text = petsdatamale[indexPath.row]
            
        }
        else
        {
            
            cell.nameLabel.text = petsdatafemale[indexPath.row]
            
        }
        return cell
    }
    
}
//Duplication for gender
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

