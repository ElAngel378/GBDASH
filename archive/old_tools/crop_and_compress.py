import os
import sys
import subprocess


def get_row_width(data):
    """
    Infer row width by finding a reasonable divisor of file size.
    We assume height is not fixed here, so we search for a clean width.
    """
    size = len(data)

    # try common tile widths first (Game Boy style maps)
    for w in [160, 192, 256, 320, 384, 512, 640, 768, 896, 1024]:
        if size % w == 0:
            return w

    # fallback brute search
    for w in range(16, min(size, 4096)):
        if size % w == 0:
            return w

    raise ValueError("Could not determine row width")


def main():
    # ---- input handling ----
    if len(sys.argv) >= 2:
        path = sys.argv[1]
    else:
        path = input("Enter .bin file path: ").strip().strip('"')

    if not os.path.exists(path):
        print("File not found:", path)
        input("Press Enter to exit...")
        return

    with open(path, "rb") as f:
        data = f.read()

    width = get_row_width(data)

    print(f"\nLoaded: {path}")
    print(f"Detected row width: {width} bytes")

    # ---- fixed crop settings ----
    start_row = int(input("Start row (default 11): ") or "11")
    height = 16
    end_row = start_row + height

    print(f"Cropping rows {start_row} → {end_row - 1} (16 rows)")

    # ---- crop ----
    out = b"".join(
        data[y * width:(y + 1) * width]
        for y in range(start_row, end_row)
    )

    folder = os.path.dirname(path)
    base = os.path.splitext(os.path.basename(path))[0]

    out_bin = os.path.join(folder, f"{base}_{height}high.bin")

    with open(out_bin, "wb") as f:
        f.write(out)

    print(f"\nSaved: {out_bin}")
    print(f"Size: {len(out)} bytes ({height} rows)")

    # ---- zx0 compression ----
    do_zx0 = input("\nCompress with zx0? (y/n): ").lower().strip()

    if do_zx0 == "y":
        zx0_path = input("zx0 path (Enter = PATH): ").strip()

        if zx0_path == "":
            zx0_path = "zx0"

        out_zx0 = out_bin.replace(".bin", ".zx0")

        try:
            subprocess.run([zx0_path, out_bin, out_zx0], check=True)
            print(f"Compressed: {out_zx0}")
        except FileNotFoundError:
            print("zx0 not found. Put it in PATH or give full path.")
        except subprocess.CalledProcessError:
            print("zx0 failed.")


if __name__ == "__main__":
    main()