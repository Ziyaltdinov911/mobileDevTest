//
//  CharactersViewController.swift
//  iOSDev
//
//  Created by KAMA . on 16.01.2025.
//

//
//  CharactersViewController.swift
//  iOSDev
//
//  Created by KAMA . on 16.01.2025.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private var characters: [Character] = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Установка заголовка
        self.title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupTableView()
        setupConstraints()

        fetchCharacters()
    }

    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 130
        tableView.separatorStyle = .none

        // Настройка Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshCharacters), for: .valueChanged)
        tableView.refreshControl = refreshControl

        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // Запрос к API
    func fetchCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self?.characters = apiResponse.results

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            } catch {
                print("Failed to decode: \(error)")
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            }
        }

        task.resume()
    }

    // Метод для обновления данных при смахивании
    @objc private func refreshCharacters() {
        fetchCharacters()
    }

    // TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: characters[indexPath.row])
        return cell
    }
}
