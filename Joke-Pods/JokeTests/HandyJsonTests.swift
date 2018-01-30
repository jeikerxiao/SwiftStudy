//
//  HandyJsonTests.swift
//  JokeTests
//
//  Created by xiao on 2018/1/30.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import XCTest
import HandyJSON

class HandyJsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testModel() {
        class BasicTypes: HandyJSON {
            var int: Int = 2
            var doubleOptional: Double?
            var stringImplicitlyUnwrapped: String!
            
            required init() {}
        }
        
        let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
        if let object = BasicTypes.deserialize(from: jsonString) {
            print(object.stringImplicitlyUnwrapped)
        }
    }
    
    func testEnum() {
        enum AnimalType: String, HandyJSONEnum {
            case Cat = "cat"
            case Dog = "dog"
            case Bird = "bird"
        }
        
        struct Animal: HandyJSON {
            var name: String?
            var type: AnimalType?
        }
        
        let jsonString = "{\"type\":\"cat\",\"name\":\"Tom\"}"
        if let animal = Animal.deserialize(from: jsonString) {
            print(animal.type?.rawValue)
        }
    }
    
    func testStruct() {
        struct BasicTypes: HandyJSON {
            var int: Int = 2
            var doubleOptional: Double?
            var stringImplicitlyUnwrapped: String!
        }
        
        let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
        if let object = BasicTypes.deserialize(from: jsonString) {
            print(object.stringImplicitlyUnwrapped)
        }
    }
    
    func testPath() {
        class Cat: HandyJSON {
            var id: Int64!
            var name: String!
            
            required init() {}
        }
        
        let jsonString = "{\"code\":200,\"msg\":\"success\",\"data\":{\"cat\":{\"id\":12345,\"name\":\"Kitty\"}}}"
        
        if let cat = Cat.deserialize(from: jsonString, designatedPath: "data.cat") {
            print(cat.name)
        }
    }
    
    func testComposition() {
        class Component: HandyJSON {
            var aInt: Int?
            var aString: String?
            
            required init() {}
        }
        
        class Composition: HandyJSON {
            var aInt: Int?
            var comp1: Component?
            var comp2: Component?
            
            required init() {}
        }
        
        let jsonString = "{\"num\":12345,\"comp1\":{\"aInt\":1,\"aString\":\"aaaaa\"},\"comp2\":{\"aInt\":2,\"aString\":\"bbbbb\"}}"
        
        if let composition = Composition.deserialize(from: jsonString) {
            print(composition)
        }
    }
    
    func testInheritance() {
        class Animal: HandyJSON {
            var id: Int?
            var color: String?
            
            required init() {}
        }
        
        class Cat: Animal {
            var name: String?
            
            required init() {}
        }
        
        let jsonString = "{\"id\":12345,\"color\":\"black\",\"name\":\"cat\"}"
        
        if let cat = Cat.deserialize(from: jsonString) {
            print(cat)
        }
    }
    
    func testJaonArray() {
        class Cat: HandyJSON {
            var name: String?
            var id: String?
            
            required init() {}
        }
        
        let jsonArrayString: String? = "[{\"name\":\"Bob\",\"id\":\"1\"}, {\"name\":\"Lily\",\"id\":\"2\"}, {\"name\":\"Lucy\",\"id\":\"3\"}]"
        if let cats = [Cat].deserialize(from: jsonArrayString) {
            cats.forEach({ (cat) in
                print(cat!.name)
            })
        }
    }
    
    func testNoneBaseType() {
        class ExtendType: HandyJSON {
            var date: Date?
            var decimal: NSDecimalNumber?
            var url: URL?
            var data: Data?
            var color: UIColor?
            
            func mapping(mapper: HelpingMapper) {
                mapper <<<
                    date <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd")
                
                mapper <<<
                    decimal <-- NSDecimalNumberTransform()
                
                mapper <<<
                    url <-- URLTransform(shouldEncodeURLString: false)
                
                mapper <<<
                    data <-- DataTransform()
                
                mapper <<<
                    color <-- HexColorTransform()
            }
            
            public required init() {}
        }
        
        let object = ExtendType()
        object.date = Date()
        object.decimal = NSDecimalNumber(string: "1.23423414371298437124391243")
        object.url = URL(string: "https://www.aliyun.com")
        object.data = Data(base64Encoded: "aGVsbG8sIHdvcmxkIQ==")
        object.color = UIColor.blue
        
        print(object.toJSONString()!)
        // it prints:
        // {"date":"2017-09-11","decimal":"1.23423414371298437124391243","url":"https:\/\/www.aliyun.com","data":"aGVsbG8sIHdvcmxkIQ==","color":"0000FF"}
        
        let mappedObject = ExtendType.deserialize(from: object.toJSONString()!)!
        print(mappedObject.date)
    }
    
    func testSerialization() {
        class BasicTypes: HandyJSON {
            var int: Int = 2
            var doubleOptional: Double?
            var stringImplicitlyUnwrapped: String!
            
            required init() {}
        }
        
        let object = BasicTypes()
        object.int = 1
        object.doubleOptional = 1.1
        object.stringImplicitlyUnwrapped = "hello"
        
        print(object.toJSON()!) // serialize to dictionary
        print(object.toJSONString()!) // serialize to JSON string
        print(object.toJSONString(prettyPrint: true)!) // serialize to pretty JSON string
    }
}
