
# GridSnap - iOS Image Grid App

## Overview
GridSnap is an iOS application that efficiently loads and displays images in a scrollable grid. It implements asynchronous image loading, caching mechanisms for both memory and disk, error handling for network errors and image loading failures, and ensures smooth scrolling performance.

## Tasks
1. **Image Grid**: Displays a 3-column square image grid with center-cropped images.
2. **Image Loading**: Implements asynchronous image loading using the provided URL.
3. **Display**: Allows users to scroll through at least 100 images.
4. **Caching**: Develops caching mechanisms to store images retrieved from the API in both memory and disk cache for efficient retrieval.
5. **Error Handling**: Gracefully handles network errors and image loading failures, providing informative error messages or placeholders for failed image loads.

## Implementation Details
- **Language**: SwiftUI
- **Technology**: Native iOS development

## Evaluation Criteria
- Ensures smooth scrolling performance without lag.
- Avoids holding up the loading of images on later pages while waiting for initial pages to load.
- Disk and memory caching mechanisms are functional and efficient.
- Code compiles with the latest Xcode version.

## Instructions
1. Clone this repository to your local machine.
2. Open the project in Xcode.
3. Build and run the project on a simulator or a physical iOS device.
4. Scroll through the image grid to view images.
5. Check caching mechanisms and error handling by simulating network errors or image loading failures.

## Dependencies
- No third-party image loading library is used.

