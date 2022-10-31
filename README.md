# Description

The project’s idea is to list trending projects from Github, tap on one of them, and show their details.

In case you would like to try it out, you should replace the token with your GitHub token in NetworkingManager line 21.

# Solution
- SwiftUI
- MVVM
- Combine
- Dependency Injection
- String Localization

# Testing
- Unit tests for ViewModels
- UI test for the 3 main View
- Test coverage is 84.5%
- Tested on iOS 15 & 16 on different devices

# Dependencies:
- GithubTrendingAPI - GitHub trending scraper
- MarkdownView - Advanced .md viewer

https://user-images.githubusercontent.com/6025333/198837755-f35e4db8-ab95-4889-9625-06331c52f87b.MOV

https://user-images.githubusercontent.com/6025333/198837795-76d5cd8c-9bc4-4dd9-b0d7-d657aeda77b6.MOV

https://user-images.githubusercontent.com/6025333/198837805-9a9a3459-7fd6-4700-aff6-c1a96e845a4b.MOV

# Known issues (regarding dependencies):
- **GithubTrendingAPI:**

The scraper package dependency is not the best, the Repository model properties are inaccessible due to 'internal' protection level but still printable so I slice out the necessary information from it. 
  > In case of production this should be forked and fixed.
  
- **MarkdownView:**

**The latest release lacks support for iOS 16, so I forked it and fixed it. Now the projects rely on a version from my GitHub.**

https://github.com/borsosbe/MarkdownView/tree/bugfix/ios_16

Also created a pull request for them: https://github.com/keitaoouchi/MarkdownView/pull/103

The MarkdownView webView solution throws some warning on the console, but nothing major.
 > In case of production this should be forked and further fixed.

## Known issues (regarding GitHub API):
On rare occasions, GitHub Repos READ.me download URL is not reliable from the GitHub API. Good chance you never notice that, but worth to mention.
> api/repos/{owner}/{repo}/contents/{path} -> response "message": "Not Found"




