# FeedViewPost Context

This directory contains the implementation of a social media post view component in the Horizon app. The module follows a clean MVVM architecture pattern and is designed to display posts with various features like text, attachments, author information, and engagement metrics.

## Core Files

### FeedViewPostView.swift

The main view component that orchestrates the layout of a post. It uses a ViewModel for data management and composes several sub-components to create the complete post UI. The view handles:

- Post header with repost information
- Author profile picture
- Author context (name, handle, etc.)
- Post text content
- Media attachments
- Layout and spacing

### FeedViewPost+ViewModel.swift

The ViewModel that manages the data and state for a post. It implements:

- Post metadata (ID, creation time, URI)
- Author information
- Content (text and attachments)
- Engagement metrics (replies, reposts, likes, quotes)
- Reply and repost context
- Equatable and Hashable conformance for efficient list handling
- Conversion helpers from ATProtoKit data models

## Components Directory

The Components directory contains reusable UI components used by the main FeedViewPost view:

### Core Components

- `FeedAuthorContextView.swift`: Displays author information (name, handle)
- `FeedHeaderView.swift`: Shows repost context and other header information
- `FeedProfilePictureView.swift`: Renders the author's profile picture
- `FeedTextView.swift`: Handles text content display

### Attachments Directory

The Attachments directory contains components for handling various types of post media:

#### FeedAttachmentView.swift

The main coordinator view that handles different types of attachments:

- Routes different embed types to their respective view components
- Currently supports:
  - Images (via PostImagesView)
  - Videos (via PostVideoView)
  - External links (WIP)
  - Record embeds (WIP)
  - Record with media (WIP)

#### PostImagesView.swift

Handles image attachments with two display modes:

- SingleImageView: For posts with one image
  - Displays full-width image
  - Maintains aspect ratio
  - Maximum height of 200 points
  - Rounded corners (12pt radius)
- ImageGridView: For posts with multiple images
  - 2x2 grid layout for up to 4 images
  - Equal spacing between images (4pt)
  - Each image maintains aspect ratio
  - Maximum height of 200 points
  - Rounded corners (12pt radius)
- Features:
  - Async image loading
  - Loading state with progress indicator
  - Error state with placeholder icon
  - Automatic thumbnail optimization

#### PostVideoView.swift

Handles video attachments with:

- Thumbnail display with play button overlay
- Aspect ratio preservation based on video metadata
- Maximum height of 200 points
- Rounded corners (12pt radius)
- Features:
  - Async thumbnail loading
  - Loading state with gray placeholder
  - Error state with gray placeholder
  - Play button overlay (32pt)
  - Shadow effects for better visibility
  - Automatic aspect ratio calculation

## Data Flow

1. The ViewModel receives data from ATProtoKit models
2. Data is transformed and prepared for display
3. The main view composes the UI using the ViewModel's data
4. Sub-components handle specific aspects of the post display

## Usage

This module is used throughout the app wherever posts need to be displayed, such as:

- Main feed
- Profile views
- Search results
- Thread views
