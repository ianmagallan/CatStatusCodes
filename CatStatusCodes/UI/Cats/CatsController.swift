//
//  CatsController.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import UIKit

final class CatsTableViewController: UITableViewController {
    
    private let viewModel = CatsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "CatTableViewCell", bundle: nil), forCellReuseIdentifier: "catTableViewCell")
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "catDetails", let indexPath = tableView.indexPathForSelectedRow {
            let destinationVC = segue.destination as! CatDetailsController
            destinationVC.statusCode = viewModel.cats[indexPath.row].statusCode
        }
    }*/
}

extension CatsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catTableViewCell") as! CatTableViewCell
        cell.descriptionLabel.text = viewModel.makeFullDescription(forRow: indexPath.row)
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Bundle.main.loadNibNamed("CatDetailsController", owner: self, options: nil)?[0] as! CatDetailsController
        vc.statusCode = viewModel.cats[indexPath.row].statusCode
        //let vc = CatDetailsController(nibName: "CatDetailsController", bundle: nil)
        //let catDetailsController = CatDetailsController.make(statusCode: viewModel.cats[indexPath.row].statusCode)
        //catDetailsController.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)

        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let destinationVC = storyboard.instantiateViewController(withIdentifier: "CatDetailsController") as! CatDetailsController
        //destinationVC.init(statusCode: viewModel.cats[indexPath.row].statusCode)
    }
}
