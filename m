Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FEA40DFA7;
	Tue,  5 May 2026 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986105; cv=none; b=OxWw/kouaP1F6/UCeLtSq1Ft5RVwDgNdnpkwqRAsBmjbJDNb+TjKQUqJ+Z21SbyX+bxOCcOsYHsEohbN6CeHtjma5VAfF9M/iI6DsS7GfaRdTS7ZXu7nqCidGpoEm2vJkZ09+QX5qrjei7daF6s0S9m8FSaE2fYif0nmAZkHcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986105; c=relaxed/simple;
	bh=MxhEpN0uqJq2tCB7cr3hxj4eDiQbli3EAh40AyItXnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BND+cf/qeKMCEIbIidqeisIAttLgsEQsvuBEKbA94OS96o8K7CFZjuReADOLvkCfMjv7cZl6ItURk2q+zHSgAUaJMrTF1ZT1Lb5+MMjPSV+VpiJCgnhZxCQ32+tZJVVgqkHbH9fRnpeMdqHnW88G9hPlIUm3p1207vb39CWaOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3olMDa8X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3olMDa8X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IIY91kLlEleq6plR14V65czQR3JFpr8yElhtwpNztiI=; b=3olMDa8XCZi/Uwg3KdaFc5w/tp
	oxhdQZkGoKbsx7qVwCLAVjDYGzjJB1Lz6/HJNU1Z2gvL/ajjM9t6VRYq8nUxIuaFa/bJyDgpeto+b
	0LhkVCZIMcqrnVznD9mPWUiu5A23g7w4pgzBNyLwZeHTSByYNHNgNNjZeamR9btaCfo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKFP7-001Sep-PE; Tue, 05 May 2026 15:01:37 +0200
Date: Tue, 5 May 2026 15:01:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com
Subject: Re: Vulnerability Report: Logical Error in 6LoWPAN Multicast Context
 Address Compression
Message-ID: <003a541e-2e74-4ab1-9002-92a17e78362e@lunn.ch>
References: <15e69058-da2e-4a4d-8bda-ad89da0ae6f7@std.uestc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e69058-da2e-4a4d-8bda-ad89da0ae6f7@std.uestc.edu.cn>

On Tue, May 05, 2026 at 05:18:34PM +0800, Quan Sun wrote:
> ## 1. Summary
> A logical vulnerability exists in the 6LoWPAN IPHC (IP Header Compression)
> subsystem of the Linux kernel, specifically within the
> `lowpan_iphc_mcast_ctx_addr_compress` function in `net/6lowpan/iphc.c`.
> 
> The function uses incorrect memory offsets during the `memcpy` operations
> intended to compress an IPv6 multicast address. This mismatch in offsets
> results in an incorrectly formed compressed address being transmitted over
> the network, which is incompatible with the corresponding decompression
> logic. Consequently, context-based multicast address compression in 6LoWPAN
> is broken and fails to operate as defined by the protocol.
> 
> ## 2. Vulnerability Details
> 
> According to 6LoWPAN address compression standards (and aligning with the
> decompression function `lowpan_uncompress_multicast_ctx_daddr`), a
> context-based compressed multicast address should be represented by exactly
> 6 bytes:
> *   **Bytes 0-1:** Derived from `s6_addr[1]` and `s6_addr[2]` (Flags, Scope,
> and Reserved bits).
> *   **Bytes 2-5:** Derived from `s6_addr[12]` to `s6_addr[15]` (The 4-byte
> Group ID).
> 
> However, in the compression function `lowpan_iphc_mcast_ctx_addr_compress`,
> the offsets provided to the `memcpy` calls are flawed:
> 
> ```c
> static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 **hc_ptr,
> 					      const struct lowpan_iphc_ctx *ctx,
> 					      const struct in6_addr *ipaddr)
> {
> 	u8 data[6];
> 
> 	/* flags/scope, reserved (RIID) */
> 	memcpy(data, &ipaddr->s6_addr[1], 2);
> 	/* group ID */
> 	memcpy(&data[1], &ipaddr->s6_addr[11], 4);
> 	lowpan_push_hc_data(hc_ptr, data, 6);
> 
> 	return LOWPAN_IPHC_DAM_00;
> }
> ```
> 
> ### Analysis of the Error:
> 1.  **Incorrect Destination Offset:** The second `memcpy` writes to
> `&data[1]` instead of `&data[2]`. This overwrites the byte previously copied
> from `s6_addr[2]` into `data[1]`.
> 2.  **Incorrect Source Offset:** The source address is specified as
> `&ipaddr->s6_addr[11]` instead of `&ipaddr->s6_addr[12]`. This means it
> begins reading from the last byte of the network prefix rather than the
> start of the 4-byte Group ID.
> 
> Because the compression formatting does not match the expected structure
> required by the decompression function, multicast packets utilizing
> context-based compression will be corrupted upon transmission.
> 
> ## 3. Impact
> This vulnerability breaks the Context-Based Multicast Address Compression
> feature (`LOWPAN_IPHC_DAM_00` when `M` and `DAC` bits are set) in 6LoWPAN
> networks. Nodes receiving these packets will incorrectly decompress the
> destination multicast address, leading to dropped packets and communication
> failures within the multicast group.
> 
> ## 4. Suggested Fix
> The fix requires adjusting both the destination and source offsets in the
> second `memcpy` call to correctly place the 4-byte Group ID into the
> compressed `data` buffer.
> 
> ### Proposed Patch:
> 
> ```diff
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -1084,9 +1084,9 @@ static u8 lowpan_iphc_mcast_ctx_addr_compress(u8
> **hc_ptr,
>  	u8 data[6];
> 
>  	/* flags/scope, reserved (RIID) */
>  	memcpy(data, &ipaddr->s6_addr[1], 2);
>  	/* group ID */
> -	memcpy(&data[1], &ipaddr->s6_addr[11], 4);
> +	memcpy(&data[2], &ipaddr->s6_addr[12], 4);
>  	lowpan_push_hc_data(hc_ptr, data, 6);
> 
>  	return LOWPAN_IPHC_DAM_00;
>  }

Since you have a fix, why not just submit a proper patch in the usual
way?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
https://docs.kernel.org/process/submitting-patches.html

    Andrew

---
pw-bot: cr

