Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB025314A90
	for <linux-wpan@vger.kernel.org>; Sat, 19 Sep 2026 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853803; cv=none; b=V9NzsQphJ8bJBOKBqERhd9Hv6p+WsTOadm3eWTjy9UFfXDUHQw0j06OV5+41rHTZ7lzvdouMPKUDtu+zqWjCe4JiBV6lkGhkdHgHVOlpxjimh5QENKtSeFqssL9bmrmB2XLsRC+j+T3IGYFLyY1sGxFKnIcGAeBTvohqpjMxQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853803; c=relaxed/simple;
	bh=f4jMlkPHKrAKKCAbmRgO9SXJibE/v5rzjynGwirQG94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HP9wDOMhJpEHPoznM/hSsCsvhkmCbzspJMroC3DZwv+lc2ewcRuX7zb2OiXXDISvecXNUasK/jOokOXGdGXPGMptjfVC+e4qgp/+MME/rMPmbwNJvM+S8nLCs7BlHgLh3PGfk+Y+RXLHN4neACc2XnmcuIEiDXj9aLCOKfvr/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNZjNf6m; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNZjNf6m"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eefae4so5456955ad.0
        for <linux-wpan@vger.kernel.org>; Sat, 19 Sep 2026 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853798; x=1790458598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0F2+TaLfY1370Fmjz4vA1G1drB2ME0rZrVv4cP5FmI=;
        b=QNZjNf6mcG+sXELrLVRpcyszE/dGrRRbN/a9QzlBsKwnEVmSyWk5QEJm+vtt4IisHE
         YhkigFLKGP87K6tjTPmj5SzFUBAEHRXNaYcIC4RATYaY8fhMmMSK+4/if7CZSlMlaIsC
         2wfP5oY36GmzFqD1TTc/dw2o/yWv3ZDch092QrZEKKWBEhZpHwVPaIszJj41/EANgEYC
         eNOmaXF6vJ6UJdT3r2cQXNqF1dTOGZOIzS9oayiGop9FTSrLKz4YJMghQ2QR18nyaul7
         C0GniPEm4waO2tWd/c7JDzn3w3EwQ70UeJsF/VClmxlewZVVIUyqpC72aNGFsFApQsHh
         tOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853798; x=1790458598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0F2+TaLfY1370Fmjz4vA1G1drB2ME0rZrVv4cP5FmI=;
        b=ps/Z+fPabRDmSlNQW/cmCuifPTzuFgwJ55/luQC8Xa+cwgwX4QsT/g8HS0IP6TCTgt
         oYfiB2n5ySFT+a6wg2qK/fpkrYon4e16B0lv0zyg6mmO2tL0/JsZc/9y1H7Y4tgtb/7W
         GxhtqWlNMX3Jn8nJM6JgUz3tHiz/9aOfNaBJzVhoZVUyYhyxQwcalwnM5c3bF3iZ2T7R
         OF7SH/iMfuEkonSZz8zWCDkUpwR2u3152t1MGYZKBzUI6dGZwk1nD0IzQYqmRdkuDdvG
         hQ05quknnmonzzG3MgrFNqufjTbek7W7Ql+TzYlqYwMbz1aKgTWGJuiVNjN5tGZyOX+j
         RLEA==
X-Gm-Message-State: AFuF++myn/BIkCFLZfPVngEdgBLs2NN+DWt4JZJ5V/3afhaz2O1rHp28
	grP8jNaNsZVdvaAE89jKr1aETrOMjo+dhrxdbqCPUL6e0G/qIIsb3gF5
