Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109060;
	b=5Nv7ZQ/l0XaM84ejR08r9/5e/Vpjuq9ujH7JkUjeia0v3ypPQQ6ahjZ94nWjhQw6GKSc
	 gID3qeF1v6SQXdf5zNztCYtUzzTRl/L4Gl3JUX8sp5s6WeBJwEs+786F1ym6OrW2f8b1z
	 Lrf/vLzvfpel8dX/MorYU6TuhJ6scxFVvb79Yr8O31pJWfaCqUaIIWy7ctwaw4TYs1oyZ
	 rVmynHMZ6OLO8pY2R0pUaOllnEBhs4VUm14plky+Ype1+Fq+esf6vT+ilGmIbMtef/eL/
	 ErUaZeU+o8N6eqmMMNG+lfLEnyZpysRbEij0pDic7Xz6ObwEYIRMiG+mIVnrguZHTbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ybt3yDy2PVnBctTda6fFNeBbSLRMNED8RLSC/2nr034=;
	b=NtLYk6yaiRcllTRVn6k+Z8U3Y7zJ+1xkHbCzSgUflG6FD4v9aXL8v6pSwIChOueC9yua
	 CHDO6emB5ZDX+QPL45+WzyTLQk0clsWyNS76W/2462AQYVlEfuD6hF52UWQ1waiFg6icn
	 o1QzKI5Drrs3UHpHSI0w4De+vI2ZmOotEitE9nt+SO3a3pJLALpQfFvZjChYBz6X+vQBC
	 57dnq/Uwjb3gGit5uTy+RTaR/vVESdIwxPCYVJaLzTh1YFQY9YCDdVdaAY22yAhafG2dw
	 rituXXxfneejRx/Rcaw9EkRkQxFdwG3xRvffDlxRmg/a+dHvtT47B6zO04W6Wt2z2dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=jD9NsWHE;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7622606A324
	for <linux-wpan@vger.kernel.org>; Thu, 19 Nov 2026 17:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7622606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=jD9NsWHE
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so28008825e9.2
        for <linux-wpan@vger.kernel.org>; Thu, 19 Nov 2026 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795109058; x=1795713858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ybt3yDy2PVnBctTda6fFNeBbSLRMNED8RLSC/2nr034=;
        b=jD9NsWHEcpatdmkdARhiuKvJF8rOijuHu4QsWe5pwXO/hCwFJt23oZzBSkW3RxE3ez
         HDXmr6cRmfsFwFAy8r5Gefm4/JTb+2WilSA9p9UYjvMupIOWW1BllrzQEBEzdPIpMkYa
         nsfL0+2xw5a48YGHj/+hdypYNNqC7vSWdCFI9Qul2FiDvBK/Pho/QdDVUQT2EXExT3EW
         0X2SSGfyKL4Jkka9NRhr087wMg13s/LtvgdBfHGc5GsHxeU+emJgMhKeL5rvyCcxEubZ
         C3REhaiwrUacIb5LugvECbYId2qVh99ulNcHvTXm4iuN/eHRaxfANYmx8W+w3CtthPW9
         l2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795109058; x=1795713858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ybt3yDy2PVnBctTda6fFNeBbSLRMNED8RLSC/2nr034=;
        b=bjR8FFzmSEttCWs5LtyIZuBQAbyj0ys6gbZBa5qy7c3j4Z2Od4fpH9sYUF4/gtImFD
         ryvQNCaSwS8AHiDNJqKcUeH0JLlo97uTrr08KpfMt2U8DQrb4v7ZQh1DyVFLkVo/3pbR
         /0kUM9bZDEJTJdM/DIuE8V0kHc2MKKguAr0OLexzCf6x+7OsCOxwvOV2OLyy4iDDcacp
         FMUEsb3QDn9aDnXABx/yF9oILcQOvuf4VgtUj4IiLlEAPXbHzlKhRJmdojv5XIdGQwsd
         HybdVmDB3B4Xx1MpzgQw3TK4zyrzRxcKNSA7fDDmIlYp9P8XvmRWXWv2swmYLdHQtCdB
         LnnQ==
X-Gm-Message-State: APuU4Z/5PMHzHZMkIpBc6/9ZuFFxcd5z1Vd9or2lEvueSFtny1w5UXtU
	HNAQiL3tv/CQ4XpHVn8DrIXGzBQGFDMpkURep5SAoKjRwYDRor5gW7wwCXO/nDPuOXg=
X-Gm-Gg: AYBFou0T0ghj9T2CyCkjUrn1czPr4Pyih64MImjxucf2NAqk1WZn8hK2IjJyVRcHxXi
	NAp4h60eLPl94m7wEGed5y+ohIcBE+CU9qr5M5sPMh/o4/sInDyp6wfthnjbBrcYsqqelmly9AP
	zKKKkurs2NZZhAe2cTSjMEMAOB/xSSgopWFTtlvjlPJcrAd4Wjf8TGzQilitf7EXTIjpg/PcFF5
	IMSNZq5n/L6Lg14gjP4FEih7npRO1J7KanpZpvSGznPkA9vbPcw46fUIWrNbECG2qNppfIEadjp
	U/84+jdnyTo5I/DBtqJ8EhP9/6ZEt8rhmPAf3Hvctj+Xdvcx1Lbg/5y9oQlplOSZbYyCXhZ8FN0
	HwO0FMzdpGICMfdAT9isuvC03tvfcMZfZON4AYB1O9k0/zvsRuq7dnJ1pZqAWPhHxf+7WshCQRo
	VvFnTTOYNxv7SkunyBBakR43MHNoSAHFphjJQPX0amt1vcdbX5ASO1rN5CWS5l0Z5clWXvQc4t+
	nfYsnaWFx5p3JU+EK52eKw72qAeAosR5SAVQxz7Vz4l5UGScrvkNPi/ua9/Jg9s/lJG563DPe25
	VbrO5R58kIIxqdZPm17vOVLd
X-Received: by 2002:a05:600c:34c9:b0:4a3:5d64:df91 with SMTP id 5b1f17b1804b1-4bb88810d28mr4268105e9.18.1795109057952;
        Thu, 19 Nov 2026 09:24:17 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm17951085e9.14.2026.11.19.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:24:17 -0800 (PST)
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
	Andrey Misiurov <amisiurov@cloudlinux.com>
Subject: [PATCH net] ieee802154: keep the original error after a netns rollback
Date: Thu, 19 Nov 2026 18:24:13 +0100
Message-ID: <20261119172413.2068073-1-amisiurov@cloudlinux.com>
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

Keep the original error in a separate variable and return that.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
Found during a backport review.

On debian13 6.12.88, "iwpan phy phy0 set netns name T" reported success
(returned 0) while phy0 and its wpan0 interface stayed in the original
namespace; internally the move had failed with -EEXIST, but the function
returned 0 anyway. With the fix the same command correctly fails
with "File exists".

 net/ieee802154/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -222,6 +222,7 @@
 {
 	struct wpan_dev *wpan_dev;
 	int err = 0;
+	int ret;
 
 	list_for_each_entry(wpan_dev, &rdev->wpan_dev_list, list) {
 		if (!wpan_dev->netdev)
@@ -249,6 +250,7 @@
 	return 0;
 
 errout:
+	ret = err;
 	/* failed -- clean up to old netns */
 	net = wpan_phy_net(&rdev->wpan_phy);
 
@@ -264,7 +266,7 @@
 		wpan_dev->netdev->netns_immutable = true;
 	}
 
-	return err;
+	return ret;
 }
 
 void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
