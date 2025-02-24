# strlen_neon
C/C++ strlen and memchr implementaion for ARMv7A/v8A or later CPUs, with NEON (Advanced SIMD) instruction set support.

## Benchmark

### 32-bit
```
ASUS TinkerBoard (Rockchip RK3288-C Cortex-A17 1.8 GHz, TinkerOS 2.0(Debian 9 Stretch), 32-bit)
ave             2      5      7     10     12     16     20     32     64    128    256    512   1024
strlenANSI  984.0  473.4  375.2  283.5  247.9  200.7  170.2  120.7   77.0   56.5   46.9   41.5   40.0
strlenBLOG  638.9  406.6  330.1  257.5  232.0  199.9  180.5  154.4  132.9  121.8  116.8  114.1  113.4
strlenNEON 1188.5  570.7  450.4  343.9  304.0  251.9  217.1  154.3   94.4   58.7   36.9   25.2   22.2
memchrANSI 1019.2  580.6  471.0  371.5  330.0  275.8  231.9  173.4  106.5   75.1   60.0   51.1   48.8
memchrNEON 1191.2  556.2  431.7  311.5  265.3  209.0  176.3  125.4   81.1   52.8   34.1   23.8   21.5
```

### 64-bit
```
Apple MacBook Air 2024 (Apple M3, macOS Sequoia 15.3, Apple clang version 16.0.0 (clang-1600.0.26.6))
ave             2      5      7     10     12     16     20     32     64    128    256    512   1024 
strlenANSI  382.3  156.7  105.4   69.5   58.2   42.8   33.6   21.4   11.3    6.4    3.9    2.9    2.5 
strlenBLOG  185.0   68.9   57.0   46.4   40.7   42.7   40.8   38.9   35.1   31.0   28.2   26.5   25.8 
strlenNEON  328.4  140.1  100.5   71.1   60.5   46.2   36.8   23.9   12.8    7.0    3.9    2.4    1.8 
strlenAA64   81.1   58.1   48.4   38.5   35.4   29.4   24.7   17.8   10.3    6.0    3.5    2.2    1.7 
memchrANSI  326.8  144.9  106.3   61.4   50.9   39.3   30.6   19.3   10.3    6.0    3.7    2.8    2.6 
memchrNEON  336.4  137.0   97.2   68.3   57.8   43.9   34.8   22.4   11.8    6.4    3.7    2.3    1.8 
memchrAA64  245.9   98.1   70.1   50.2   43.1   33.3   27.0   17.9    9.9    5.5    3.2    2.1    1.7 
```
