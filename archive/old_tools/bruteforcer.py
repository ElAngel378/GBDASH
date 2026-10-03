def calcular_config_hugetracker():
    try:
        bpm_objetivo = float(input("BPM deseado: "))
    except: return

    freq_reloj = 4096 # Frecuencia fija TAC 0x04
    mejor_error = float('inf')
    res = {}

    # Forzamos TPR a 12 para mantener consistencia musical
    tpr = 12 
    
    for tma in range(0, 256):
        pasos = 256 - tma
        if pasos == 0: continue
        
        bpm_resultante = ((freq_reloj / pasos) / tpr) * 60 / 4
        error = abs(bpm_objetivo - bpm_resultante)
        
        if error < mejor_error:
            mejor_error = error
            res = {
                "tma": tma,
                "divider": pasos,
                "bpm": round(bpm_resultante, 2),
                "error": round(error, 4)
            }

    print("\n" + "="*30)
    print(f"PARA hUGETracker (Song Settings):")
    print(f"  - Timer Clock Rate: 4096 Hz")
    print(f"  - Ticks Per Row: 12")
    print(f"  - Timer Divider: {res['divider']} <--- ESTE ES")
    print("-" * 30)
    print(f"PARA TU CÓDIGO GBDK (.c):")
    print(f"  - TMA_REG = {res['tma']};")
    print(f"  - TAC_REG = 0x04;")
    print("-" * 30)
    print(f"BPM FINAL: {res['bpm']} (Error: {res['error']})")
    print("="*30)

calcular_config_hugetracker()
