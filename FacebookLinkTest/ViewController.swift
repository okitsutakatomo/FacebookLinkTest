//
//  ViewController.swift
//  FacebookLinkTest
//
//  Created by Takatomo Okitsu on 2015/03/03.
//  Copyright (c) 2015年 Takatomo Okitsu. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var fbLoginView: FBLoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fbLoginView.readPermissions = ["publish_actions"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func socialFramework(sender: AnyObject) {
        // availability check
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            // make controller to share on twitter
            var controller = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            // add link to the controller
            let url = NSURL(string: "http://www.dena.com")
            controller.addURL(url)
            controller.addImage(UIImage(named: "image"))
            controller.setInitialText("DeNA")
            
            // show twitter post screen
            presentViewController(controller, animated: true, completion: {})
        }
    }
    
    @IBAction func shareDialog(sender: AnyObject) {
        var params = FBLinkShareParams()
        params.name = "マンガボックス"
        params.caption = "無料で読めますよまじで。"
        params.link = NSURL(string: "https://itunes.apple.com/jp/app/mangabokkusu-ren-qi-zuo-jiano/id633864753?mt=8")
        params.picture = NSURL(string: "http://a124.phobos.apple.com/us/r30/Purple/v4/d9/06/57/d9065784-46a9-affc-411d-fdcf2c053883/mzl.pnunrfca.png")
        
        if FBDialogs.canPresentShareDialogWithParams(params) {
            //Facebookアプリがある場合
            FBDialogs.presentShareDialogWithParams(params, clientState: nil, handler: { (fbAppCall, dictionary, error) -> Void in
                println("done")
            })
        } else {
            //Facebookアプリがない場合
            var params = [
                "name": "マンガボックス",
                "caption": "無料で読めますよまじで。",
                "link": "https://itunes.apple.com/jp/app/mangabokkusu-ren-qi-zuo-jiano/id633864753?mt=8",
                "picture": "http://a124.phobos.apple.com/us/r30/Purple/v4/d9/06/57/d9065784-46a9-affc-411d-fdcf2c053883/mzl.pnunrfca.png",
            ]
            
            FBWebDialogs.presentFeedDialogModallyWithSession(nil, parameters: params, handler: { (result, url, error) -> Void in
                println("done")                
            })
        }
    }
    
    @IBAction func apicall(sender: AnyObject) {
        var params = [
            "name": "マンガボックス",
            "caption": "無料で読めますよまじで。",
            "link": "https://itunes.apple.com/jp/app/mangabokkusu-ren-qi-zuo-jiano/id633864753?mt=8",
            "picture": "http://a124.phobos.apple.com/us/r30/Purple/v4/d9/06/57/d9065784-46a9-affc-411d-fdcf2c053883/mzl.pnunrfca.png",
        ]
        
        FBRequestConnection.startWithGraphPath("/me/feed", parameters: params, HTTPMethod: "POST") { (connection, anyObject, error) -> Void in
            println("done")
        }
    }    

}
