//
//  HomeViewModel.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 25/12/23.
//
import Foundation
import Combine
import CoreData
import UIKit
protocol HomeViewModelProtocol {
    func fetchLaunchesList()
    var listDidChanges: ((Bool, Bool) -> Void)? { get set }
}
class HomeViewModel: HomeViewModelProtocol {
    var listDidChanges: ((Bool, Bool) -> Void)?
    var error = ""
    var launchesItems = [LaunchesItem]() {
        didSet {
            self.listDidChanges!(true, false)
        }
    }
    var launchesCore = [LaunchesCore]()
    var linksCore = [LinksCore]()
    /// Reference to CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context2: NSManagedObjectContext!
    
    func detectEntryDate() {
        if UserDefaults.standard.object(forKey: "lastDate") == nil {
            UserDefaults.standard.set(Date().onlyDate, forKey: "lastDate")
            self.fetchLaunchesList()
        } else {
            let currentDate = Date().onlyDate ?? Date()
            let lastDate = UserDefaults.standard.object(forKey: "lastDate") as! Date
            if currentDate > lastDate {
                UserDefaults.standard.set(Date().onlyDate, forKey: "lastDate")
                self.fetchLaunchesList()
            } else {
                UserDefaults.standard.set(Date().onlyDate, forKey: "lastDate")
                self.readCoreData()
            }
        }
    }
    func fetchLaunchesList() {
        WebServiceManager.init().fetchLaunchesList(params: nil) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let mappedModel = try decoder.decode(LaunchesModel.self, from: data) as LaunchesModel
                    let orderArray = mappedModel.sorted(by: { $0.launchDateUnix > $1.launchDateUnix })
                    self.launchesItems = self.cleanArray(launchArray: orderArray)
                    self.deleteEntity(entityName: "LaunchesCore")
                    self.deleteEntity(entityName: "LinksCore")
                    self.deleteEntity(entityName: "FlickrImagesCore")
                    self.saveCoreData(launchesItems: self.cleanArray(launchArray: orderArray))
                } catch {
                    self.error = error.localizedDescription
                    self.listDidChanges!(true, true)
                    print(error)
                }
                break
            case .failure(let error, let errorMsg):
                self.error = errorMsg
                self.listDidChanges!(true, true)
                print(error.description)
            }
        }
    }
    func saveCoreData(launchesItems: [LaunchesItem]) {
        let context2 = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
        for launch in launchesItems {
            let newLaunche = NSEntityDescription.insertNewObject(forEntityName: "LaunchesCore", into: context2) as! LaunchesCore
            let linksLaunche = NSEntityDescription.insertNewObject(forEntityName: "LinksCore", into: context2) as! LinksCore
            newLaunche.dateLocal = launch.launchDateLocal.valueOrEmpty
            newLaunche.dateUnix = Float(launch.launchDateUnix)
            newLaunche.missionName = launch.missionName
            newLaunche.missionPatchUrl = launch.links.missionPatchSmall.valueOrEmpty
            newLaunche.rocketName = launch.rocket.rocketName.rawValue
            newLaunche.rocketType = launch.rocket.rocketType.rawValue
            newLaunche.siteName = launch.launchSite.siteName.rawValue
            newLaunche.siteNameLong = launch.launchSite.siteNameLong.rawValue
            newLaunche.details = launch.details.valueOrEmpty
            linksLaunche.articleLink = launch.links.articleLink.valueOrEmpty
            linksLaunche.youtubeID = launch.links.youtubeID
            linksLaunche.flickrImages = launch.links.flickrImages
            newLaunche.linkRelation = linksLaunche
        }
        do {
            try context2.save()
            print("successfully saved")
        } catch {
            print("Could not save")
        }
        self.readCoreData()
    }
    func readCoreData() {
        let request: NSFetchRequest<LaunchesCore> = LaunchesCore.fetchRequest()
        let requestLinks: NSFetchRequest<LinksCore> = LinksCore.fetchRequest()
        do {
            launchesCore = try context.fetch(request)
            linksCore = try context.fetch(requestLinks)
            self.passCoreData()
        } catch {
            print("error core data = ", error.localizedDescription)
        }
    }
    func passCoreData() {
        /// Se asignan valores opcionales a la estructura
        for itemCore in launchesCore {
            let tentativeeMax = TentativeMaxPrecision.hour
            let rocketId = RocketID.falcon1
            let rocketName = RocketName(rawValue: itemCore.rocketName.valueOrEmpty) ?? RocketName.falcon1
            let rocketType = RocketType(rawValue: itemCore.rocketType.valueOrEmpty) ?? RocketType.merlinC
            let firstStage = FirstStage(cores: [])
            let payloadType = PayloadType.dragon11
            let referenceSystem = ReferenceSystem.geocentric
            let regime = Regime.geostationary
            let orbitParams = OrbitParams(referenceSystem: referenceSystem,
                                          regime: regime,
                                          longitude: 0.0,
                                          semiMajorAxisKM: 0.0,
                                          eccentricity: 0.0,
                                          periapsisKM: 0.0,
                                          apoapsisKM: 0.0,
                                          inclinationDeg: 0.0,
                                          periodMin: 0.0,
                                          lifespanYears: 0.0,
                                          epoch: "",
                                          meanMotion: 0.0,
                                          raan: 0.0,
                                          argOfPericenter: 0.0,
                                          meanAnomaly: 0.0)
            let payloads = Payload(payloadID: "",
                                   noradID: [0],
                                   reused: false,
                                   customers: [""],
                                   nationality: "",
                                   manufacturer: "",
                                   payloadType: payloadType,
                                   payloadMassKg: 0.0,
                                   payloadMassLbs: 0.0,
                                   orbit: "",
                                   orbitParams: orbitParams,
                                   capSerial: "",
                                   massReturnedKg: 0.0,
                                   massReturnedLbs: 0.0,
                                   flightTimeSEC: 0,
                                   cargoManifest: "",
                                   uid: "")
            let secondStage = SecondStage(block: 0, payloads: [payloads])
            let ship = Ship.gomschief
            let fairings = Fairings(reused: false,
                                    recoveryAttempt: false,
                                    recovered: false,
                                    ship: ship)
            let rocket = Rocket(rocketID: rocketId,
                                rocketName: rocketName,
                                rocketType: rocketType,
                                firstStage: firstStage,
                                secondStage: secondStage,
                                fairings: fairings)
            let telemetry = Telemetry(flightClub:  "")
            let siteId = SiteID.kwajaleinAtoll
            let siteName = SiteName(rawValue: itemCore.siteName.valueOrEmpty) ?? SiteName.ccafsSlc40
            let sitenameLong = SiteNameLong(rawValue: itemCore.siteNameLong.valueOrEmpty) ?? SiteNameLong.kwajaleinAtollOmelekIsland
            let launchSite = LaunchSite(siteID: siteId,
                                        siteName: siteName,
                                        siteNameLong: sitenameLong)
            let launchFailureDetails = LaunchFailureDetails(time: 0,
                                                            altitude: 0,
                                                            reason: "")
            let links = Links(missionPatch: itemCore.missionPatchUrl,
                              missionPatchSmall: itemCore.missionPatchUrl,
                              redditCampaign: "",
                              redditLaunch: "",
                              redditRecovery: "",
                              redditMedia: "",
                              presskit: "",
                              articleLink: itemCore.linkRelation?.articleLink,
                              wikipedia: "",
                              videoLink: "",
                              youtubeID:  itemCore.linkRelation?.youtubeID ?? "",
                              flickrImages: itemCore.linkRelation?.flickrImages ?? [""])
            let launchDateSource = LaunchDateSource.launchLibrary
            let launchItemCore = LaunchesItem(flightNumber: 0,
                                              missionName: itemCore.missionName.valueOrEmpty,
                                              missionID: [],
                                              upcoming: false,
                                              launchYear: "",
                                              launchDateUnix: Int(itemCore.dateUnix),
                                              launchDateUTC: "",
                                              launchDateLocal: itemCore.dateLocal,
                                              isTentative: false,
                                              tentativeMaxPrecision: tentativeeMax,
                                              tbd: false,
                                              launchWindow: 0,
                                              rocket: rocket,
                                              ships: [],
                                              telemetry: telemetry,
                                              launchSite: launchSite,
                                              launchSuccess: false,
                                              launchFailureDetails: launchFailureDetails,
                                              links: links,
                                              details: itemCore.details,
                                              staticFireDateUTC: "",
                                              staticFireDateUnix: 0,
                                              timeline: ["": 0],
                                              crew: [],
                                              lastDateUpdate: "",
                                              lastLlLaunchDate: "",
                                              lastLlUpdate: "",
                                              lastWikiLaunchDate: "",
                                              lastWikiRevision: "",
                                              lastWikiUpdate: "",
                                              launchDateSource: launchDateSource)
            self.launchesItems.append(launchItemCore)
        }
        let orderArray = launchesItems.sorted(by: { $0.launchDateUnix > $1.launchDateUnix })
        self.launchesItems = self.cleanArray(launchArray: orderArray)
        self.listDidChanges!(true, false)
    }
    func deleteEntity(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    func orderArray(state: Bool) {
        if state {
            let arrayAsc = self.launchesItems.sorted(by: { $0.launchDateUnix > $1.launchDateUnix })
            self.launchesItems = cleanArray(launchArray: arrayAsc)
        } else {
            let arrayDesc = self.launchesItems.sorted(by: { $0.launchDateUnix < $1.launchDateUnix })
            self.launchesItems = cleanArray(launchArray: arrayDesc)
        }
    }
    func cleanArray(launchArray: [LaunchesItem]) -> [LaunchesItem] {
        var urlImage = [""]
        var cleanArray = [LaunchesItem]()
        for item in launchArray {
            let img = item.links.missionPatchSmall.valueOrEmpty
            if !urlImage.contains(img) {
                urlImage.append(img)
                cleanArray.append(item)
            }
        }
        return cleanArray
    }
}
