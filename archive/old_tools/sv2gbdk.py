import csv
import struct
import sys

def convert_csv_to_bin(csv_file, bin_file):
    map_data = []
    
    try:
        # CORRECCIÓN: Se agregó la coma después de csv_file
        with open(csv_file, 'r') as f:
            reader = csv.reader(f)
            for row in reader:
                # Se limpian espacios y se convierten a enteros
                clean_row = [int(tile) for tile in row if tile.strip()]
                map_data.extend(clean_row)
        
        print(f"Leídos {len(map_data)} tiles de {csv_file}")
        
        # CORRECCIÓN: Se agregó la coma después de bin_file
        with open(bin_file, 'wb') as f:
            for tile_id in map_data:
                # Empaquetamos como 'B' (unsigned char / 1 byte)
                f.write(struct.pack('B', tile_id & 0xFF))
                
        print(f"Archivo binario guardado: {bin_file}")

    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Uso: python csv2gbdk.py <entrada.csv> <salida.bin>")
    else:
        convert_csv_to_bin(sys.argv[1], sys.argv[2])

