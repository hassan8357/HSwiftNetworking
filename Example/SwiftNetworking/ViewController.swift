//
//  ViewController.swift
//  SwiftNetworking
//
//  Created by Hassan Refaat on 02/25/2020.
//  Copyright (c) 2020 Hassan Refaat. All rights reserved.
//

import UIKit
import SwiftNetworking

class ViewController: UIViewController {

    //MARK:- Private Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Internal Vars
    var posts = [PostModel]()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
    }
    
    //MARK:- API Call
    func getPosts() {
        startLoading()
        APIManager().getAllPosts { [unowned self] (result) in
            DispatchQueue.main.async { self.stopLoading() }
            switch result {
            case .success(let posts):
                self.posts = posts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(error: error)
                }
                break
            }
        }
    }
    
    //MARK:- Helpers
    func showError(error: NetworkError) {
        let cancelAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let tuple = getErrorMessageTuple(fromError: error)
        let alert = UIAlertController(title: tuple.title, message: tuple.message, preferredStyle: .alert)
        alert.addAction(cancelAlertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getErrorMessageTuple(fromError error: NetworkError) -> (title: String?, message: String) {
        switch error.type {
        case .noInternet:
            return ("No Internet Connection", "Please check your Internet Connection")
            
        case .custom:
            return (nil, error.customError ?? "An error has occurred")
            
        default:
            return (nil, "An error has occurred")
        }
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func stopLoading() {
        tableView.isHidden = false
        activityIndicator.stopAnimating()
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].body
        return cell
    }
}
