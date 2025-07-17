# Requirements Document

## Introduction

공사현장 관리자들을 위한 모바일 앱으로, 사진 촬영 시 사진 모서리에 공사명, 공종, 위치, 메모, 일시 등의 정보가 포함된 보드판을 추가하여 저장하는 기능을 제공합니다. 촬영된 사진들은 카테고리별로 분류하여 관리할 수 있으며, 사용자가 입력한 정보는 SQLite 로컬 데이터베이스에 저장되어 자동완성 기능을 통해 재사용할 수 있습니다.

## Requirements

### Requirement 1

**User Story:** As a construction site manager, I want to take photos with information boards attached, so that I can document work progress with contextual information.

#### Acceptance Criteria

1. WHEN the user opens the camera function THEN the system SHALL display a camera interface with board information input fields
2. WHEN the user fills in construction name, work type, location, memo, and date information THEN the system SHALL overlay this information on the photo preview
3. WHEN the user takes a photo THEN the system SHALL save the photo with the information board permanently attached
4. WHEN the user takes a photo THEN the system SHALL save the photo to a separate "박기사보드판" album in the device gallery

### Requirement 2

**User Story:** As a construction site manager, I want my previously entered information to be saved and auto-suggested, so that I can quickly input repetitive information.

#### Acceptance Criteria

1. WHEN the user enters information (construction name, work type, location, memo) THEN the system SHALL save this information to SQLite local database
2. WHEN the user starts typing in any information field THEN the system SHALL display auto-complete suggestions based on previously entered data
3. WHEN the user selects an auto-complete suggestion THEN the system SHALL populate the field with the selected value
4. IF the user enters new information THEN the system SHALL add it to the auto-complete database

### Requirement 3

**User Story:** As a construction site manager, I want to view my photos organized by categories, so that I can easily find specific photos later.

#### Acceptance Criteria

1. WHEN the user accesses the photo gallery THEN the system SHALL display photos organized by date, location, and work type categories
2. WHEN the user selects a category filter THEN the system SHALL show only photos matching that category
3. WHEN the user views a photo THEN the system SHALL display the associated board information
4. WHEN the user searches for photos THEN the system SHALL allow searching by date range, location, or work type

### Requirement 4

**User Story:** As a construction site manager, I want the app to work on both Android and iOS devices, so that all team members can use it regardless of their device.

#### Acceptance Criteria

1. WHEN the app is installed on Android devices THEN the system SHALL provide full functionality including camera, database, and gallery features
2. WHEN the app is installed on iOS devices THEN the system SHALL provide full functionality including camera, database, and gallery features
3. WHEN photos are saved THEN the system SHALL create a separate album in the device's native gallery app
4. WHEN the app requests permissions THEN the system SHALL properly handle camera and storage permissions on both platforms

### Requirement 5

**User Story:** As a construction site manager, I want to manually input location information including building details, so that I can specify exact locations like apartment units and floors.

#### Acceptance Criteria

1. WHEN the user accesses the location field THEN the system SHALL allow manual text input for location details
2. WHEN the user enters location information THEN the system SHALL accept detailed descriptions like apartment building names, unit numbers, and floor information
3. WHEN the user enters location data THEN the system SHALL save this information for auto-complete suggestions
4. WHEN the user starts typing location information THEN the system SHALL display previously entered location suggestions

### Requirement 6

**User Story:** As a construction site manager, I want to customize the information board layout and content, so that it fits my specific documentation needs.

#### Acceptance Criteria

1. WHEN the user accesses board settings THEN the system SHALL allow customization of board position (top-left, top-right, bottom-left, bottom-right)
2. WHEN the user configures board content THEN the system SHALL allow enabling/disabling specific information fields
3. WHEN the user customizes board appearance THEN the system SHALL allow adjustment of board transparency/opacity
4. WHEN the user saves board configuration THEN the system SHALL apply these settings to all future photos
5. WHEN taking photos THEN the system SHALL display the board with white background and black text by default

### Requirement 7

**User Story:** As a construction site manager, I want photos to be captured in high quality, so that important details are clearly visible for documentation purposes.

#### Acceptance Criteria

1. WHEN the user takes a photo THEN the system SHALL capture images at minimum 1920x1080 (Full HD) resolution
2. WHEN the camera is available THEN the system SHALL use the highest available resolution up to 4K if supported by the device
3. WHEN saving photos THEN the system SHALL maintain original image quality without compression loss
4. WHEN displaying photo previews THEN the system SHALL show compressed versions for performance while keeping originals intact