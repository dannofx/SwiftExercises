//
//  SearchTableViewController.swift
//  AsyncAutoSuggestExample
//
//  Created by Danno on 7/24/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import UIKit

let urlFormat = "https://autocomplete.clearbit.com/v1/companies/suggest?query=%@"
let cellIdentifier = "result"
let nameLabeltag = 50

class SearchTableViewController: UITableViewController {
    
    var results: [[String: Any]]!
    var workItem: DispatchWorkItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endSearchTermEdition(sender:)))
        self.tableView.addGestureRecognizer(tapRecognizer)
        self.results = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Table view data source

extension SearchTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let nameLabel = cell.viewWithTag(nameLabeltag) as? UILabel {
            nameLabel.text = results[indexPath.row]["name"] as? String
        }
        return cell
    }
}

// MARK: - Table view delegate

extension SearchTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}

// MARK: Search text management

extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.launchSearchTask(withTerm: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(false)
    }
    
    func endSearchTermEdition(sender: Any) {
        self.view.endEditing(true)
    }
}

// MARK: Company Search

extension SearchTableViewController {
    
    func launchSearchTask(withTerm term: String) {
        if let prevWorkItem = self.workItem {
            if !prevWorkItem.isCancelled {
                prevWorkItem.cancel()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        
        if term == "" {
            self.results = []
            self.tableView.reloadData()
            self.workItem = nil
            return
        }
        
        let workItem = DispatchWorkItem(flags: .inheritQoS) {
            self.searchTerm(term)
        }
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.5, execute: workItem)
        self.workItem = workItem
    }
    
    func searchTerm(_ term: String) {
        guard let escapedTerm = term.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        let urlString = String(format: urlFormat, escapedTerm)
        let url = URL(string: urlString)!
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        do {
            let data = try Data(contentsOf: url) // This way to retrieve the data is intentional
            // Could be better to use URLSession, but the goal of the example is to deal with
            // heavy tasks out of the main thread, besides to bring a way to cancel them.
            let results = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            if results != nil {
                DispatchQueue.main.async {
                    self.results = results
                    self.tableView.reloadData()
                }
                
            }
        } catch {
            print("Error retrieving data: \(error.localizedDescription)")
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.workItem = nil
    }
}
