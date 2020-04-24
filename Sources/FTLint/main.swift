// Lint command main
// runs SourceDocs
import Foundation
import SwiftLintFramework

let config = Configuration(path: FileManager.default.currentDirectoryPath+"/.swiftlint.yml",
    rootPath: FileManager.default.currentDirectoryPath,
    optional: true,
    quiet: true,
    enableAllRules: false,
    cachePath: nil,
    customRulesIdentifiers: [])

for lintable in config.lintableFiles(inPath: FileManager.default.currentDirectoryPath, forceExclude: false) {
    let linter = Linter(file: lintable, configuration: config)
    let storage = RuleStorage()
    let collected = linter.collect(into: storage)
    let violations = collected.styleViolations(using: storage)
    if !violations.isEmpty {
        print(EmojiReporter.generateReport(violations))
    }
}

print("🎉 All done!")
