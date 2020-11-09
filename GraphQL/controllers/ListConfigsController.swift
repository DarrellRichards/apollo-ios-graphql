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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        tableView.dataSource = self
        fetchConfigs()
    }
    
    func fetchConfigs() {
        GraphqlService.shared.apollo.fetch(query: ListConfigsQuery()) {
            result in
            guard let data = try? result.get().data else { return }
            for config in data.listConfigs! {
                var updated = Config(id: config!.id ?? "nil", name: config!.name ?? "default name", enabled: config!.enabled ?? false)
                self.configs.append(updated)
            }
            
            self.setupTableView()
            }
    }

    func setupTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
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
}

