import UIKit
import SideMenu

protocol MenuListControllerDelegate {
    func didSelectMenuItem(at index: Int)
}

class FavouritesViewController: UIViewController, MenuListControllerDelegate{

    var menu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let navigationBar =  self.navigationController?.navigationBar
        navigationBar?.backgroundColor = .systemMint
        // Create and configure the menu list controller
        let menuListController = MenuListController()
        menuListController.delegate = self
        
        // Initialize the SideMenuNavigationController with the menu list controller
        menu = SideMenuNavigationController(rootViewController: menuListController)
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenuManager.default.leftMenuNavigationController = menu
    }

    @IBAction func MenuButtonTapped(_ sender: UIBarButtonItem) {
        present(menu!, animated: true)
    }
    
    // Delegate method to handle menu item selection
    func didSelectMenuItem(at index: Int) {
        print("Selected menu item at index: \(index)")
        menu?.dismiss(animated: true, completion: nil)

        switch index {
        case 0:
            self.view.backgroundColor = .red
            self.title = "Red"
        case 1:
            self.view.backgroundColor = .blue
            self.title = "Blue"
        case 2:
            self.view.backgroundColor = .darkGray
            self.title = "DarkGrey"
        default:
            break
        }
    }
}

class MenuListController: UITableViewController {
    
    var items = ["Red", "Blue", "DarkGrey"]
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    var delegate: MenuListControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = darkColor
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Notify the delegate when a menu item is selected
        delegate?.didSelectMenuItem(at: indexPath.row)
    }
}
