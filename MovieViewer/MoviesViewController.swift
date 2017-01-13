//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Cecilia  Villatoro on 1/10/17.
//  Copyright © 2017 Cecilia. All rights reserved.
//

import UIKit
import AFNetworking
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var movies : [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        let apiKey = "a64e63c6746e901a29a8e52b524d6cfe"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(dataOrNil, response, error)
              in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                    print(responseDictionary)
                    self.movies = responseDictionary["results"] as! [NSDictionary]?
                    self.tableView.reloadData()
                }
            }
        });
        task.resume()

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies{
            return movies.count
        }
        else{
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
    
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        cell.titleLabel.text = title
        let overView = movie["overview"] as! String
        cell.overviewLabel.text = overView
        
        let baseUrl = "https://image.tmdb.org/t/p/w500/"
        let posterPath = movie["poster_path"] as! String
        let imageURL = NSURL(string: baseUrl + posterPath)
        cell.posterView.setImageWithURL(imageURL!)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
