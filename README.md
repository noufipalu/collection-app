𝐏𝐫𝐨𝐝𝐮𝐜𝐭 𝐂𝐨𝐥𝐥𝐞𝐜𝐭𝐢𝐨𝐧𝐬 𝐅𝐥𝐮𝐭𝐭𝐞𝐫 𝐀𝐩𝐩
A responsive Flutter application featuring an accordion-style product collections interface with smooth animations and intelligent scroll tracking.

Overview:-
This Flutter project demonstrates a modern, production-ready implementation of an expandable product collections interface. The application showcases best practices in state management, responsive design, and smooth user interactions.

Key Highlights:-
Accordion Pattern: Single-expansion accordion for focused user experience
Responsive Design: Adapts seamlessly across mobile, tablet, and desktop
Performance Optimized: Efficient scroll tracking and lazy loading
Clean Architecture: Separation of concerns with reusable components

Features:-
User Interface
✅ Expandable/collapsible collection cards
✅ Horizontal scrollable product gallery
✅ Real-time remaining products counter
✅ Smooth animations and transitions
✅ Touch-friendly tap targets
✅ Loading and error states

Technical Features
✅ Responsive breakpoint system
✅ Stateful scroll position tracking
✅ Network image loading with caching
✅ Gesture-based collapse functionality
✅ Single-expansion accordion logic
✅ Adaptive layout for different screen sizes

File Responsibilities
main.dart
Application initialization
Material theme configuration
Route to main screen

product_collections_screen.dart
Manages overall screen layout
Controls which collection is expanded (single-expansion logic)
Provides scroll view for all collections
Handles responsive layout (single column vs grid)

collection_card.dar
Renders individual collection cards
Manages horizontal scroll state
Tracks current scroll position for counter
Handles expand/collapse animations
Provides tap-to-collapse functionality

collectionModel.dart
Defines data structures
Ensures type safety
Provides model constructors

responsive_helper.dart
Centralizes all responsive logic
Provides consistent breakpoints
Returns device-specific values
Eliminates magic numbers
