import UIKit
import CoreData
import SideMenu

class HistoryTableViewController: UITableViewController {
    
    override var prefersStatusBarHidden: Bool { true }
    
    
    lazy var fetchedResultController: NSFetchedResultsController<History> = {
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        return NSFetchedResultsController<History>(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataManager.shared.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }()
    
    
    lazy var settingButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(onSettingButtonItem))
    
    
    @objc func onSettingButtonItem() {
        
    }
    
    override func loadView() {
        super.loadView()

        fetchedResultController.delegate = self
        
        self.tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        
        self.navigationItem.leftBarButtonItem = self.settingButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//         self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            try fetchedResultController.performFetch()
            self.tableView.reloadData()
        }
        catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as! HistoryTableViewCell
        
        let history = fetchedResultController.object(at: indexPath)
        if let createdAt = history.createdAt {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .short
            cell.textLabel?.text = formatter.localizedString(for: createdAt, relativeTo: .now)
        }
        
        if let selectedHistory = CalculatorVC.shared.calculator.history {
            if selectedHistory == history {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = fetchedResultController.object(at: indexPath)
        do {
            try CalculatorVC.shared.calculator.load(history: history)
        } catch {
            print(error.localizedDescription)
        }
        
        if let leftMenu =  SideMenuManager.default.leftMenuNavigationController {
            leftMenu.dismiss(animated: true)
        }
    }
}


extension HistoryTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
          case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
          case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
          case .update:
            let cell = self.tableView.cellForRow(at: indexPath!) as! HistoryTableViewCell
            let history = anObject as! History
            cell.textLabel?.text = history.createdAt?.description
          case .move:
            tableView.reloadData()
//            tableView.deleteRows(at: [indexPath!], with: .automatic)
//            tableView.insertRows(at: [newIndexPath!], with: .automatic)
            break
          @unknown default:
            print("Unexpected NSFetchedResultsChangeType")
          }
    }
    
}
