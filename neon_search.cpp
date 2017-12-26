/*
    vectorized memchr and strlen implementaion for ARM with NEON, GCC4.8 or later.
	
	Copyright (C) 2016-2017 Masaki Ota. All Rights Reserved.
    
    based on: 
    	fast memchr and strlen using SSE2 for gcc 4.x / Visual Studio 2008(32bit/64bit)
     	Copyright (C) 2008 MITSUNARI Shigeo at Cybozu Labs, Inc.
    	license:new BSD license
        http://labs.cybozu.co.jp/blog/mitsunari/2008/06/fast_strlen_and_memchr_by_sse2_1.html

	How to compile this file
	g++ neon_search.cpp -O3 -fomit-frame-pointer -mfpu=neon

ASUS TinkerBoard (Rockchip RK3288-C Cortex-A17 1.8 GHz, TinkerOS 2.0(Debian 9 Stretch), 32-bit)
ave             2      5      7     10     12     16     20     32     64    128    256    512   1024
strlenANSI  984.0  473.4  375.2  283.5  247.9  200.7  170.2  120.7   77.0   56.5   46.9   41.5   40.0
strlenBLOG  638.9  406.6  330.1  257.5  232.0  199.9  180.5  154.4  132.9  121.8  116.8  114.1  113.4
strlenNEON 1188.5  570.7  450.4  343.9  304.0  251.9  217.1  154.3   94.4   58.7   36.9   25.2   22.2
memchrANSI 1019.2  580.6  471.0  371.5  330.0  275.8  231.9  173.4  106.5   75.1   60.0   51.1   48.8
memchrNEON 1191.2  556.2  431.7  311.5  265.3  209.0  176.3  125.4   81.1   52.8   34.1   23.8   21.5
*/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <memory.h>
#include <vector>

#include <arm_neon.h>
#define ALIGN(x) __attribute__((aligned(x)))

static const uint8x16_t compaction_mask = { 
    128, 64, 32, 16, 8, 4, 2, 1,
    128, 64, 32, 16, 8, 4, 2, 1,
};

inline unsigned int GetByteMask(uint8x16_t a) 
{
	uint8x16_t am = vandq_u8(a, compaction_mask);
	uint8x8_t a_sum = vpadd_u8(vget_high_u8(am), vget_low_u8(am)); 
	a_sum = vpadd_u8(a_sum, a_sum);
	a_sum = vpadd_u8(a_sum, a_sum);
	return vget_lane_u32(vreinterpret_u32_u8(a_sum), 0);
}

inline unsigned int GetByteMask2(uint8x16_t a, uint8x16_t b) 
{
	uint8x16_t am = vandq_u8(a, compaction_mask);
	uint8x16_t bm = vandq_u8(b, compaction_mask);
	uint8x8_t a_sum = vpadd_u8(vget_high_u8(am), vget_low_u8(am)); 
	uint8x8_t b_sum = vpadd_u8(vget_high_u8(bm), vget_low_u8(bm)); 
	a_sum = vpadd_u8(b_sum, a_sum);
	a_sum = vpadd_u8(a_sum, a_sum);
	return vget_lane_u32(vreinterpret_u32_u8(a_sum), 0);   
}


inline bool isFound(uint8x16_t x) 
{
	uint8x8_t xx = vorr_u8(vget_low_u8(x), vget_high_u8(x));
	return vget_lane_u64(vreinterpret_u64_u8(xx), 0);
}

inline bool isFound2(uint8x16_t a, uint8x16_t b) 
{
	return isFound(vorrq_u8(a, b));
}


void *memchrNEON(const void *ptr, int c, size_t len)
{
	const char *p = reinterpret_cast<const char*>(ptr);

	if (len >= 16) {
		uint8x16_t c16 = vdupq_n_u8(static_cast<char>(c));
		/* 16 byte alignment */
		size_t n = reinterpret_cast<size_t>(p) & 15;
		if (n > 0) {
			uint8x16_t x = *(const uint8x16_t*)&p[-n];
			uint8x16_t a = vceqq_u8(x, c16);

			unsigned long mask = GetByteMask(a) << (16 + n);
			if (mask) {
				return (void*)(p + __builtin_clz(mask));
			}
			n = 16 - n;
			len -= n;
			p += n;
		}
		while (len >= 32) {
			uint8x16_t x = *(const uint8x16_t*)&p[0];
			uint8x16_t y = *(const uint8x16_t*)&p[16];
			uint8x16_t a = vceqq_u8(x, c16);
			uint8x16_t b = vceqq_u8(y, c16);

			if (isFound2(a, b)) {
				unsigned int mask = GetByteMask2(a,b);
				return (void*)(p + __builtin_clz(mask));
			}
			len -= 32;
			p += 32;
		}
	}

	while (len > 0) {
		if (*p == c) return (void*)p;
		p++;
		len--;
	}
	return 0;
}

size_t strlenNEON(const char *p)
{
	const char *const top = p;
	uint8x16_t c16 = vdupq_n_u8(0);
	/* 16 byte alignment */
	size_t n = reinterpret_cast<size_t>(p) & 15;
	if (n > 0) {
		uint8x16_t x = *(const uint8x16_t*)&p[-n];
		uint8x16_t a = vceqq_u8(x, c16);
		unsigned long mask = GetByteMask(a) << (16 + n);
		if (mask) {
			return __builtin_clz(mask);
		}
		p += 16 - n;
	}
	assert((reinterpret_cast<size_t>(p) & 15) == 0);
	for (;;) {
		uint8x16_t x = *(const uint8x16_t*)&p[0];
		uint8x16_t a = vceqq_u8(x, c16);

		if (isFound(a)) {
 			unsigned int mask = GetByteMask(a);
			return p + __builtin_clz(mask) - top;
		}
		p += 16;
	}
}

