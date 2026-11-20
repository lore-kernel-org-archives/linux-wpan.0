Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157882;
	b=2OXkAFlkhX7J+pzjhuZsp69URympf25+VRq5/GXYEUgdonZ3ACO0oOgPxGf62x0GrtE7
	 ey9Dyr1tOy0fc4zBLytI41MpbzprHH5hfj/Qdlxdt5VDftPMsHCRiRBrCRyfL7qt77AqB
	 DUvYsHh+slJcBDpwhzspS6zLUa+O/+OcE+AJpY1gu36iPnBW0uzFr/T9OCEYz09xkvPme
	 f9RLB7BqhhyL7yKNA4UZRulpe7Xk+4Dn9VrHUH7293oixbyvtmqvwLC3PXv8PEnj0hZ2z
	 ZKEs/S1Z44Xm9Yy8wvBPauf6IrS9MyK7SfdVTbyTKM69V0wK8Op3tMe7qlwWavP7Kyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZVpa8bveNQUoF8hBZFsntHBuieSxDrBoOl7r8tSBYPM=;
	b=uWG30qLIS5/R08UbIQYR/qp1SGsdv/oBs5mYSBH6V5g6YJPu7dAUtxinutNKjmv1H4hA
	 VShRjRUlUImpNw2nIQbXb03/YCo2/j30ws8gypuDcyBQWBWT1gqwiAdx7ae96Gc0x+IVX
	 z5Eau0+DPaHHCdGDujR8Jm1/XrtbT/uZI4urM1w4gopTzktnwPEc+uv9axVgtAdhBscRj
	 912sNkV4lLFGPsIOAQafYl/o/15aOU5NuXh2ARGJboCOEUA/V/T2szKTLPuvoae2/fShr
	 /Jy/P6YfZd0x+Tpq9Rqw5ZUSBOd1OjBJ8W/H1GP2GQCmk5yWxuCo7uguOseYQa97mDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=Fqs2Lawh;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED3606A320
	for <linux-wpan@vger.kernel.org>; Fri, 20 Nov 2026 06:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04ED3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=Fqs2Lawh
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso208199f8f.2
        for <linux-wpan@vger.kernel.org>; Thu, 19 Nov 2026 22:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795157880; x=1795762680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZVpa8bveNQUoF8hBZFsntHBuieSxDrBoOl7r8tSBYPM=;
        b=Fqs2LawhrfmjHFt0TwOTf/b3Avrczi1UW+HtHVl1gfPi8kos949p1mvwnoq9jkGCET
         Nq86gGhLMStvAAPMJJU1tp5JHbW2PbN+OqSeXSpKvSM3q9ugrK7Re2JMUG/+Q9NroZGI
         HQoayp/xpu1ibdlH1xf4HCPIfVSr+c05dsTZkYQX00OsV9/V8XULu/KTBpaT/zj32/yu
         GXKzTSpTYQHDXN/XgilgvwyEmx/iJgLTYohJvZ8Cp8jM7lV7Ixt6nsx6+eBRZiBxKhbj
         26JWqfKh2KnvalYsiggZYpsgjcL8gF2CAjBJ8jiWLGjX+5qTmy+m9iVun94S7ykqm1KT
         tOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157880; x=1795762680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVpa8bveNQUoF8hBZFsntHBuieSxDrBoOl7r8tSBYPM=;
        b=iykXDfgorYGyQT8PgGJ87GtXqpu6w7m8hw+sf2Pic8xMmX5F0bykNlngmWjOo5XwtI
         x1HuBf3YRbDIjKY1dyJYgjrPbxuDQ9IW8A8H4VHfzwa11UL28LALG7EYQKcpmV/T7S4r
         D5wvw1G3IuShMe/qFIsSRSpcBQUHOgvPfCFy+E0y6edneC+GIDmxSMDeE6cezy9tR8fE
         UbghtEJWqSJ6oNkFbhKUT1ZFz/C0D5jCHOAoW/Pq//o1cD/49ZuOao+NQL2keS6oTnZ+
         YBHaJ2fugkhQcm2b8Rf+8FQw+qecmCUy/jvqrGdJDHRapwD8UYS/Oi5FI0y6n15ld2bf
         /d2w==
