//
//  MusicTableViewController.swift
//  KindofMusicApp
//
//  Created by mert Kanak on 23.06.2022.
//

import UIKit

class MusicTableViewController: UITableViewController {
    
    lazy var dataSource = configureDataSource()
    
    enum Section {
        case all 
    }
    
    
    var musics:[Music] = [
        Music(name: "Diabbolicco", type: "Phonk", info: "On numara Parça Amk ", image: "", isFavorite: false),
        Music(name: "Another Brick On The Wall", type: "Metal", info: "Ver bide ben çalıyım knka", image: "", isFavorite: false),
        Music(name: "VKTM", type: "Techno", info: "Bumtıkıtıkı tıs", image: "", isFavorite: false),
        Music(name: "Original Sin", type: "Country", info: "Neset ertasın amerigancası", image: "", isFavorite: false),
        Music(name: "Dom Dom kurşunu", type: "Caz", info: "Dua Lipa remixi bomba ", image: "", isFavorite: false),
        Music(name: "Hotel California", type: "Soul", info: "değişik bi mod", image: "", isFavorite: false),
        Music(name: "Borderline", type: "timeImpala", info: "amanıncızcızı", image: "", isFavorite: false),
    ]
    
    
    
    //var musicNames = ["Diabbolicco", "Another Brick On the Wall", "VKTM", "Original Sin", "Lose Yourself", "Dom Dom Kurşunu ", "Hotel California", "Borderline","1", "2" , "3", "4", "5"]
    //var musicIsFavorites = Array(repeating: false, count: 13 )
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.dataSource = self
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Music>()
        snapshot.appendSections([.all])
        snapshot.appendItems(musics, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
        tableView.separatorStyle = .none
    }
    

    func configureDataSource() -> UITableViewDiffableDataSource<Section, Music> {
        
        let cellIdentifier = "datacell"
        
        let dataSource = UITableViewDiffableDataSource<Section, Music>(
        tableView: tableView,
        cellProvider: { tableView, indexPath, music in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MusicTableViewCell
            
            cell.nameLabel.text = music.name
            cell.typeLabel.text = music.type
            cell.infoLabel.text = music.info
            cell.thumbnailImageView.image = UIImage(named: music.image)
            
            
            
            cell.accessoryType = .checkmark
            //cell.nameLabel?.text = musicNames
            
            
            return cell
            }
        )
        return dataSource
    }
    
    // MARK: - UITableViewDelegate Protocol
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do", preferredStyle: .actionSheet)
        
        if let popeverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popeverController.sourceView = cell
                popeverController.sourceRect = cell.bounds
            }
        }
        
        //Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        //Handler for "Get More Info" button
        let getInfoActionHandler = { (action: UIAlertAction!) -> Void in
            
            let alertMessage = UIAlertController(title: "Not available Yet", message: "Sorry this feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
       
        let getInfoAction = UIAlertAction(title: "Get More Info", style: .default, handler: getInfoActionHandler)
        optionMenu.addAction(getInfoAction)
        
        //Favorite action button for music types
        
        let favoriteActionTitle = self.musics[indexPath.row].isFavorite ? "Remove from favorites" : "Mark as favorite"
        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = self.musics[indexPath.row].isFavorite ? .checkmark :  .none
            
            self.musics[indexPath.row].isFavorite = self.musics[indexPath.row].isFavorite ? false : true
        })
        optionMenu.addAction(favoriteAction)
        
        present(optionMenu, animated: true, completion: nil)
        
        
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        
    }
    
    
}
