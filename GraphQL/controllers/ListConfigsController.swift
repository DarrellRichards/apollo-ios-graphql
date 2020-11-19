//
//  ListConfigsController.swift
//  GraphQL
//
//  Created by Darrell Richards on 11/8/20.
//

import UIKit

class ListConfigController: UIViewController,UITableViewDataSource {
    
    let tableView = UITableView()
    var configs = [Config]()
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        refreshControl.addTarget(self, action:  #selector(fetchConfigs), for: .valueChanged)
        fetchConfigs()
    }
    
    @objc func fetchConfigs() {
        // When fetching updated Configs lets remove all in the array.
        self.configs.removeAll()
        // For demo needs, I just clearCache all together, this should only be done if completely needed.
        GraphqlService.shared.apollo.clearCache()
        GraphqlService.shared.apollo.fetch(query: ListConfigsQuery()) {
            result in switch result {
            case .success(let graphQLResult):
                for config in graphQLResult.data!.listConfigs! {
                        let updated = Config(id: config!.id ?? "nil", name: config!.name ?? "default name", enabled: config!.enabled ?? false)
                        self.configs.append(updated)
                }
                self.refreshControl.endRefreshing()
                self.setupTableView()
              case .failure(let error):
                // Network or response format errors
                print("network error: \(error)")
                let alert = UIAlertController(title: "Network Error", message: "The GraphQL Server was unreachable", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                    self.fetchConfigs()
                }))
                self.present(alert, animated: true)
            }
        }
    }

    func setupTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.tableView.addSubview(self.refreshControl)
        self.tableView.reloadData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return configs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = configs[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("section: \(indexPath.section)")
           print("row: \(indexPath.row)")
    }
}

