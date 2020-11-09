//
//  ListConfigsController.swift
//  GraphQL
//
//  Created by Darrell Richards on 11/8/20.
//

import UIKit

struct Config: Identifiable, Codable {
    var id: String
    var name: String
    var enabled: Bool
}

class ListConfigController: UIViewController,UITableViewDataSource {
//    var configsList = [ListConfigsQuery.Data.ListConfig]()
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
//            switch result {
//                case .success(let graphQLResult):
//                    print("Success! Result: \(graphQLResult.data?.listConfigs?.resultMap)")
////                    graphQLResult.data?.listConfigs.map({
////                        print($0.resultMap.name)
////                    })
//
//                case .failure(let error):
//                          print("Failure! Error: \(error)")
//                 }
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

