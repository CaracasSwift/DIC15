//: Playground - noun: a place where people can play

import Cocoa

//File Example
//PRECIOS.TXT
//0000100000|BYG0150GOL0400|992,62|0,00|5,00-|12,00|1.056,15|88,01

//Reference
//SKU
//Price
//Discount
//tax1
//IVA
//FULL PRICE
//another

struct Product {

    let reference:String?
    let sku:String?
    let price:String?
    let discount:String?
    let tax:String?
    let iva:String?
    let fullPrice:String?
    let another:String?
    
    init(reference:String?, sku:String?, price:String?, discount:String?, tax:String?, iva:String?, fullPrice:String?, another:String?){
        self.reference = reference
        self.sku = sku
        self.price = price
        self.discount = discount
        self.tax = tax
        self.iva = iva
        self.fullPrice = fullPrice
        self.another = another
    }
}

//File Name -> [String]
func splitString(separator:String) -> (String) -> [String]{
    return {x in x.componentsSeparatedByString(separator)}
}

let splitFileName = splitString(".")

func filenameSplit(name:String) -> [String] {
    return splitString(".")(name)
}

//(FileName) -> FilePath
func filePath(name:[String]) -> String? {
    return NSBundle.mainBundle().pathForResource(name[0], ofType: name[1])
}

//(FilePath) -> NSData?
func readData(path:String?) -> NSData? {
    switch path {
    case .Some(let val):
        return NSFileManager.defaultManager().contentsAtPath(val)
    case .None:
        return nil
    }
}


//(NSData?) -> String
func stringFromData(data:NSData?) -> String? {
    switch data {
    case .Some(let dat):
        return NSString(data: dat, encoding: NSUTF8StringEncoding) as? String
    case .None :
        return nil
    }
}

//(String) -> [String]
let lineFilter = splitString("\n")

func linesFromString(data:String?) -> [String] {
    switch data {
    case .Some(let dat):
        return lineFilter(dat)
    case .None :
        return []
    }
}

let filterByPipe = splitString("|")

func splitByPipe(x:String) -> [String] {
    return splitString("|")(x)
}

//[String] -> Product
func createSingleProduct(xs:[String]) -> Product {
    return Product(reference: xs[0], sku: xs[1], price: xs[2], discount: xs[3], tax: xs[4], iva: xs[5], fullPrice: xs[6], another: xs[7])
}

//[String] -> [Product]
func createObjects(xs:[String]) -> [Product]{
    
    return xs.map{ createSingleProduct(filterByPipe($0)) }
}

infix operator <<~ { associativity left }

func <<~<A,B,C>(g:B->C, f:A->B) -> A -> C {
    return {x in g(f(x))}
}

//The Old way
let filename = filenameSplit("PRECIOS.TXT")
let fullPath = filePath(filename)
let myData = readData(fullPath)
let myFileString = stringFromData(myData)
let linesFromMyString = linesFromString(myFileString)
let products = createObjects(linesFromMyString)

//Or Composition ... TOO LONG!
let composedProductList = createObjects(linesFromString(stringFromData(readData(filePath(filenameSplit("PRECIOS.TXT"))))))

//Ussing infix operator
//String -> [Prodcuts]
let productList = createObjects <<~ linesFromString <<~ stringFromData <<~ readData <<~ filePath <<~ filenameSplit
let result = productList("PRECIOS.TXT")
