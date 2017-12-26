# strlen_neon
C/C++ strlen and memchr implementaion for Raspberry Pi 3, ASUS Tinker Board, and Other ARM devices with NEON (Advanced SIMD) instruction support.

## Benchmark
```
ASUS TinkerBoard (Rockchip RK3288-C Cortex-A17 1.8 GHz, TinkerOS 2.0(Debian 9 Stretch), 32-bit)
ave             2      5      7     10     12     16     20     32     64    128    256    512   1024
strlenANSI  984.0  473.4  375.2  283.5  247.9  200.7  170.2  120.7   77.0   56.5   46.9   41.5   40.0
strlenBLOG  638.9  406.6  330.1  257.5  232.0  199.9  180.5  154.4  132.9  121.8  116.8  114.1  113.4
strlenNEON 1188.5  570.7  450.4  343.9  304.0  251.9  217.1  154.3   94.4   58.7   36.9   25.2   22.2
memchrANSI 1019.2  580.6  471.0  371.5  330.0  275.8  231.9  173.4  106.5   75.1   60.0   51.1   48.8
memchrNEON 1191.2  556.2  431.7  311.5  265.3  209.0  176.3  125.4   81.1   52.8   34.1   23.8   21.5
```
