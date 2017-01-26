//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Cecilia  Villatoro on 1/16/17.
//  Copyright © 2017 Cecilia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    
    @IBOutlet var PosterImageView: UIImageView!
    
    
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var infoView: UIView!
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var OverviewLabel: UILabel!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ScrollView.contentSize = CGSize(width: ScrollView.frame.size.width, height: ScrollView.frame.size.height + 221);
        let title = movie["title"] as! String
        titleLabel.text = title
        let overview = movie["overview"] as! String
        OverviewLabel.text = overview
        OverviewLabel.sizeToFit();
        
        let baseUrl = "https://image.tmdb.org/t/p/w500/"
        if let posterPath = movie["poster_path"] as? String{
            
            
        let imageURL = NSURL(string: baseUrl + posterPath)
            
           
        PosterImageView.setImageWithURL(imageURL!)
            
        }

        // Do any additional setup after loading the view.
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
