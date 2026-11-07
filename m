Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068844;
	b=0tATdOABuP9+fVsm2qJC4GWY4qt6ThMDTvXS4qrRJL2CcEDT6ROHB3TEce2bWHvVCb0A
	 TclvRBKMwjV3qkOPS818C6NqKbmkk0kft3rDdvSHqCMykNxDXMYJmElYNT33yT8YX2+qW
	 tEOE8DL+Zmymg/a/RVwVfIFJil++d+pHNcmeXf7lJeFvC7moY0tVOyPwvIKg+CFpm9Tau
	 W2jeNkKRHFUmmGigzTDEBRQFExJtre4lCZtFN1Ljnf3hsPUxCUn/O+GjgNhsP1GlMm23W
	 WN5pCwFW+bhFzJKo1TYY8noAZZtFIhbDxFfR2rsCOkca+rdV0QRHQXaKyHgSFUUkvjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8iDgo6XjJcvB5XRw1w2M3oqlB25XsiQDubeqinQmBrM=;
	b=aDjWyiVgqKtFm6Ph6Rd6WWNYr2utrAQMy74fyamUUjNX7vQKHUpVj89q1qL94J0V83GT
	 gvDmI/C8qIGBFJw9NNdgzd6OOqlhDc60pQOfROb9rBek8tXq98hR8bBBAV/TGv6iNmnRK
	 aSyR8ybV2H1hT+zm16pW+62Ig4t+u+mj7D5ZQPqyJtVjy520EpidWzOKmxP/3F2TFAsp7
	 u5vE7d0prcLF2e50HQOlhXrnUJjPe79LGxwl5LzLZfikisbJmyHHazzh78VpnRzNfVt0s
	 Fc5jl4IQqiV+EpAs0WmbppYL5HAVE8GQHTIE5VI2NDrEt5ftVo39gEdVFe4mnMZ2lVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wWDsj2Cw;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF6606A32C
	for <linux-wpan@vger.kernel.org>; Sat,  7 Nov 2026 16:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBAF6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wWDsj2Cw
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b244fb7fffso2359964c88.1
        for <linux-wpan@vger.kernel.org>; Sat, 07 Nov 2026 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068843; x=1794673643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8iDgo6XjJcvB5XRw1w2M3oqlB25XsiQDubeqinQmBrM=;
        b=wWDsj2CwAZa7+glxJkIliQdsvFrzUPRaa+1MfUK/l/CTx/1bu8Qat8tT551GBRkT6V
         9uzHPdIZT2bVCs3gRP7FmiLWPavC25Ktm/6kv/N74t6mzjCHOzFbJIO9WpPrXpkjyyHH
         CzOPIJEQ6RITHqe2bp4t9SZD4+KuXhajqA6LLK0SEMbPQ3N9+LNmQwai9NfbYJ7rLK5G
         XWAzre+3+3ZoQ+nuvhW6bzT1BWtmQes4eigvar3t6cTk41KYmM0nA09LOcCuzKliR7ae
         3AlRjHCiJrNbFOj31v5TOoZqjnz0Ju4WJCc+VJuGhJznnZIY+LLRgXrHI7+D28Tgea5r
         rPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068843; x=1794673643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iDgo6XjJcvB5XRw1w2M3oqlB25XsiQDubeqinQmBrM=;
        b=OrOCgFHD5/aDj3Q7zBXHi/OZqubPDI4UpQzIE41205nekwdelPbqlb3RAYtR226oM2
         e34m21EbDj0NyZ3S00l0u7LsoxE2k2jewMX+L8O+r2hdT68uRq66C++AL38nfHBlOXQB
         /lPgge1+YdeapFnUpiQCnXMHU/fr0cgB98uBkIfy7FByAXrzmi4ptJKK1cIrTzrtZLys
         FToj0KL6l8a6bKuJP8rvqqTbEuRNU2siWSdbF5iCyL7zY3Ady4LGibhbEioLn8bnyYnE
         vgkKczmbPmJ96NGeAI8rRn9CXRWhW6Ojj+auQDrWAt+muZqY5NkZyMQtC8zJ9Mr40kDS
         3K4g==
X-Forwarded-Encrypted: i=1; AKwUvBxa6w8SrCnR+B4wsF5O6MvFURgNHnvpnYTCahQoTAu9tkNdytcy0nW32yvG4SGKGsmS/Rlz4riDgsal@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZlQ2uG4RiBLN1tqv0I4bnQEPNWeHvKsYRoXD9fswaDiyBqpJp
	VVNs0rAq5mlOjDAwUDBpCCZKhSlk7E1RQSo5BsC8lQcDDRXaBA4ZnhiP
