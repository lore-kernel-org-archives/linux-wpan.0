Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9B2DB7BA;
	Tue,  5 May 2026 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972725; cv=none; b=TqPNLdVxItGC9r6Z8RYXL112BQ1FYVDeuP2rvZ/wljtqX1zhjamQ+0N5xrSqDbPAUBZKOqkaaEMSEgsjqOjpV4jBPfSLto6OuOPIy9riZJPq9xyhjqduuSCdzGUbeCxFTA420r//z133ntIyYjEyVsRJZrSXYqFwcnrl4uK9f8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972725; c=relaxed/simple;
	bh=9SNRQ96W42J5zCIfhW/YTNFrj8QMT4xG0K9xiri0yyk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=kXj1kH0yJ8pN6G1vbdkhfKhB+9ddAePj96p5rDBw1lm/JbXvFSEirrPix3S3Kze28dz3yQs62xRc1iOD2dJLb+oX2Ydim/BOMPVhQBczL9K7641QFPpGlK+vnZtEMUbBw634aoa8QUecXQLoLK2uqWDhsQ1jtyLhgOIXCUF+1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=GXdQ65Ke reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="GXdQ65Ke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:From:Subject:To:Cc:Content-Type:
	Content-Transfer-Encoding; bh=/aXJtrqXl1XXzWhV4If7NN+Y9lfxYLoMa8
	LrVHQmIl4=; b=GXdQ65KeeOgnfYw5ErQfYJDXjNoCQzg3VAQomD+LEar6YFvn9E
	s3YQRdvIGFrClymYqjfS9zA+BYJLpXlbDdoG4e+yaX0KOY01fB3xEyE+9lCUAcBz
	aoyrmnOH8V6e5L75BEZDAdfiFPhrN5elOkaJ0NXYaRrDll7fu4LZn4kfA=
Received: from [IPV6:240c:c983:9:4350:6499:1928:c2e4:4a99] (unknown [240c:c983:9:4350:6499:1928:c2e4:4a99])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkD2GjXqtflpMevqAQ--.45991S3;
	Tue, 05 May 2026 17:18:37 +0800 (CST)
Message-ID: <15e69058-da2e-4a4d-8bda-ad89da0ae6f7@std.uestc.edu.cn>
Date: Tue, 5 May 2026 17:18:34 +0800
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: Vulnerability Report: Logical Error in 6LoWPAN Multicast Context
 Address Compression
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkD2GjXqtflpMevqAQ--.45991S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4xAryUtw4xWryfGF15Arb_yoW5uF4Dpr
	WrG39Yyr97Xr13A3yvyr4v9r1xZrs5tr1UKry8C3s09a1Ygr1IvF4DKFy8Aa45Ar1ru34q
	vw4Uu398AwsIkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x07boE_iUUUUU=
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/

## 1. Summary
A logical vulnerability exists in the 6LoWPAN IPHC (IP Header 
Compression) subsystem of the Linux kernel, specifically within the 
`lowpan_iphc_mcast_ctx_addr_compress` function in `net/6lowpan/iphc.c`.

The function uses incorrect memory offsets during the `memcpy` 
operations intended to compress an IPv6 multicast address. This mismatch 
in offsets results in an incorrectly formed compressed address being 
transmitted over the network, which is incompatible with the 
corresponding decompression logic. Consequently, context-based multicast 
address compression in 6LoWPAN is broken and fails to operate as defined 
by the protocol.

## 2. Vulnerability Details

According to 6LoWPAN address compression standards (and aligning with 
the decompression function `lowpan_uncompress_multicast_ctx_daddr`), a 
context-based compressed multicast address should be represented by 
exactly 6 bytes:
*   **Bytes 0-1:** Derived from `s6_addr[1]` and `s6_addr[2]` (Flags, 
Scope, and Reserved bits).
*   **Bytes 2-5:** Derived from `s6_addr[12]` to `s6_addr[15]` (The 
4-byte Group ID).

However, in the compression function 
`lowpan_iphc_mcast_ctx_addr_compress`, the offsets provided to the 
`memcpy` calls are flawed:

```c
static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 **hc_ptr,
					      const struct lowpan_iphc_ctx *ctx,
					      const struct in6_addr *ipaddr)
{
	u8 data[6];

	/* flags/scope, reserved (RIID) */
	memcpy(data, &ipaddr->s6_addr[1], 2);
	/* group ID */
	memcpy(&data[1], &ipaddr->s6_addr[11], 4);
	lowpan_push_hc_data(hc_ptr, data, 6);

	return LOWPAN_IPHC_DAM_00;
}
```

### Analysis of the Error:
1.  **Incorrect Destination Offset:** The second `memcpy` writes to 
`&data[1]` instead of `&data[2]`. This overwrites the byte previously 
copied from `s6_addr[2]` into `data[1]`.
2.  **Incorrect Source Offset:** The source address is specified as 
`&ipaddr->s6_addr[11]` instead of `&ipaddr->s6_addr[12]`. This means it 
begins reading from the last byte of the network prefix rather than the 
start of the 4-byte Group ID.

Because the compression formatting does not match the expected structure 
required by the decompression function, multicast packets utilizing 
context-based compression will be corrupted upon transmission.

## 3. Impact
This vulnerability breaks the Context-Based Multicast Address 
Compression feature (`LOWPAN_IPHC_DAM_00` when `M` and `DAC` bits are 
set) in 6LoWPAN networks. Nodes receiving these packets will incorrectly 
decompress the destination multicast address, leading to dropped packets 
and communication failures within the multicast group.

## 4. Suggested Fix
The fix requires adjusting both the destination and source offsets in 
the second `memcpy` call to correctly place the 4-byte Group ID into the 
compressed `data` buffer.

### Proposed Patch:

```diff
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1084,9 +1084,9 @@ static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 
**hc_ptr,
  	u8 data[6];

  	/* flags/scope, reserved (RIID) */
  	memcpy(data, &ipaddr->s6_addr[1], 2);
  	/* group ID */
-	memcpy(&data[1], &ipaddr->s6_addr[11], 4);
+	memcpy(&data[2], &ipaddr->s6_addr[12], 4);
  	lowpan_push_hc_data(hc_ptr, data, 6);

  	return LOWPAN_IPHC_DAM_00;
  }
```

