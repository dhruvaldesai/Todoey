
import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    //UITableViewController e supar(parent) class che ane ToDoListViewController che e child class che etle child class supar class ne inherit kare che UItableViewController no badho data(method function) badhu TodoListViewController ma aavi jashe
    
    
   // var itemArray = ["a", "b", "c"]
    
    //khali array banavyo che
    
    //var itemArray:[String] = []
    //aapde item type no datatype valo array banavyo, jema khali title nakhavanu che chemark to false j che
//    var itemArray:[Item] = [Item(title: "buy milk"),
//                            Item(title: "buy bread"),
//                            Item(title: "buy medicine"),
//                            Item(title: "buy fruits and vegitables")]
    var itemArray:[Item] = []
    //category ma je select karyu hoy e aa variable ma aavi jay
    //atyre aapdi pase kai category selected che e khabar nathi etlae ? lakhyu
    var selectedCategory: Category?
    
    //localstorage ma store thashe
    
//    let storagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoList.plist")
//
    // aa syntext app delegate mathi copy karyu aa gokhavnu che
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //data ne laptop ma store karyo tho ene access karva mate
        //staring ma koi data nai hoy etale if let karyu ke jo deta hoy to tene storedData ma nakho ane e data ne itemArray nam na array ma store karo
        //if let storedData = UserDefaults.standard.stringArray(forKey: "ToDo"){
        //pela string type no array hato have item type no array banavyo
//        if let storedData = UserDefaults.standard.stringArray(forKey: "ToDo"){
//            itemArray=storedData
//        }
     
        loadData()
        title = selectedCategory?.name
        //data kya store thai che e jova mate aapde aa print state ment lakhuyu upar thi copy kari ne
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
       
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        //upar 3 item che array ma etale 3 row banshe, ketali row banashe e retern karyu, jetali array ni length  hoy etli row bane
    }
        // jetali row hashe etali var aaa function call thase ene dar vakhate cell devo padashe jethi kari ne ema lakhi shakay, eltle aapde cell banaviye
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //indexpath e ketali row che e batave,
            // itemArray[indexPath.row] peli row ma array no pelo element a aavashe biji row ma bijo element b aavashe em  3 cell banashe
        //item array nam na array mathi title jove che etlae .title lakhyu ema title ane checkmark 2 che
        let item = itemArray[indexPath.row]
//        cell.textLabel?.text =  itemArray[indexPath.row].title
        cell.textLabel?.text =  item.title
        // cell malyo ema aapde je lakhan lakhavu thi e textLable.text hi lakhine return kari didhu
        // nichena step ui ma show karva matena che jo selected cell ma checkmark no hoy to e true che etale ema check mark nathi etale ema check mark aapo jo ...
//        if itemArray[indexPath.row].checkmark == true{
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        //ternary operater if else ne biji rite simple language ma lakhi shakay ek line ma
        cell.accessoryType = item.checkmark == true ? .checkmark : .none
        
        return cell
    }
    //kai row select thai e jova ane ema shu lakhevu che
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        //row ne delete karva mate
//        context.delete(itemArray[indexPath.row])
//        let selectedCell = tableView.cellForRow(at: indexPath)
//        
//        //if ma hammesha ==, <=,>=, compare karvu ,  banne side same hoy to = true (if valo code execute thai , not same = false (else valo code execute thai)
//        
//        //khali nathi to check mark & other wise remove checkmark
//        
//        if selectedCell?.accessoryType == UITableViewCell.AccessoryType.none {
//            selectedCell?.accessoryType = .checkmark
//            
//        } else{
//            selectedCell?.accessoryType = .none
//        }
        //selected row ma chekmart fasle che eno compare karyo jo false hoy to true karvanu che nakar false
        
//        if itemArray[indexPath.row].checkmark == false {
//            itemArray[indexPath.row].checkmark = true
//        } else {
//            itemArray[indexPath.row].checkmark = false
//        }
        // upar lakhyu ej che aa biji rite che ! enathi viruddh thai jay, check mart no hoy to karvanu ane hoy to kadhi nakhavanu
        itemArray[indexPath.row].checkmark = !itemArray[indexPath.row].checkmark
        
        //data delete karva mate coreData mathi
        //aapde array ni kai row delete karvi che [indexPath.row] ene item ma store kari
       // let item = itemArray[indexPath.row]
        //context.delete(item)
        //etle je selcted row hashe e delete thai jashe // eni sathe array mathi pan delete kari devi jethi fast speed thai // jo me no kari e to pel aapdo datasaved thai saveToDo() thi pachi data fetch karvao pan pachi data ne reload karvano pan aapde direct method kari e
       // itemArray.remove(at: indexPath.row)
        //selected row no data satho sath data besed ni sathe remove thai// jo aapde aam no kari e to savetodo()pachi loadData() karvo pade
        //checkmark ne store karva mate
        saveToDo()
        //data load karva mate reloadData()
        tableView.reloadData()
        //check mark karyu row mate cell banavyo pela pan aapde deselect pan karvo che check mark ne etale conditional statement vaparvu
              //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //selectedCell?.accessoryType = .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func ToDoButtonPressed(_ sender: Any) {
        
        var alertTextField = UITextField()
        
            //pela alert banayu pop up aave ema 2 vastu hoy addtextfield ane biju add karvanu action button
        
        let alert = UIAlertController(title: "Add Todo Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add task", style: .default) { alertAction in
            print(alertTextField.text!)
            
            //nava malela daataa ne array ma store karyo
            //let newItem = Item(title: alertTextField.text!)
            //nicheni 2 liti upar lakhi che tene bar access karva mate
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
            //nicheni line aapdi row bani jay che ane row bani jay pachi ema alerTextField.text kari ne ema data store kari devo aapde aama khali title store karvanu che etlae newItem.title lakhyu che & checkmart aapde buydefault false aapyo xhe
            //ama khali row print thai
            let newItem = Item(context: self.context) //cleser ma j self lakhavu aama closer che etale self.context lakhyu
            newItem.parentCategory = self.selectedCategory
           //newItem ma title nakhyu //aapde je lakhiye chiye e row ma print thashe niche na code thi
            newItem.title = alertTextField.text!
            //alertTextField.text che string ma che pan aapde Item type ma jove che etle ene Item type ma fervyo
            self.itemArray.append(newItem)
            //self.itemArray.append(alertTextField.text!)
            // je navo malelo data je array ma che ne dispaly karva mate reload karishu tableView je che e UITableViewController ma che etlae tableView.reloadData lakyu,,
            //UserDefaults.standard.set(self.itemArray, forKey: "ToDo")
            //data ne internaly store karyo che laptop ma j myuser ma store thashe
            //data ne store karvo new method thi nichena funcation ne call karyo
            self.saveToDo()
            self.tableView.reloadData()
        }
        
        //aaya aapde closer ma texField nam aapyu che e khali jagya nu jem aapde task lakhavno che & placeholder etle ema kaik aacha akshar e lakhelu hoy e aapde lakhi ye tyare bhusay jay
        //aapde text field ma shu lakyu e aapde bar vaparvu hoy to ene alerttexfield nam no variable banavyo bar & textfield ma je hatu e ema nakhi didhu
        alert.addTextField { textField in
            textField.placeholder = "write your task"
            alertTextField=textField
            
        }
        //biju addAction add karvanu che
        alert.addAction(action)
        
        //alert ne display karva mate present man nu function lakhyu jem alert e
        
        present(alert, animated: true)
        //present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        //UViewContoller che e alert che
        
    }
    //aapdi pase je data che ene save kari ne ecode kari ne storagePath thi mobile na storage ma store kari devo
