//
// Autogenerated by Natalie - Storyboard Generator Script.
// http://blog.krzyzanowskim.com
//

import UIKit

//MARK: - Storyboards
struct Storyboards {

    struct Main {

        static let identifier = "Main"

        static var storyboard:UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> CustomNavigationController! {
            return self.storyboard.instantiateInitialViewController() as! CustomNavigationController
        }

        static func instantiateViewControllerWithIdentifier(identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewControllerWithIdentifier(identifier) as! UIViewController
        }
    }
}

//MARK: - ReusableKind
enum ReusableKind: String, Printable {
    case TableViewCell = "tableViewCell"
    case CollectionViewCell = "collectionViewCell"

    var description: String { return self.rawValue }
}

//MARK: - SegueKind
enum SegueKind: String, Printable {    
    case Relationship = "relationship" 
    case Show = "show"                 
    case Presentation = "presentation" 
    case Embed = "embed"               
    case Unwind = "unwind"             

    var description: String { return self.rawValue } 
}

//MARK: - SegueProtocol
public protocol IdentifiableProtocol: Equatable {
    var identifier: String? { get }
}

public protocol SegueProtocol: IdentifiableProtocol {
}

public func ==<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

public func ~=<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

//MARK: - ReusableProtocol
public protocol ReusableProtocol: IdentifiableProtocol {
    var viewType: UIView.Type? {get}
}

public func ==<T: ReusableProtocol, U: ReusableProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

//MARK: - Protocol Implementation
extension UIStoryboardSegue: SegueProtocol {
}

extension UICollectionReusableView: ReusableProtocol {
    public var viewType: UIView.Type? { return self.dynamicType}
    public var identifier: String? { return self.reuseIdentifier}
}

extension UITableViewCell: ReusableProtocol {
    public var viewType: UIView.Type? { return self.dynamicType}
    public var identifier: String? { return self.reuseIdentifier}
}

//MARK: - UIViewController extension
extension UIViewController {
    func performSegue<T: SegueProtocol>(segue: T, sender: AnyObject?) {
       performSegueWithIdentifier(segue.identifier, sender: sender)
    }
}

//MARK: - UICollectionViewController

extension UICollectionViewController {

    func dequeueReusableCell<T: ReusableProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> AnyObject {
        return self.collectionView!.dequeueReusableCellWithReuseIdentifier(reusable.identifier!, forIndexPath: forIndexPath)
    }

    func registerReusable<T: ReusableProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            self.collectionView?.registerClass(type, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryViewOfKind<T: ReusableProtocol>(elementKind: String, withReusable reusable: T, forIndexPath: NSIndexPath!) -> AnyObject {
        return self.collectionView!.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: reusable.identifier!, forIndexPath: forIndexPath)
    }

    func registerReusable<T: ReusableProtocol>(reusable: T, forSupplementaryViewOfKind elementKind: String) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            self.collectionView?.registerClass(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        }
    }
}
//MARK: - UITableViewController

extension UITableViewController {

    func dequeueReusableCell<T: ReusableProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> AnyObject {
        return self.tableView!.dequeueReusableCellWithIdentifier(reusable.identifier!, forIndexPath: forIndexPath)
    }

    func registerReusableCell<T: ReusableProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            self.tableView?.registerClass(type, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooter<T: ReusableProtocol>(reusable: T) -> AnyObject? {
        if let identifier = reusable.identifier {
            return self.tableView?.dequeueReusableHeaderFooterViewWithIdentifier(identifier)
        }
        return nil
    }

    func registerReusableHeaderFooter<T: ReusableProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
             self.tableView?.registerClass(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}

//MARK: - CustomNavigationController

//MARK: - EpisodeViewController

//MARK: - SeasonViewController
extension UIStoryboardSegue {
    func selection() -> SeasonViewController.Segue? {
        if let identifier = self.identifier {
            return SeasonViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension SeasonViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case season_to_episode = "season_to_episode"

        var kind: SegueKind? {
            switch (self) {
            case season_to_episode:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case season_to_episode:
                return EpisodeViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}
extension SeasonViewController { 

    enum Reusable: String, Printable, ReusableProtocol {
        case EpisodeCell = "EpisodeCell"

        var kind: ReusableKind? {
            switch (self) {
            case EpisodeCell:
                return ReusableKind(rawValue: "tableViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case EpisodeCell:
                return EpisodeTableViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - ShowInfoViewController
extension UIStoryboardSegue {
    func selection() -> ShowInfoViewController.Segue? {
        if let identifier = self.identifier {
            return ShowInfoViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension ShowInfoViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case show_overview = "show_overview"
        case show_seasons = "show_seasons"

        var kind: SegueKind? {
            switch (self) {
            case show_overview:
                return SegueKind(rawValue: "show")
            case show_seasons:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case show_overview:
                return ShowOverviewViewController.self
            case show_seasons:
                return SeasonsTableViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}

//MARK: - ShowOverviewViewController

//MARK: - SeasonsTableViewController
extension SeasonsTableViewController { 

    enum Reusable: String, Printable, ReusableProtocol {
        case SeasonCell = "SeasonCell"

        var kind: ReusableKind? {
            switch (self) {
            case SeasonCell:
                return ReusableKind(rawValue: "tableViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case SeasonCell:
                return SeasonsTableViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - ShowsViewController
extension UIStoryboardSegue {
    func selection() -> ShowsViewController.Segue? {
        if let identifier = self.identifier {
            return ShowsViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension ShowsViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case show_details = "show_details"

        var kind: SegueKind? {
            switch (self) {
            case show_details:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case show_details:
                return ShowInfoViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}
extension ShowsViewController { 

    enum Reusable: String, Printable, ReusableProtocol {
        case ShowCell = "ShowCell"

        var kind: ReusableKind? {
            switch (self) {
            case ShowCell:
                return ReusableKind(rawValue: "collectionViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case ShowCell:
                return ShowsCollectionViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}

