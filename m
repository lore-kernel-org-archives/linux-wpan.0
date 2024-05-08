Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49C84E1A
	for <linux-wpan@vger.kernel.org>; Wed,  8 May 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168464; cv=none; b=oBsahimI1QhNgMkpWd4XpR5CoAKMphk/Uubxo1AtRE7KlcjTeki/gK1R/KKFs65OpVhJGhnWfi5I+W8E6mVqQ8SFcJK3ykvaKWjGepGkPEyftPggjdb7vVatPm+LVervXhSUHZ+1J1pk/9dAYVhHRWm+lEVqL6DjGnzYlW8/1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168464; c=relaxed/simple;
	bh=c0FcHGQRj3ozRNzP95Tjb9dxfJQY4D8804gwhNHR6i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttkIKDzIzh+YAfF2/RZ1e+732jCmVIDxiPY6RNklElaU76wmdS3A8/rZY8KFatbT4sfitMXpxxhxIftjpSbNgOmZaqqIzhdqjEdbiDARr/SZmJZuu4FFIfgR/ekui/3HL/i2xfuvpuz1Yx/oyVk5dpftwlolCOsU7Hj4kihRKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=w4VS1l3f; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="w4VS1l3f"
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:c8ad:0:640:7c75:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 3E59E6090E;
	Wed,  8 May 2024 14:40:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id peXoX7XNm0U0-vdpXSm8w;
	Wed, 08 May 2024 14:40:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1715168451; bh=7wPx8SC3gQz0VhI1KDXx8JgSL8MS5SEqnzjmcs0z0U0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=w4VS1l3fQmbCyWK7PjRxAzpqXyzTLJJkHoj3HeA2A61n5nshYu1cIxXnZ9vjeuaDU
	 vPPNj7jQPSLterJ2O6kM0hcP59dqKa2WjNS/JWueK3NxgyB6iruuvi525x7eeKscDp
	 jr/0vLOkS4K7Y47FArQmlDm8f0+L3BAIUi6ZrRCY=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	linux-wpan@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] mac802154: fix time calculation in ieee802154_configure_durations()
Date: Wed,  8 May 2024 14:40:10 +0300
Message-ID: <20240508114010.219527-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'symbol_duration' of 'struct wpan_phy' is in nanoseconds but
'lifs_period' and 'sifs_period' are both in microseconds, fix time
calculation in 'ieee802154_configure_durations()' and use convenient
'NSEC_PER_USEC' in 'ieee802154_setup_wpan_phy_pib()' as well.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac802154/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 9ab7396668d2..21b7c3b280b4 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -161,8 +161,10 @@ void ieee802154_configure_durations(struct wpan_phy *phy,
 	}
 
 	phy->symbol_duration = duration;
-	phy->lifs_period = (IEEE802154_LIFS_PERIOD * phy->symbol_duration) / NSEC_PER_SEC;
-	phy->sifs_period = (IEEE802154_SIFS_PERIOD * phy->symbol_duration) / NSEC_PER_SEC;
+	phy->lifs_period =
+		(IEEE802154_LIFS_PERIOD * phy->symbol_duration) / NSEC_PER_USEC;
+	phy->sifs_period =
+		(IEEE802154_SIFS_PERIOD * phy->symbol_duration) / NSEC_PER_USEC;
 }
 EXPORT_SYMBOL(ieee802154_configure_durations);
 
@@ -184,10 +186,10 @@ static void ieee802154_setup_wpan_phy_pib(struct wpan_phy *wpan_phy)
 	 * Should be done when all drivers sets this value.
 	 */
 
-	wpan_phy->lifs_period =
-		(IEEE802154_LIFS_PERIOD * wpan_phy->symbol_duration) / 1000;
-	wpan_phy->sifs_period =
-		(IEEE802154_SIFS_PERIOD * wpan_phy->symbol_duration) / 1000;
+	wpan_phy->lifs_period =	(IEEE802154_LIFS_PERIOD *
+				 wpan_phy->symbol_duration) / NSEC_PER_USEC;
+	wpan_phy->sifs_period =	(IEEE802154_SIFS_PERIOD *
+				 wpan_phy->symbol_duration) / NSEC_PER_USEC;
 }
 
 int ieee802154_register_hw(struct ieee802154_hw *hw)
-- 
2.45.0

