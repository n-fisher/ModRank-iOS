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
    var unsubscribes: Float
    var img: Data
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
    static let ModURL = DocumentsDirectory.appendingPathComponent("mods")
    static let ListURL = DocumentsDirectory.appendingPathComponent("modlists")
    
    
    init(title: String, id: Int, itemTitle: String, comments: Int, subs: Int,
         favs: Int, views: Int, unsubscribes: Float, img: Data, favsRank: Int,
         favsPercent: Float, subsRank: Int, subsPercent: Float, unsubscribesRank: Int,
         unsubscribesPercent: Float, viewsRank: Int, viewsPercent: Float,
         commentsRank: Int, commentsPercent: Float) {
        self.title = title;
        self.id = id;
        self.itemTitle = itemTitle;
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
                  id: aDecoder.decodeInteger(forKey: PropertyKey.id),
                  itemTitle: aDecoder.decodeObject(forKey: PropertyKey.itemTitle) as! String,
                  comments: aDecoder.decodeInteger(forKey: PropertyKey.comments),
                  subs: aDecoder.decodeInteger(forKey: PropertyKey.subs),
                  favs: aDecoder.decodeInteger(forKey: PropertyKey.favs),
                  views: aDecoder.decodeInteger(forKey: PropertyKey.views),
                  unsubscribes: aDecoder.decodeFloat(forKey: PropertyKey.unsubscribes),
                  img: aDecoder.decodeObject(forKey: PropertyKey.img) as! Data,
                  favsRank: aDecoder.decodeInteger(forKey: PropertyKey.favsRank),
                  favsPercent: aDecoder.decodeFloat(forKey: PropertyKey.favsPercent),
                  subsRank: aDecoder.decodeInteger(forKey: PropertyKey.subsRank),
                  subsPercent: aDecoder.decodeFloat(forKey: PropertyKey.subsPercent),
                  unsubscribesRank: aDecoder.decodeInteger(forKey: PropertyKey.unsubscribesRank),
                  unsubscribesPercent: aDecoder.decodeFloat(forKey: PropertyKey.unsubscribesPercent),
                  viewsRank: aDecoder.decodeInteger(forKey: PropertyKey.viewsRank),
                  viewsPercent: aDecoder.decodeFloat(forKey: PropertyKey.viewsPercent),
                  commentsRank: aDecoder.decodeInteger(forKey: PropertyKey.commentsRank),
                  commentsPercent: aDecoder.decodeFloat(forKey: PropertyKey.commentsPercent))
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
        aCoder.encode(subsPercent, forKey: PropertyKey.subsPercent)
        aCoder.encode(unsubscribesRank, forKey: PropertyKey.unsubscribesRank)
        aCoder.encode(unsubscribesPercent, forKey: PropertyKey.unsubscribesPercent)
        aCoder.encode(viewsRank, forKey: PropertyKey.viewsRank)
        aCoder.encode(viewsPercent, forKey: PropertyKey.viewsPercent)
        aCoder.encode(commentsPercent, forKey: PropertyKey.commentsPercent)
        aCoder.encode(commentsRank, forKey: PropertyKey.commentsRank)
    }
}
