//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Cecilia  Villatoro on 1/10/17.
//  Copyright © 2017 Cecilia. All rights reserved.
//

import UIKit

import AFNetworking
class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    var movies : [NSDictionary]?
    
    var endPoint : String!
    
    var filteredData: [NSDictionary]?

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        //tableView.dataSource = self
        //tableView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
        
        let apiKey = "a64e63c6746e901a29a8e52b524d6cfe"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(apiKey)")!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(dataOrNil, response, error)
              in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                    print(responseDictionary)
                    self.movies = responseDictionary["results"] as! [NSDictionary]?
                    self.filteredData = self.movies;
                  
                    self.collectionView.reloadData()
               
                }
            }
        });
        task.resume()

        // Do any additional setup after loading the view.
    }
    
   /* func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies{
            return movies.count
        }
        else{
            return 0
        }
    }*/
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
   
  /*  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
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
    }*/

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let filteredData = filteredData{
            return filteredData.count
        }
        else{
            return 0
        }
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
 
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let movie = filteredData![indexPath.row]
       
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as! CollectionViewCell
        
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w500/"
        if let posterPath = movie["poster_path"] as? String{
            
        
        let imageURL = NSURL(string: baseUrl + posterPath)
       
        let imageRequest = NSURLRequest(URL: imageURL!)

         cell.PosterView.setImageWithURLRequest(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    print("Image was NOT cached, fade in image")
                    cell.PosterView.alpha = 0.0
                    cell.PosterView.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        cell.PosterView.alpha = 1.0
                    })
                } else {
                    print("Image was cached so just update the image")
                    cell.PosterView.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
        
        }
        return cell
    }
    
  
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
      let screenSize = UIScreen.mainScreen().bounds.size
       
      let screenWidth = screenSize.width
      let cellWidth = (screenWidth / 2.0) - 5; //Replace the divisor with the column count requirement. Make sure to have it in float.
       let height = cellWidth + (cellWidth/6.0);
       let size: CGSize  = CGSizeMake(cellWidth, height);
       print (size);
       return size;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        
       filteredData = searchText.isEmpty ? movies : movies!.filter(
        {(dataDict: NSDictionary) -> Bool in
             //If dataItem matches the searchText, return true to include it
            let title = dataDict["title"] as! String
            return title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        let movie = filteredData![indexPath!.row]
        
        let detail = segue.destinationViewController as! DetailViewController
        detail.movie = movie
    }
    

}