#ifdef __GNUC__
#include <sys/time.h>
#include <stdio.h>

static inline double gettimeofday_sec() {
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return tv.tv_sec + (double) tv.tv_usec * 1e-6;
}
#else
#include <time.h>
static inline double gettimeofday_sec()
{
	return clock() / double(CLOCKS_PER_SEC);
}
#endif

struct Result {
	int hit;
	int ret;
	double time;
	Result() {}
	Result(int hit, int ret, double time) : hit(hit), ret(ret), time(time) {}
	void put() const {
		printf("ret=%d(%.1f) time= %f usec\n", ret, ret / double(hit), time);
	}
};

void createTable(char *p, size_t num, int ave)
{
	int v = 0;
	for (size_t i = 0; i < num; i++) {
		v = 1;
		p[i] = static_cast<char>(v);
		if ((rand() % ave) == 0) p[i] = 0;
	}
	p[num - 1] = 0;
}

template<typename Func>
Result test(const char *top, size_t n, size_t count)
{
	double begin = gettimeofday_sec();
	size_t ret = 0;
	int hit = 0;
	for (size_t i = 0; i < count; i++) {
		const char *p = top;
		int remain = n;
		while (remain > 0) {
			const char *q = Func::find(p, remain);
			if (q == 0) break;
			ret += q - p;
			hit++;
			remain -= q - p + 1;
			p = q + 1;
		}
	}
	return Result(hit, ret, (gettimeofday_sec() - begin) * 1e6 / count);
}

struct FstrlenANSI {
	static inline const char *find(const char *p, size_t) {
		return strlen(p) + p;
	}
};

struct FmemchrANSI {
	static inline const char *find(const char *p, size_t n) {
		return reinterpret_cast<const char*>(memchr(p, 0, n));
	}
};

struct FmemchrNEON {
	static inline const char *find(const char *p, size_t n) {
		return reinterpret_cast<const char*>(memchrNEON(p, 0, n));
	}
};

struct FstrlenNEON {
	static inline const char *find(const char *p, size_t) {
		return strlenNEON(p) + p;
	}
};

/*
	http://canonical.org/~kragen/strlen-utf8.html
*/
int my_strlen(const char *s)
{
	int i = 0;
	while (*s++) i++;
	return i;
}
struct FstrlenBLOG {
	static inline const char *find(const char *p, size_t){
		return my_strlen(p) + p;
	}
};


#define NUM_OF_ARRAY(x) (sizeof(x)/sizeof(x[0]))


int main()
{
	const size_t count = 4000;
	const size_t N = 100000;
	const int funcNum = 5;
	std::vector<char> v(N);

	typedef std::vector<Result> ResultVect;

	ResultVect rv[funcNum];

	char *begin = &v[0];

	const int aveTbl[] = { 2, 5, 7, 10, 12, 16, 20, 32, 64, 128, 256, 512, 1024 };

	for (size_t i = 0; i < NUM_OF_ARRAY(aveTbl); i++) {
		int ave = aveTbl[i];
		createTable(begin, N, ave);

		printf("test %d, %d\n", (int)i, ave);
		Result ret;
		int hit;

		puts("strlenANSI");
		ret = test<FstrlenANSI>(begin, N, count);
		ret.put();
		rv[0].push_back(ret);
		hit = ret.hit;

		puts("strlenBLOG");
		ret = test<FstrlenBLOG>(begin, N, count);
		if (ret.hit != hit) { printf("ERROR!!! ok=%d, ng=%d\n", hit, ret.hit); }
		ret.put();
		rv[1].push_back(ret);

		puts("strlenNEON");
		ret = test<FstrlenNEON>(begin, N, count);
		if (ret.hit != hit) { printf("ERROR!!! ok=%d, ng=%d\n", hit, ret.hit); }
		ret.put();
		rv[2].push_back(ret);

		puts("memchrANSI");
		ret = test<FmemchrANSI>(begin, N, count);
		if (ret.hit != hit) { printf("ERROR!!! ok=%d, ng=%d\n", hit, ret.hit); }
		ret.put();
		rv[3].push_back(ret);

		puts("memchrNEON");
		ret = test<FmemchrNEON>(begin, N, count);
		if (ret.hit != hit) { printf("ERROR!!! ok=%d, ng=%d\n", hit, ret.hit); }
		ret.put();
		rv[4].push_back(ret);

	}

	puts("end");

	printf("ave        ");
	for (size_t i = 0; i < NUM_OF_ARRAY(aveTbl); i++) {
		printf("%6d ", aveTbl[i]);
	}
	printf("\n");
	static const char nameTbl[funcNum][16] = { "strlenANSI", "strlenBLOG", "strlenNEON", "memchrANSI", "memchrNEON" };
	for (int i = 0; i < funcNum; i++) {
		printf("%s ", nameTbl[i]);
		for (size_t j = 0; j < NUM_OF_ARRAY(aveTbl); j++) {
			printf("%6.1f ", rv[i][j].time);
		}
		printf("\n");
	}
	return 0;
}
                                       

									   