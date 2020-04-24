// Docs command main
// runs SourceDocs
import Foundation
import SourceDocs

do {
    switch try SourceDocs().runOnSPM(moduleName: "FuzzyTests",
    outputDirectory: FileManager.default.currentDirectoryPath+"/Documentation") {
    case .success:
        print("Successful run of the documentation phase")
    case .failure(let failure):
        print(failure.localizedDescription)
    }
} catch {
    print(error.localizedDescription)
}
