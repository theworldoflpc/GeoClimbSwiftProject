/*
 * FILE : RoutesViewController.swift
 * PROJECT : PROG3230 - Mobile Application Development II - Assignment 1
 * PROGRAMMERS : David Pitters, Lev Cocarell, Carl Wilson, Bobby Vu
 * FIRST VERSION : 2018-09-15
 * DESCRIPTION :
 * This file contains the source code for the RoutesViewController. It is populated via the
 * table data from the TableViewController.
 */

import UIKit
import CoreData

class RoutesViewController: UIViewController {
    
    @IBOutlet weak var output: UILabel!
    
    // The event handles the 'switch' control which indicates if a
    // user has ascended (climbed) a route before. We plan on building on this feature
    // in next iteration.
    @IBAction func `switch`(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
            //Save the status in the database
            SetAscended(true)
            output.text = NSLocalizedString("Yes_text", comment:"")
        }
        else
        {
            //Save the status in the database
            SetAscended(false)
            output.text = NSLocalizedString("Unattempted_text", comment:"")
        }
    }
    
    // The labels, image views, and text views are populated depending on what table view items are
    // selected (as an index)
    @IBOutlet weak var label_RoutesTitle: UILabel!
    @IBOutlet weak var textview_RoutesDesc: UITextView!
    @IBOutlet weak var imageView_Routes: UIImageView!
    @IBOutlet weak var label_RoutesHeight: UILabel!
    @IBOutlet weak var label_RoutesRating: UILabel!
    @IBOutlet weak var label_RoutesLocation: UILabel!
    @IBOutlet weak var switch_Ascended: UISwitch!
    
    //Get the internationalization/localization from the appdelegate
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var locale: Locale?
    
    @IBOutlet weak var infoScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the locale
        locale = delegate.localeSelector
        
        // Do any additional setup after loading the view, typically from a nib.
        label_RoutesTitle.text = routes[myIndex]
        textview_RoutesDesc.text = routesDesc[myIndex]
        label_RoutesHeight.text = routesHeight[myIndex]
        label_RoutesRating.text = routesRating[myIndex]
        label_RoutesLocation.text = routesLocation[myIndex]
        imageView_Routes.image = UIImage(named: routes[myIndex] + ".png")
        
        //Set whether or not the user has ascended the route
        //Get the core data context
        let context = delegate.persistentContainer.viewContext
        
        //Add or check to see if the route has already been added to the database
        let exists = AddOrFindRoute(context)
        
        RetrieveAscended(exists, context)
    }
    
    func AddOrFindRoute(_ context:NSManagedObjectContext) -> Bool {
        var exists = false;
        
        //Create the fetch object and its predicate
        let routeEntityFetch =  NSFetchRequest<NSFetchRequestResult>(entityName: "Route")
        let routePredicate = NSPredicate(format: "routeTitle == %@",routes[myIndex])
        routeEntityFetch.predicate = routePredicate
        
        //Execute the query
        var queryResults: [NSManagedObject] = []
        do {
            queryResults = try context.fetch(routeEntityFetch) as! [NSManagedObject]
        }
        catch {
            print("error with fetch: \(error)")
            return exists
        }
        
        //If the results count equals 1, return true. If 0, add the route to the core data
        if (queryResults.count >= 1){
            exists = true
        }
        else{
            do{
                let routeEntity = NSEntityDescription.entity(forEntityName: "Route", in: context)
                let newRoute = NSManagedObject(entity: routeEntity!, insertInto: context)
                newRoute.setValue(routes[myIndex], forKey: "routeTitle")
                newRoute.setValue(false, forKey: "isAscended")
                try context.save()
            }
            catch{
                print("error with adding core data: \(error)")
                return exists
            }
        }
        
        return exists
    }
    
    func RetrieveAscended(_ exists:Bool, _ context:NSManagedObjectContext) {
        if (exists){
            //Create the fetch object and its predicate
            let routeEntityFetch =  NSFetchRequest<NSFetchRequestResult>(entityName: "Route")
            let routePredicate = NSPredicate(format: "routeTitle == %@",routes[myIndex])
            routeEntityFetch.predicate = routePredicate
            
            //Execute the query
            var queryResults: [NSManagedObject] = []
            var isAscended = false
            do {
                queryResults = try context.fetch(routeEntityFetch) as! [NSManagedObject]
                isAscended = queryResults[0].value(forKey: "isAscended") as! Bool
                
                if (isAscended){
                    //Set the route as ascended in the UI
                    switch_Ascended.isOn = true
                    output.text = NSLocalizedString("Yes_text", comment:"")
                }
                else{
                    switch_Ascended.isOn = false
                    output.text = NSLocalizedString("Unattempted_text", comment:"")
                }
            }
            catch {
                print("error with fetch: \(error)")
                switch_Ascended.isOn = false
                return
            }
        }
        else{
            switch_Ascended.isOn = false
            output.text = NSLocalizedString("Unattempted_text", comment:"")
        }
    }
    
    func SetAscended(_ isAscended:Bool){
        //Get the core data context
        let context = delegate.persistentContainer.viewContext
        
        //Create the fetch object and its predicate
        let routeEntityFetch =  NSFetchRequest<NSFetchRequestResult>(entityName: "Route")
        let routePredicate = NSPredicate(format: "routeTitle == %@",routes[myIndex])
        routeEntityFetch.predicate = routePredicate
        
        //Execute the query
        var queryResults: [NSManagedObject] = []
        do {
            queryResults = try context.fetch(routeEntityFetch) as! [NSManagedObject]
            
            //Set the new value
            queryResults[0].setValue(isAscended, forKey: "isAscended")
            
            //Set the new ascended value
            try context.save()
        }
        catch {
            print("error with fetch: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

