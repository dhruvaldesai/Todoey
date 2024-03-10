import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray:[Category] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        readCategory()
    }
    
    // MARK: - table View datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }

    // MARK: - table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(categoryArray[indexPath.row].name!)



        
       performSegue(withIdentifier: "goToTodos", sender: self)
      
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTodos" {
            let destinationVC = segue.destination as! ToDoListViewController
                                                            //selected row male e 
            destinationVC.selectedCategory = categoryArray[tableView.indexPathForSelectedRow!.row]
        }
    }

    @IBAction func addCategoryButtonPressed(_ sender: Any) {

        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { alertAction in
            
            let newCetogary = Category(context: self.context)
            newCetogary.name = alertTextField.text!
            self.categoryArray.append(newCetogary)
            self.saveCategory()
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { textField in
            textField.placeholder = "add your category here"
            alertTextField = textField
        }
        
        present(alert, animated: true)
    }
    
    func saveCategory() {
        do{
            try context.save()
        } catch{
            print("error", error)
        }
    }
    
    func readCategory(){
        let request =  Category.fetchRequest()
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
}
