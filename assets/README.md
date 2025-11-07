# Assets Folder

This folder contains all static assets for the DocSaver app.

## Structure

```
assets/
├── images/          # App images, illustrations, onboarding
├── icons/           # Custom icons (if not using Material Icons)
└── animations/      # Lottie animations (optional)
```

## Guidelines

### Images
- Use PNG for images with transparency
- Use JPEG for photos
- Optimize images before adding (TinyPNG, ImageOptim)
- Max size: 1MB per image

### Icons
- Prefer Material Icons or Cupertino Icons
- Use SVG for custom icons
- Size: 24x24 for standard icons

### Animations
- Use Lottie JSON files
- Keep animations under 100KB
- Test performance on low-end devices

## Adding Assets

1. Place files in appropriate folder
2. Add to `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/images/
       - assets/icons/
       - assets/animations/
   ```

3. Use in code:
   ```dart
   Image.asset('assets/images/logo.png')
   ```