//    func saveToDo() {
//        //data ne store karta pahela ene ecode karvo pade pachi e store thai
//        let encoder = PropertyListEncoder()
//        
//        //jya try lakhelu aave tya do ane catch vaparvu
//        do {
//            let data = try encoder.encode(itemArray) //throw nam ni error aave etle "try" lakhi devu
//            try data.write(to: storagePath!)
//            
//        } catch{
//            print("data not stored", error )
//            //jo data no store thai to aa error aave
//            
//        }
//    }
    func saveToDo() {
        //jya trow nam ni error aave tya do ane catch vaprvu ane try lakhavu
    
    
            do {
                try context.save()
                //aapda data ne save karva mate jo aapde save no kariye to ene edit kari shakay ane e store no thai etlae display no thai
    
            }catch {
                print("data not stored" )
    //            //jo data no store thai to aa error aave
    //
          }
       }
    
    //data ne coreDataModel mathi leva mate
    
    func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        //let request = Item.fetchRequest()
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
      
        if let searchPredicate = request.predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, searchPredicate])
        }
        else{
            request.predicate = categoryPredicate
        }
        

        do{
            //niche lakyu e sentex yaad rakhavu
            itemArray = try context.fetch(request)
            //malela data ne itemArray ma nakhya
            //jo aapde dar vakhate data ne load no karvo hoy to tableView.reloadData()ne aaya lakhi shakay
            tableView.reloadData()
            
        } catch {
            print("loading data problem", error)
        }
        
    }

    
    //try hammesha do ane catch ni andar lakhay jo eni andar no lakhavu hoy to ? mukavu
    //malelo data ne encode mathi decode karvo
//    func loadData(){
//        let decoder = PropertyListDecoder()
//        do{
//            //try pachi ? etale lakhyu ke jo catch
//            if let data = try? Data(contentsOf: storagePath!){
//                //storage mathi melavelo data ne [Item] item type na array (itemArray) ma store karyo
//                itemArray = try decoder.decode([Item].self, from: data)
//            }
//        } catch {
//            print("problem while receving data")
//            //jo data no male to aa print thai
//            
//                
//            }
//        }
//        
        
}

extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        let request = Item.fetchRequest()
        //%@ ni jagya e searchBar.text aavi jay je lakhyu hoy e // aama aapde database ma query aapi che ke key etle title ma cotainst je user e lakhyu hoy e aavu jove
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //aapane je data male enen aapde sort karvano che upar inche shu reshe em ,,aaama checkmark no hoy e pela & check mark hoy e niche key ma aapde checkmark lakhishu
        request.sortDescriptors = [NSSortDescriptor(key: "checkmark", ascending: true), NSSortDescriptor(key: "checkmark", ascending: true)]
        
        
//        do{
//            itemArray = try context.fetch(request)
//        } catch{
//            print("error",error)
//        }
        
        loadData(with: request)
        
        //tableView.reloadData()
    }
    // pan lakhavanu tamane je yaad hoy e etale automatic suggestion aavi jashe
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //aa if ni biji rite lakhi shkay ke jo empty hoy to data load karo ane keyboard ne dismiss karo
        //if searchText .isEmpty == true {
        if searchText .isEmpty {
            loadData()
           // tableView.reloadData()
            //jo tamane khabar j hoy ke tamaro code sacho j che to dispatchQueeue.main lakhavu karan ke searbar ni funcationality background ma thai che ene foreground ma lava mate aa function vapray
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }else {
            //aapde koi pan akshar lakhiye eno data aavi jay etle aaya lakyu che // enter(search) dabavu no pade
            let request = Item.fetchRequest()
            
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            request.sortDescriptors = [NSSortDescriptor(key: "checkmark", ascending: true), NSSortDescriptor(key: "checkmark", ascending: true)]
            loadData(with: request)
           // tableView.reloadData()
            
            
        }
    }
    
    
    
    
}




