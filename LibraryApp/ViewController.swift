//
//  ViewController.swift
//  LibraryApp
//
//  Created by Radu Stefan on 14/12/2020.
//

import UIKit


private enum Const
{
    static let rowHeight: CGFloat = 50
    static let cellId: String = "LibraryTableViewCell"
}


class ViewController: UIViewController
{
    var pageCount: Int = 0
    
    var booksByAuthorPageCount: Int = 0
    
    lazy var viewModel: ViewModel =
    {
        let vm: ViewModel = ViewModel()
        return vm
    }()
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: ViewController Lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTableView()
        
        viewModel.getBooks(pageNumber: "\(pageCount)", completion: {(dataModel: DataModel?, error: APIError?) in
            guard let dataModel = dataModel else { return }
            self.viewModel.updateData(data: dataModel)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            self.pageCount += 1
        })
    }

    
    // MARK: Helpers
    
    func setupTableView()
    {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: Const.cellId, bundle: nil), forCellReuseIdentifier: Const.cellId)
    }
    
    func createAlert(author: String, books: String)
    {
        // Create new Alert
        let dialogMessage = UIAlertController(title: author, message: books, preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "Close", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
          })
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)
         // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Const.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellId) as! LibraryTableViewCell
        
        cell.authorLabel.text = viewModel.rows[indexPath.row].author
        cell.numberOfBooksLabel.text = "\(viewModel.rows[indexPath.row].numberOfBooks)"
        cell.evenLabel.text = viewModel.rows[indexPath.row].isEven
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        //pagination
        if indexPath.row == viewModel.rows.count - 1 && pageCount < viewModel.nrOfPages
        {
            viewModel.getBooks(pageNumber: "\(pageCount)", completion: {(dataModel: DataModel?, error: APIError?) in
                guard let dataModel = dataModel else { return }
                self.viewModel.updateData(data: dataModel)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                self.pageCount += 1
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let author = viewModel.rows[indexPath.row].author
        
        viewModel.getBooksForAuthor(pageNumber: "\(booksByAuthorPageCount)", author: author, completion: {(dataModel: DataModel?, error: APIError?) in
            guard let dataModel = dataModel else { return }
            
            let books = self.viewModel.getBooksByAuthorString(booksString: "", data: dataModel)
            
            DispatchQueue.main.async {
                self.createAlert(author: author, books: books)
            }
        })
    }
}
