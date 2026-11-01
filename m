Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793524995;
	b=FPWBcjy+plmXjx5/w0p0OnblPoMFUw+8kISpoA7XuNstyRPGnDe/rRvHhsYzeD5y8iCE
	 HwitG2pF1RlvGXCuDGjSnu0Im44GpdRW8mHuSHevXqFVTl0wV0wj3bEdb5CGuo1jpdMDA
	 imofZsI95ZQ0llg/8fXI8uXM4U/l8+OQvmlyt4iu1sl0yB8PXaVsexo1dY7WQEuPymiR0
	 KzKiTj4FuEBJPeI9HF8hJCg8Dp6ZUmzVpSi8zvNFRhCJIO2fw7qH7W+/EZuggULv2W70h
	 AAl02LTNSkjn8oGNQQb8Tv0E2x6hPS5o/S3UOxqJx8njCPzjiUcFb13JzEMP0kpBOTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793524995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QKQXXPx0TtnAH7kUYwvPG35lGpK3RW8/bNQYeuZv+r0=;
	b=43nBrsq0eGd/Byns7ACDT3oVAYhTAOHiPhg4EyfnJXPckyd3+HRvonkJPSiLXJ5i6GwG
	 1btStPCkkOIgFDUaZzNAahaAbCu0I5jFlmXEGdvI8UWmLbmHyJ3bDE0oBECkxk3JPoMzn
	 aXjgIkVUS7TMlGIJ+e3HLYx2bgFhLgPupuJCWmHTjkQo/h4bul8uxI9Gb5iGCiCahm0cU
	 4cz24v3PoIwqR9ZrP+IUVh14a9f5mU0Segyqkw2LAJbIwl6dqbbKSRnvs8MzY7OLP0I4e
	 swMlkOV4Zjt+4IFp3MoUgu8hvLgqQoh4yWvQJVI9457OZa+MKJkddfIlyp2YOyPJHYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pHyohmlz;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530A606A327
	for <linux-wpan@vger.kernel.org>; Sun,  1 Nov 2026 09:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C530A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pHyohmlz
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a2551d7b5so4048523eec.1
        for <linux-wpan@vger.kernel.org>; Sun, 01 Nov 2026 01:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793524994; x=1794129794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QKQXXPx0TtnAH7kUYwvPG35lGpK3RW8/bNQYeuZv+r0=;
        b=pHyohmlz234FO5ddhkGK3CGghjQSnOPw0U+b7mp+iQ2Qog0pyEnV05r2o/KWSU8x+s
         XyjePTJfY4Yr90NiqcD310MAxjgzU08691YReLHd9Ggq1HqgtsSRdWXu1Z750l8s5MRs
         kJZG2JtcISaQT7kwDUOLBQgnOSMK5S7CMmRAX3pN4Vx6w/yqbQZ5OK1jyKmCDPzcSItk
         GB1gzj365eeujHiPjay8quZNM7Q0AlRzc+b7Mktp7Jkjc769Xz4IMEwmhpaBWTUPr1Dn
         +Kdrx+IqzROl9knrPszFTYBKlorg0c3x8NxszRwtQ+NiKpjQG2Ejy3xcUFkBKP3RH1Gl
         atlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793524994; x=1794129794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKQXXPx0TtnAH7kUYwvPG35lGpK3RW8/bNQYeuZv+r0=;
        b=p8gdcsDPBvyO+vQmdRXw1ssW3CPBfeKsP8NU/DAXKbdVAe9AHolVhOrhw7ZN+IqXOl
         xU8yeIRS9bTNZw2nefHiLDbQD2seo02OludJU9HHTSNVvorq7pjSRpNJ+Di1GQyWgVc8
         aCUHFTfcW7z/XRqbfwGWhjTcUyVxHeP5aHxD6auQfo/bdewMfKi927jkeDIxns4Cn6ti
         3CC33f0tuueq8dyxUpNAcR8AgXGElZNIge42Moj6/qll6vRj8lGdD9JAjdyM+qUka5po
         XPHV2gdVP+876FJqOm9W1RgkD0p54b2k4mtrgDQtKiYoxrOw2VsT05xYCNeg68mjE6SA
         3jIg==
X-Forwarded-Encrypted: i=1; AKwUvBwvtSJQhuJwXkFOdNVVsMiOa3Dia0ee+/ofa1CWHXa/Oc5F/apbxRPR3mr5+vtivTO9+E+YLDG8p3ow@vger.kernel.org
X-Gm-Message-State: AFq9FYLDgu6kjG/lvJhjHxxYWcYiYSvSIuj0jnfESa7Ak22OHPnYyBNE
	/IyKx4zyCK+VIiIJrGDzoJoUR86yN0WwnHSI3rw+QmJihlEq9fwB++8X