X-Gm-Gg: AYBFou2EZoJCYEAnAs+JVH1GHDpsjnetM8tug7CtgolkgxGYDogAlRF8Y/d94QwzWKF
	OvstQ/4+mdOM5W2LmPl0nJBVzh8dnBdv3zLU9Ptrd3nXcv/7u+u98ZZjMM4+SzKhiyQjmcwbeQG
	2yRwDM0Ikq6pRnaivlFAUCGIDuR52swmOqy1bgXr3X1bnmwfVwd8suPsCoiDmFuah+Btavx4oEe
	xJHcpedgjI4jU6YxkFdv+nEIwuYng/FTiu7BI8DDSBq/zcMRpK7Iy2ZDX6bBaJ6oK9p/golIM6/
	d3T2GxZaB+r9gnFDYaM8XVaMZcaURtcpNDHIbhGvRcgVWsEgUSd98kBshGST2Uuep4ZYqCrm9hA
	riu5L23IyYQjNGPA1Bf7my9Q782ua1G13XNUEt2IsrteyItf6IEq1tUA5haY1kVRYZHyfnAz3lB
	gGHo+X3xc7/ek8f0Me7m58KDnHuC8hChjEkkyt63RjfKhquBBfXfhKq/pPfqHTaU9Exxikbd1+D
	mXRS8TM20OjzKxuNtnqunNxk82XL5j1KPbhzhbavZUImrybAoV05a0zo4culD469uKYrAYqNxqA
	yGLoX7jlRw==
X-Received: by 2002:a17:902:f68f:b0:2dd:c100:2518 with SMTP id d9443c01a7336-2ddc1002552mr38696415ad.33.1789853797865;
        Sat, 19 Sep 2026 14:36:37 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ba48bsm12783535ad.45.2026.09.19.14.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:37 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mac802154: rx: fix beacon/mac_cmd skb leak and short skb_trim underflow
Date: Sat, 19 Sep 2026 21:36:36 +0000
Message-ID: <20260919213637.3314421-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two sk_buff handling bugs in `net/mac802154/rx.c`:

1. In `ieee802154_subif_frame()`, the `skb` passed by
   `__ieee802154_rx_handle_packet()` is already a dedicated
   `skb_clone()` owned by `ieee802154_subif_frame()` (with `skb->users
   == 1`), and all normal return paths consume it without extra
   reference increments. However, the `IEEE802154_FC_TYPE_BEACON` and
   `IEEE802154_FC_TYPE_MAC_CMD` branches call `mac_pkt->skb =
   skb_get(skb)` (incrementing `skb->users` to `2`) and return
   `NET_RX_SUCCESS`. When the worker later calls
   `kfree_skb(mac_pkt->skb)`, `skb->users` only drops from `2` to `1`,
   permanently leaking every received Beacon and MAC Command `sk_buff`.
   Assign `mac_pkt->skb = skb` directly.
2. In `ieee802154_rx()`, when `IEEE802154_HW_RX_OMIT_CKSUM` is set,
   `skb_put(skb, 2)` is called without ensuring 2 bytes of tailroom, and
   when `IEEE802154_HW_RX_OMIT_CKSUM` is not set,
   `__ieee802154_rx_handle_packet()` calls `skb_trim(skb, skb->len - 2)`
   without verifying `skb->len >= 2`. Ensure tailroom with
   `pskb_expand_head(skb, 0, 2, GFP_ATOMIC)` and drop frames shorter
   than 2 bytes.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/mac802154/rx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 19b5382e85a8..dbdaf5962ca7 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -287,7 +287,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		if (!mac_pkt)
 			goto fail;
 
-		mac_pkt->skb = skb_get(skb);
+		mac_pkt->skb = skb;
 		mac_pkt->sdata = sdata;
 		mac_pkt->page = sdata->local->scan_page;
 		mac_pkt->channel = sdata->local->scan_channel;
@@ -304,7 +304,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		if (!mac_pkt)
 			goto fail;
 
-		mac_pkt->skb = skb_get(skb);
+		mac_pkt->skb = skb;
 		mac_pkt->sdata = sdata;
 		netdev_hold(sdata->dev, &mac_pkt->dev_tracker, GFP_ATOMIC);
 		spin_lock(&sdata->local->rx_lock);
@@ -487,10 +487,15 @@ void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	 * solution because the monitor needs a crc here.
 	 */
 	if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
+		if (pskb_expand_head(skb, 0, 2, GFP_ATOMIC))
+			goto free_skb;
 		crc = crc_ccitt(0, skb->data, skb->len);
 		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
 
+	if (skb->len < 2)
+		goto free_skb;
+
 	rcu_read_lock();
 
 	ieee802154_monitors_rx(local, skb);
-- 
2.55.0.1082.g2b9226bbc0-goog

