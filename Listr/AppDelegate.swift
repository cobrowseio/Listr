//
//  AppDelegate.swift
//  Listr
//
//  Created by Hesham Saleh on 1/29/17.
//  Copyright © 2017 Hesham Saleh. All rights reserved.
//

import UIKit
import CoreData
import CobrowseIO

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Set your lciense key below to associate sessions with your
        // account.
        // By default all sessions will be available on the trial account
        // which is accessed at https://cobrowse.io/trial
        CobrowseIO.instance().license = "trial";
        CobrowseIO.instance().api = "https://zephyr.ngrok.io";

        print("Cobrowse device id:  \(CobrowseIO.instance().deviceId)")

        let device_id = UserDefaults.standard.string(forKey: "device_id");
        if (device_id != nil) {
            CobrowseIO.instance().customData = [
                kCBIODeviceIdKey: device_id! as NSObject
            ]
        }

        
        // To override default status tap behavior set the status
        // tap property on the cobrowse instance.
        // CobrowseIO.instance().onStatusTap = { () -> Void in
        //     print("put status bar tap logic here.")
        // }
        
        return true
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Listr")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

//Shortcuts
let ad = UIApplication.shared.delegate as! AppDelegate
let context = ad.persistentContainer.viewContext
