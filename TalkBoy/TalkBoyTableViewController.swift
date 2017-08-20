//
//  TalkBoyTableViewController.swift
//  TalkBoy
//
//  Created by Patty Harris on 8/18/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit
import AVFoundation

class TalkBoyTableViewController: UITableViewController {

    var sounds : [SoundEntity] = []
    
    var audioPlayer : AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Better to call this here...that way, when we return
        // back to this view, it is called again, not just on
        // first launch.
        getSounds()
    }
    
    // Get the Items from Core Data
    func getSounds() {
        
        if let context  =
            ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
            
            do {
                let coreDataItems = try context.fetch(SoundEntity.fetchRequest()) as? [SoundEntity]
                
                if let coreDataItems = coreDataItems {
                    // We can just set our item array to the one given
                    // to us by Core Data
                    self.sounds = coreDataItems
                }
                
                tableView.reloadData()
            }
            catch {
                showAlert(message: "Could not retrieve the TalkBoys items from the database!  Please try again.")
                return
            }
        }
    }

    func removeItem(soundEntity: SoundEntity) {
        
        // Get the managed object context
        if let context  =
            ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
            
            context.delete(soundEntity)
            
        }
    }

    // Utility function (not part of tutorial)
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecordingCell", for: indexPath)

        // Configure the cell...
        let soundItem = sounds[indexPath.row]
        cell.textLabel?.text = soundItem.title

        return cell
    }

    // Allow the user to tap on a row and play the sound
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sound = sounds[indexPath.row]
        if let audioData = sound.audioData {
            
            audioPlayer = try? AVAudioPlayer(data: audioData)
            audioPlayer?.play()
        }
        
        // Deselect the row so that it's not still a selected color.
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // Override to support conditional editing of the table view.
    // This allows removal of the selected row.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    // Here we are allowing removal of an item.  So as with other cases, we'll remove from
    // Core Data and then re-retrieve the data which automatically updates the list
    // of items.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // tableView.deleteRows(at: [indexPath], with: .fade)
            
            // 1. Remove the item from Core Data
            let soundItem = sounds[indexPath.row]
            removeItem(soundEntity: soundItem)
            
            // 2. Re-get all the Core Data
            getSounds()
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array,
            // and add a new row to the table view
            
            // Not used since we're only dealing with delete.
        }    
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
