//
//  ModInfo.swift
//  ModRank
//
//  Created by Nick Fisher on 11/5/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit
import os.log

class ModInfo: NSObject, NSCoding {
    
    //MARK: Properties
    struct PropertyKey {
        static let title = "title"
        static let itemTitle = "itemTitle"
        static let comments = "comments"
        static let id = "id"
        static let img = "img"
        static let subs = "subs"
        static let favs = "favs"
        static let unsubscribes = "unsubscribes"
        static let views = "views"
        static let commentsRank = "commentsRank"
        static let commentsPercent = "commentsPercent"
        static let subsPercent = "subsPercent"
        static let subsRank = "subsRank"
        static let favsRank = "favsRank"
        static let favsPercent = "favsPercent"
        static let unsubscribesRank = "unsubscribesRank"
        static let unsubscribesPercent = "unsubscribesPercent"
        static let viewsRank = "viewsRank"
        static let viewsPercent = "viewsPercent"
    }
    
    var title: String
    var id: Int
    var itemTitle: String
    var comments: Int
    var subs: Int
    var favs: Int
    var views: Int
    var unsubscribes: Int
    var img: UIImage?
    var favsRank: Int
    var favsPercent: Float
    var subsRank: Int
    var subsPercent: Float
    var unsubscribesRank: Int
    var unsubscribesPercent: Float
    var viewsRank: Int
    var viewsPercent: Float
    var commentsRank: Int
    var commentsPercent: Float
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("mods")
    
    //MARK: Initialization
    init(title: String, id: Int, itemTitle: String, comments: Int, subs: Int,
         favs: Int, views: Int, unsubscribes: Int, img: UIImage?, favsRank: Int,
         favsPercent: Float, subsRank: Int, subsPercent: Float, unsubscribesRank: Int,
         unsubscribesPercent: Float, viewsRank: Int, viewsPercent: Float,
         commentsRank: Int, commentsPercent: Float) {
        self.title = title;
        self.id = id;
        self.itemTitle = title;
        self.comments = comments;
        self.subs = subs;
        self.favs = favs;
        self.views = views;
        self.unsubscribes = unsubscribes;
        self.img = img;
        self.favsRank = favsRank;
        self.favsPercent = favsPercent;
        self.subsRank = subsRank;
        self.subsPercent = subsPercent;
        self.unsubscribesRank = unsubscribesRank;
        self.unsubscribesPercent = unsubscribesPercent;
        self.viewsRank = viewsRank;
        self.viewsPercent = viewsPercent;
        self.commentsRank = commentsRank;
        self.commentsPercent = commentsPercent;
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(title: aDecoder.decodeObject(forKey: PropertyKey.title) as! String,
                  id: aDecoder.decodeObject(forKey: PropertyKey.id) as! Int,
                  itemTitle: aDecoder.decodeObject(forKey: PropertyKey.itemTitle) as! String,
                  comments: aDecoder.decodeObject(forKey: PropertyKey.comments) as! Int,
                  subs: aDecoder.decodeObject(forKey: PropertyKey.subs) as! Int,
                  favs: aDecoder.decodeObject(forKey: PropertyKey.favs) as! Int,
                  views: aDecoder.decodeObject(forKey: PropertyKey.views) as! Int,
                  unsubscribes: aDecoder.decodeObject(forKey: PropertyKey.unsubscribes) as! Int,
                  img: aDecoder.decodeObject(forKey: PropertyKey.img) as? UIImage,
                  favsRank: aDecoder.decodeObject(forKey: PropertyKey.favsRank) as! Int,
                  favsPercent: aDecoder.decodeObject(forKey: PropertyKey.favsPercent) as! Float,
                  subsRank: aDecoder.decodeObject(forKey: PropertyKey.subsRank) as! Int,
                  subsPercent: aDecoder.decodeObject(forKey: PropertyKey.subsPercent) as! Float,
                  unsubscribesRank: aDecoder.decodeObject(forKey: PropertyKey.unsubscribesRank) as! Int,
                  unsubscribesPercent: aDecoder.decodeObject(forKey: PropertyKey.unsubscribesPercent) as! Float,
                  viewsRank: aDecoder.decodeObject(forKey: PropertyKey.viewsRank) as! Int,
                  viewsPercent: aDecoder.decodeObject(forKey: PropertyKey.viewsPercent) as! Float,
                  commentsRank: aDecoder.decodeObject(forKey: PropertyKey.commentsRank) as! Int,
                  commentsPercent: aDecoder.decodeObject(forKey: PropertyKey.commentsPercent) as! Float)
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(itemTitle, forKey: PropertyKey.itemTitle)
        aCoder.encode(comments, forKey: PropertyKey.comments)
        aCoder.encode(subs, forKey: PropertyKey.subs)
        aCoder.encode(favs, forKey: PropertyKey.favs)
        aCoder.encode(views, forKey: PropertyKey.views)
        aCoder.encode(unsubscribes, forKey: PropertyKey.unsubscribes)
        aCoder.encode(img, forKey: PropertyKey.img)
        aCoder.encode(favsRank, forKey: PropertyKey.favsRank)
        aCoder.encode(favsPercent, forKey: PropertyKey.favsPercent)
        aCoder.encode(subsRank, forKey: PropertyKey.subsRank)
        aCoder.encode(unsubscribesRank, forKey: PropertyKey.unsubscribesRank)
        aCoder.encode(unsubscribesPercent, forKey: PropertyKey.unsubscribesPercent)
        aCoder.encode(viewsRank, forKey: PropertyKey.viewsRank)
        aCoder.encode(viewsPercent, forKey: PropertyKey.viewsPercent)
        aCoder.encode(commentsPercent, forKey: PropertyKey.commentsPercent)
        aCoder.encode(commentsRank, forKey: PropertyKey.commentsRank)
    }
}