X-Gm-Gg: AYBFou0nPjv4kDspaEHpIw24byamm1ePDGRTJZ7oEo7TdH4Z/J5tsLzI7q/CIefuS5Q
	MLq/vdQxwinY0HYHI5GlxGwA4vKweLVZPVTh2LFN9vKRT9EewzsJTBNTk1M+pPgug4Uu9UpncYb
	4g6jNphoOkrXXn7+8loD1PNMWmF138MSD6m1bAzt6UUMNBeoShWyxFgHVJedvcV6+1aW0ahge1k
	/75wKS8mNkTraeKMjzrQ/lGWz3FGnFVWTpw3Z97M5bQc+SJNk0u9A6N3K2NH988zbJLhIJFbWXD
	pwHVqZ8F5YsqMq8VBTcEUA+H+xtJCxSNsi31qkKmHxwc+TuTBaHkcUJESa4RoZZz7gANev4ItgR
	5I3iZ/Y4Fou87WUxZp2pKTj+Xd1YztSv4JLJLp10SuGkoWlbuhKC7+UGDrPj4fqm42ZZFkeMdZi
	QANCKNuWLPMhM/IZxPiFKxlEoocASSIIdMt0d2hQ2ra1P1WKcFHFCGaeSRoYpT518BEfH/eJGUr
	U2yQcEV5on7I/8ZHCY7dDQK5kNVfaRhoGpNcQuIZ59aWl+rG84PIPw+acEmdc3OY388mKbYDB3G
	RQ4waPHiTqWJQhx/tJ99NOh7/HtTCiQKAk0S
X-Received: by 2002:a05:7301:53c8:b0:36a:22de:d85b with SMTP id 5a478bee46e88-36a2fd48fb3mr13979029eec.2.1793524993618;
        Sun, 01 Nov 2026 01:23:13 -0800 (PST)
Received: from xploitoverload ([2406:b400:f11:1bac:4040:640b:8a1:8629])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm29407539eec.26.2026.11.01.01.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:23:12 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	Kalpesh Solanki <skalpesh942@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ieee802154: nl-mac: validate device pointers before dereference
Date: Sun,  1 Nov 2026 14:52:19 +0530
Message-ID: <20261101092219.1278751-1-skalpesh942@gmail.com>
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

A virtual network device (such as a TUN interface) can have its link
type set to ARPHRD_IEEE802154 via ioctl(tun_fd, TUNSETLINK,
ARPHRD_IEEE802154). However, such devices do not have an IEEE 802.15.4
private context allocated (dev->ieee802154_ptr is NULL) and do not
register MAC operations (dev->ml_priv / ieee802154_mlme_ops(dev) is NULL).

When dumping security keys via IEEE802154_LLSEC_LIST_KEY,
ieee802154_llsec_dump_table() iterates through all net devices and
dereferences data.ops->llsec assuming that any ARPHRD_IEEE802154 device
has valid mlme ops. Because data.ops is NULL, this causes an immediate
null-pointer dereference / General Protection Fault:

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
  RIP: 0010:ieee802154_llsec_dump_table+0x204/0x5d0
  Call Trace:
   <TASK>
   genl_dumpit+0x125/0x230 net/netlink/genetlink.c:1026
   netlink_dump+0x53b/0xd00 net/netlink/af_netlink.c:2351
   __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2466

Similarly, ieee802154_dump_iface() and ieee802154_nl_get_dev() assume
that ARPHRD_IEEE802154 devices have valid dev->ieee802154_ptr and
ieee802154_mlme_ops(dev) pointers.

Fix this by ensuring dev->ieee802154_ptr and ieee802154_mlme_ops(dev)
are non-NULL before proceeding in ieee802154_nl_get_dev(),
ieee802154_dump_iface(), and ieee802154_llsec_dump_table().

Fixes: 3e9c156e2c21 ("ieee802154: add netlink interfaces for llsec")
Cc: stable@vger.kernel.org
Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
Tested-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 net/ieee802154/nl-mac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 74ef0a310af..1acde5af4b5 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -162,7 +162,8 @@ static struct net_device *ieee802154_nl_get_dev(struct genl_info *info)
 	if (!dev)
 		return NULL;
 
-	if (dev->type != ARPHRD_IEEE802154) {
+	if (dev->type != ARPHRD_IEEE802154 || !dev->ieee802154_ptr ||
+	    !ieee802154_mlme_ops(dev)) {
 		dev_put(dev);
 		return NULL;
 	}
@@ -437,7 +438,8 @@ int ieee802154_dump_iface(struct sk_buff *skb, struct netlink_callback *cb)
 
 	idx = 0;
 	for_each_netdev(net, dev) {
-		if (idx < s_idx || dev->type != ARPHRD_IEEE802154)
+		if (idx < s_idx || dev->type != ARPHRD_IEEE802154 ||
+		    !dev->ieee802154_ptr || !ieee802154_mlme_ops(dev))
 			goto cont;
 
 		if (ieee802154_nl_fill_iface(skb, NETLINK_CB(cb->skb).portid,
@@ -771,7 +773,8 @@ ieee802154_llsec_dump_table(struct sk_buff *skb, struct netlink_callback *cb,
 	int rc;
 
 	for_each_netdev(net, dev) {
-		if (idx < first_dev || dev->type != ARPHRD_IEEE802154)
+		if (idx < first_dev || dev->type != ARPHRD_IEEE802154 ||
+		    !dev->ieee802154_ptr || !ieee802154_mlme_ops(dev))
 			goto skip;
 
 		data.ops = ieee802154_mlme_ops(dev);
-- 