X-Gm-Message-State: APuU4Z/A5YEvXngwd9kpEA12aqp31cELw+jMMBEhaI1eGIVpCc9qviCL
	PylQIcUf+lVE5Jbd+H1txXMEeqcIIG/IbDJzv5fLSsTo1vFP3ovf49I73V3JyTrra9w=
X-Gm-Gg: AZFdTZfboux2aKvhGL/Gh1+Hma57m3Rl4MWJyBa6vvPaRbCTnjP9R9AGNArUMRsFst0
	L+PftuSou1M38G6KuPuvD7nFhDAVMweih2EoiMA133pOTkgHI+iwtO1zdmg8bE6UQsXScmb0XXF
	jpEQi2b5cYJN6ZW7WzcB9FiVg1mMt/TxIlcNzoTv70l5UPYLxPZqfm9i7F9m6JfW2yaZzIK3VX/
	mY43bTCGclWVNLqHPzK6gbfxzg6Ov6j5IS4tSxEtc4BE4ec1/ASihgl8SZmPZRWq6Xtoamaa5Rq
	EOUfb8IqDiIU9ZVnIdjhykkLtWAYmZrIHQyHDIS6cgHdBdUQUhxFKleNYzvWk9as8OBllZnP3/G
	2v0KdGmTuM3ASuW335sThz0bIQIzqT7wniJFos6bd75HrbatG47fJN9jdI/GgWaCgI3a7miHsE4
	7jPx60oA/c7NB5yEWxM7wcTLKO/pKkLfWqLZFl5TownexDDyL+5rkZ2o8zgpE+aH12INrIgERdw
	1qCRRnN+hbX2gUbxA+fVE8hEFy02o4hlmVhxmGvJCaTqVVUSWtp5ralo6awxQuHcBbY/BjBSTfw
	jxu9AQj963JAvg0dEBpixtuNPCjuQTiYBOB0Q/3vbIci7A==
X-Received: by 2002:a05:6000:2c13:b0:48d:f95e:6e8 with SMTP id ffacd0b85a97d-4abab02d26emr3388137f8f.1.1795157880406;
        Thu, 19 Nov 2026 22:58:00 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm4190080f8f.21.2026.11.19.22.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:57:59 -0800 (PST)
From: Andrey Misiurov <amisiurov@cloudlinux.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	amisiurov@cloudlinux.com
Subject: [PATCH net v2] ieee802154: keep the original error after a netns rollback
Date: Fri, 20 Nov 2026 07:57:49 +0100
Message-ID: <20261120065750.3274661-1-amisiurov@cloudlinux.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cfg802154_switch_netns() moves all of a phy's netdevs into a new netns. If
one move fails, it jumps to the errout label and moves the already-moved
netdevs back to the old netns.

That rollback loop overwrites the same 'err' variable with the result of
each move-back. The move-backs succeed, so 'err' ends up 0 and the function
returns 0 -- success -- even though nothing moved and the phy stayed in the
old netns. nl802154_wpan_phy_netns() then tells userspace the move worked.

Give the rollback loop its own 'err' so the original error survives and is
returned.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
v2: shadow 'err' inside the rollback loop instead of adding a separate
    variable next to it (Miquel Raynal).

Found during a backport review.

On debian13 6.12.88, "iwpan phy phy0 set netns name T" reported success
(returned 0) while phy0 and its wpan0 interface stayed in the original
namespace; internally the move had failed with -EEXIST, but the function
returned 0 anyway. With the fix the same command correctly fails
with "File exists".

 net/ieee802154/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -255,6 +255,8 @@ errout:
 	list_for_each_entry_continue_reverse(wpan_dev,
 					     &rdev->wpan_dev_list,
 					     list) {
+		int err;
+
 		if (!wpan_dev->netdev)
 			continue;
 		wpan_dev->netdev->netns_immutable = false;
