#!/bin/bash
# This script sets up a directory structure for a new art project

# Configure colors for terminal output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo -e "\n${BLUE}==== $1 ====${NC}\n"
}

# Get project name from user or use default
if [ $# -eq 0 ]; then
    echo -e "${YELLOW}No project name provided. Using default name 'new_project'.${NC}"
    PROJECT_NAME="new_project"
else
    PROJECT_NAME=$1
fi

print_header "Setting up art project: $PROJECT_NAME"

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# Create standard directory structure
print_header "Creating directory structure"

mkdir -p sketches references/images references/text 
mkdir -p work_in_progress finals/print finals/digital exports
mkdir -p notes

# Creating some initial files
print_header "Creating initial files"

# Create a project README
cat > README.md << EOF
# Art Project: $PROJECT_NAME

## Project Overview
- Created: $(date +"%Y-%m-%d")
- Medium: 
- Concept: 

## Directory Structure
- sketches/ - Initial sketches and ideas
- references/ - Inspiration and reference materials
- work_in_progress/ - Current working files
- finals/ - Completed works
- exports/ - Exports for web, print, etc.
- notes/ - Project notes and documentation

## Timeline
- Project Start: $(date +"%Y-%m-%d")
- Deadline: 

## Notes

EOF

echo -e "${GREEN}Created README.md${NC}"

# Create a concept file
cat > notes/concept.txt << EOF
PROJECT CONCEPT: $PROJECT_NAME

THEME:

INSPIRATION:

COLOR PALETTE:

TECHNIQUES TO EXPLORE:

GOALS FOR THIS PROJECT:

QUESTIONS TO ANSWER:

EOF

echo -e "${GREEN}Created concept.txt${NC}"

# Create a color palette file
cat > notes/color_palette.txt << EOF
# Color Palette for $PROJECT_NAME

PRIMARY COLORS:
- 

SECONDARY COLORS:
- 

ACCENT COLORS:
-

HEX CODES:
- 
EOF

echo -e "${GREEN}Created color_palette.txt${NC}"

# Create a script for processing final images
cat > process_finals.sh << EOF
#!/bin/bash
# Script to process final images for web and print

# Create web versions (72dpi, 1200px wide max)
for img in finals/digital/*.jpg finals/digital/*.png; do
    [ -e "\$img" ] || continue
    filename=\$(basename "\$img")
    echo "Creating web version: \$filename"
    convert "\$img" -resize 1200x -density 72 "exports/web_\$filename"
done

# Create print versions (300dpi)
for img in finals/digital/*.jpg finals/digital/*.png; do
    [ -e "\$img" ] || continue
    filename=\$(basename "\$img")
    echo "Creating print version: \$filename"
    convert "\$img" -density 300 "exports/print_\$filename"
done

echo "Done processing images!"
EOF

chmod +x process_finals.sh
echo -e "${GREEN}Created process_finals.sh${NC}"

# Create an example image tracking file
cat > notes/image_tracking.txt << EOF
# Image Tracking for $PROJECT_NAME

| Filename | Date Created | Status | Notes |
|----------|--------------|--------|-------|
|          |              |        |       |
|          |              |        |       |
|          |              |        |       |
EOF

echo -e "${GREEN}Created image_tracking.txt${NC}"

# Create a simple HTML gallery generator
cat > create_gallery.sh << EOF
#!/bin/bash
# Script to generate a simple HTML gallery from images

OUTPUT="gallery.html"

echo "<!DOCTYPE html>
<html>
<head>
    <title>$PROJECT_NAME Gallery</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 1200px; margin: 0 auto; padding: 20px; }
        h1 { color: #333; }
        .gallery { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .gallery img { width: 100%; height: auto; box-shadow: 0 3px 10px rgba(0,0,0,0.2); }
    </style>
</head>
<body>
    <h1>$PROJECT_NAME Gallery</h1>
    <p>Created: $(date +"%Y-%m-%d")</p>
    <div class="gallery">" > "\$OUTPUT"

# Add image tags
for img in exports/web_*.jpg exports/web_*.png; do
    [ -e "\$img" ] || continue
    filename=\$(basename "\$img")
    echo "        <img src=\"\$img\" alt=\"\$filename\" title=\"\$filename\">" >> "\$OUTPUT"
done

echo "    </div>
</body>
</html>" >> "\$OUTPUT"

echo "Gallery created: \$OUTPUT"
EOF

chmod +x create_gallery.sh
echo -e "${GREEN}Created create_gallery.sh${NC}"

# Final summary
print_header "Project $PROJECT_NAME is ready!"

echo "Directory structure created:"
find . -type d | sort

echo -e "\nFiles created:"
find . -type f | sort

echo -e "\n${GREEN}Your art project structure is ready to use!${NC}"
echo -e "To process final images later, run: ${YELLOW}./process_finals.sh${NC}"
echo -e "To create a web gallery, run: ${YELLOW}./create_gallery.sh${NC}"
echo -e "\n${BLUE}Happy creating!${NC}"
