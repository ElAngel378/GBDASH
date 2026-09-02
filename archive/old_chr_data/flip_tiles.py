from PIL import Image
import os

def flip_tiles_horizontally(input_path, output_path, tile_width=16):
    """
    Slices an image into columns of `tile_width`, flips each column 
    horizontally, and reconstructs the image.
    """
    if not os.path.exists(input_path):
        print(f"Error: Could not find '{input_path}'. Check your spelling!")
        return

    # Open the original sprite sheet
    img = Image.open(input_path)
    width, height = img.size
    
    # Create a blank canvas of the exact same size and color mode
    new_img = Image.new(img.mode, (width, height))
    
    # Loop through the width of the image in chunks of 8 pixels
    for x in range(0, width, 8):
        # Define the bounding box for the crop (left, top, right, bottom)
        box = (x, 0, min(x + 8, width), height)
        
        # 1. Crop the 8px wide column
        tile = img.crop(box)
        
        # 2. Flip that specific column left-to-right
        flipped_tile = tile.transpose(Image.Transpose.FLIP_LEFT_RIGHT)
        
        # 3. Paste it back onto the new canvas at the exact same X coordinate
        new_img.paste(flipped_tile, (x, 0))
        
    # Save the final processed image
    new_img.save(output_path)
    print(f"Success! Flipped tiles saved to '{output_path}'")

# --- Run the Script ---
if __name__ == "__main__":
    # You can plug your specific filenames in right here
    input_file = "chr_gb.png" 
    output_file = "chr_gb_flipped.png"
    
    flip_tiles_horizontally(input_file, output_file, tile_width=8)