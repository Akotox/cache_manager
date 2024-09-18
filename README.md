# Cache Manager for Flutter

The `cache_manager` package provides an efficient solution for storing and retrieving data from a local cache in Flutter applications. This package leverages the **Sembast** database for persistent storage and uses the **path_provider** package to locate appropriate storage paths on the device. It is a perfect fit for developers who want to optimize network requests, reduce latency, and enhance user experience by caching data locally.

## Features

- **Efficient Data Caching**: Cache data for faster access and reduced network requests.
- **Customizable Cache Expiry**: Set custom expiration times for cached data.
- **Retrieve and Update Cached Data**: Easily fetch and update data from the cache.
- **Clear Specific or Entire Cache**: Remove individual cache entries or clear all cached data.
- **Persistent Storage**: Uses Sembast for long-term data persistence.
- **Integration with Path Provider**: Automatically locates the correct directories for storing cache data on Android and iOS devices.
- **Error Handling**: Robust error handling when fetching, updating, or deleting cache entries.

## Getting Started

To use the `cache_manager` package in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  cache_manager: ^1.0.0
```
Ensure that you also include the required packages:
```yaml
dependencies:
  sembast: ^3.1.0
  path_provider: ^2.0.10

```
## Usage

**Initialize Cache Manager**
Before you can store or retrieve data, initialize the CacheManager:

```dart
import 'package:cache_manager/cache_manager.dart';

void main() {
  CacheManager cacheManager = CacheManager();
}
```

**Set Cache Data**
You can cache any data (e.g., API responses, user preferences, etc.) using the setCache method:

```dart
await cacheManager.setCache('user_profile',{'name': 'John Doe', 'email': 'john@example.com'}, duration: Duration(hours: 1), // Cache expiration time
);
```

**Retrieve Cached Data**
Retrieve cached data with the getCache method. If the data has expired, it will return null:

```dart
final userProfile = await cacheManager.getCache('user_profile');

if (userProfile != null) {
  print('Cached User Profile: $userProfile');
} else {
  print('Cache expired or not available.');
}
```

**Delete Cached Data**
You can delete specific cached data by key:

```dart
await cacheManager.deleteCache('user_profile');
```

**Clear All Cached Data**
To remove all cache entries, use the clearAllCache method:

```dart
await cacheManager.clearAllCache();
```
## Additional information
### Contributing

We openly welcome contributions from the developer community. Whether it's improving the code, fixing bugs, or enhancing documentation, your input is valuable. To contribute, please follow these steps:

1. Fork the repository on GitHub.
2. Create a new branch for your changes.
3. Make your changes in the branch.
4. Submit a pull request with a clear description of the improvements.

Before contributing, please read our [Contributing Guidelines](https://discord.gg/stmfH6pMKK) for more details on the process and coding standards.

### Filing Issues

Encountering an issue or have a suggestion? We encourage you to file issues through our GitHub [Issues Page](https://github.com/Akotox/cache_manager/issues). When filing an issue, please provide the following:

- A clear and descriptive title.
- A detailed description of the issue or suggestion.
- Steps to reproduce the issue (if applicable).
- Any relevant code snippets or error messages.

### Support and Response

Our team is committed to providing support for the package users. While we strive to respond to issues and pull requests promptly, please allow a reasonable amount of time for a response. For immediate support or specific queries, you can also reach out to us via [official support channel](https://discord.gg/stmfH6pMKK).