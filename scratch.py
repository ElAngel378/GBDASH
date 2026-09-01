import base64
with open('C:/Users/soter/Source/Repos/GBDASH/levels/chr_data/chr_gb_new.png', 'rb') as f:
    b64 = base64.b64encode(f.read()).decode('utf-8')
html = '<h1>chr_gb_new.png</h1><img src="data:image/png;base64,' + b64 + '" style="image-rendering: pixelated; width: 512px;"/>'
with open('C:/Users/soter/.gemini/antigravity/brain/2d36e70d-683e-4ed1-a301-ba6221101944/scratch/chr_gb_new.html', 'w') as f:
    f.write(html)
