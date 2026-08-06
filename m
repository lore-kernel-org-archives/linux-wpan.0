Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A69424D5A;
	Thu,  6 Aug 2026 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007464; cv=none; b=O3NIPDIeYLG2StjXHA0FS4susPnpYggaqwo23Yx/DM8yvxmAicDkC2C9eAjeGgvnLjaKfEfPUbYYZalsbR8dFxp3EWMBR/PinMFxeY1fp3MWngT0UtOiwvcU1IQdY0UrFKTiqPEAnHnsj0lu3U5y2K+OV3FyRbhoOz2rM7hd8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007464; c=relaxed/simple;
	bh=8s6dCWuFC+TpGJZv41eYNJKgCDWdc+b0YrdI8p9Ehcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XF42VC5J8KuXNbGVg0MGpRepyNlapR39kyq6CbfWb5hGZVBP2OpgQ9iTPhLCyKUDgeVPIxLQB//1Ae0xafE5z909LxBL5eMS7okHJ7PG8F8uq7/UxVluXVIqZOrqItoOmcxiwAIsLPX7acy1A37rCaVBoXwP/EIM1fYu+QTclcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jjM8X07y; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jjM8X07y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786007458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YapwMKwSVO2/dyW1mRwCG7PatlF3pwcpq8mLo3b37FQ=;
	b=jjM8X07yiZwdkV172nBurV6mjt7/ymYtXdjy1AAwelhbeycqpTD+t6/eiQVr5XGSkahzSP
	JwuYMeywgH65yk7qt0Cd2fl5iOPnmiToKPHsQHNc23QggeOPzETcNOu3iWUr5mKnYaZheq
	lrMq1hMHiRRctsxT13gtiFQzPfEtGS4=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: alex.aring@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net] net: 6lowpan: fix mismatched comments
Date: Thu,  6 Aug 2026 17:10:45 +0800
Message-Id: <20260806091045.1701326-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Rename @_nexthdrlen to @_hdrlen and drop stale @nhc from
lowpan_nhc_do_uncompression docs

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/6lowpan/nhc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
index ab7b4977c32b..c995029696d0 100644
--- a/net/6lowpan/nhc.h
+++ b/net/6lowpan/nhc.h
@@ -15,7 +15,7 @@
  * @__nhc: variable name of the lowpan_nhc struct.
  * @_name: const char * of common header compression name.
  * @_nexthdr: ipv6 nexthdr field for the header compression.
- * @_nexthdrlen: ipv6 nexthdr len for the reserved space.
+ * @_hdrlen: ipv6 nexthdr len for the reserved space.
  * @_id: one byte nhc id value.
  * @_idmask: one byte nhc id mask value.
  * @_uncompress: callback for uncompression call.
@@ -102,7 +102,6 @@ int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
 /**
  * lowpan_nhc_do_uncompression - calling uncompress callback for nhc
  *
- * @nhc: 6LoWPAN nhc context, get by lowpan_nhc_by_ functions.
  * @skb: skb of 6LoWPAN header, skb->data should be pointed to nhc id value.
  * @dev: netdevice for print logging information.
  * @hdr: ipv6hdr for setting nexthdr value.
-- 
2.25.1