X-Gm-Gg: AYBFou2gq78Ch2CaoUbBvk77AKQeqwBVUls2YLm0xKCNfnM+CYUErAWyz0N1cZpuwgf
	Q/giPLDCy9MNnStj42KRms5E1s/K8xPXQTLQ3DeRmppAR0nOHCkIyKogKG6eVWunT/b1RP7Aupd
	HDmysVdNQIm5WKdd8jqFE0lZYouzDgH9eItbUqrfcS03ecFuB3WVSn1OfWCA7xncT06Le1zSabw
	b9cVeSzLbto8D/DVOKtwq+dQae6Ng95Yp0ZXUXHwPOIQBlPrqtHLgZzTedoxz23zTvm0Cjtnmme
	fkVkUD/rf3TeV9j/HIi8VZuYTjgGYNf6/SuFEZREXmoUruVd0ej362GZ3URHrOhEnnhzc/9AgCB
	hcmlBWyaeFx1RXPUz+qkG5h7QGAQWvtTQzaOxm2lVwCd46wntXk9ivHpT/3LA7QM76RfJXZj7N2
	w02Eo0IjZ1TNwqagHJG5hZf9IteE4x2w876Wz9kdfXmrdQb2odm/U8eAnAOiedFai4GSHC3i9tZ
	Z7YK33EfD1uaOzgQ1/qZ/vuKPRuOcocaSFFCLFwugMiMqP637oEYM5g77edDsyov/PbobwvBWCN
	f6GzzL31p8GthkFrQ1JpF+5fqoFKh7IY/2/BBfg=
X-Received: by 2002:a05:7022:29b:b0:159:aa67:28c1 with SMTP id a92af1059eb24-1b25d3499f8mr6609198c88.20.1794068842773;
        Sat, 07 Nov 2026 08:27:22 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm29025370eec.15.2026.11.07.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:27:21 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew+netdev@lunn.ch,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH net v3] tun: disallow setting IEEE 802.15.4 and 6LoWPAN link types via TUNSETLINK
Date: Sat,  7 Nov 2026 21:56:49 +0530
Message-ID: <20261107162649.282982-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A userspace application can set the link type of a TUN/TAP interface
to ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, or ARPHRD_6LOWPAN
via ioctl(fd, TUNSETLINK, arg) because tun_get_addr_len() explicitly
recognized these types.

However, TUN devices cannot function as genuine IEEE 802.15.4 or 6LoWPAN
interfaces:

1. They lack wpan_phy, channels, PAN IDs, and MLME operations, and tun
   never initializes dev->ieee802154_ptr or dev->ml_priv. When an
   unprivileged user creates a TUN interface in a user+net namespace,
   changes its link type to ARPHRD_IEEE802154, and issues a netlink dump
   request (such as IEEE802154_LLSEC_LIST_KEY),
   ieee802154_llsec_dump_table() unconditionally dereferences
   dev->ieee802154_ptr / ieee802154_mlme_ops(dev), triggering a supervisor
   null-pointer dereference / general protection fault. Similar
   dereferences occur across net/ieee802154/nl-phy.c (ieee802154_del_iface)
   and net/ieee802154/socket.c.

2. Similarly, the 6LoWPAN subsystem assumes via lowpan_dev(dev) that
   netdev_priv(dev) is struct lowpan_dev. On a TUN device, netdev_priv(dev)
   is struct tun_struct. On netdev events (such as NETDEV_DOWN in
   net/6lowpan/core.c:lowpan_device_event), it clears bits in
   lowpan_dev(dev)->ctx.table flags, which corrupts private memory inside
   tun_struct.

Rather than scattering checks across subsystems, fix the issue at the
source: disallow setting ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, and
ARPHRD_6LOWPAN via TUNSETLINK by returning -EINVAL.

Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK processing")
Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
v2 -> v3:
- Include ARPHRD_6LOWPAN alongside ARPHRD_IEEE802154 as agreed with Willem
  de Bruijn, preventing Sashiko AI flags and addressing the underlying
  lowpan_dev(dev) memory corruption.
- Minimize code churn as advised by Willem de Bruijn: drop unrelated
  USHRT_MAX check and preserve tun_get_addr_len(), headers, and existing
  block indentation.
- Fresh standalone thread as advised by Jakub Kicinski.
- Link to v1 and v2 discussion:
  https://lore.kernel.org/all/20261101092219.1278751-1-skalpesh942@gmail.com/

v1 -> v2:
- Instead of adding NULL checks in net/ieee802154/nl-mac.c, disallow setting
  ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR link types via TUNSETLINK in
  drivers/net/tun.c, as discussed with Andrew Lunn and identified in Sashiko
  bot review. Virtual IEEE 802.15.4 interfaces are properly provided by
  mac802154_hwsim and fakelb; TUN devices cannot function as genuine 802.15.4
  radios and lack private 802.15.4 contexts.
- Add an explicit bounds check (arg > USHRT_MAX) to prevent integer truncation
  bypasses when casting 64-bit ioctl arg to 16-bit dev->type.
- Remove ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR from tun_get_addr_len()
  and drop unused <linux/ieee802154.h> header.

 drivers/net/tun.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec7311e60..05eb28578b8 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3362,6 +3362,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			netif_info(tun, drv, tun->dev,
 				   "Linktype set failed because interface is up\n");
 			ret = -EBUSY;
+		} else if (arg == ARPHRD_IEEE802154 ||
+			   arg == ARPHRD_IEEE802154_MONITOR ||
+			   arg == ARPHRD_6LOWPAN) {
+			ret = -EINVAL;
 		} else {
 			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
 						       tun->dev);
-- 
2.53.0

