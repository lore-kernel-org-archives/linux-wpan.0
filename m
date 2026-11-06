Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975135;
	b=g9QG7KuJvKMzW+Uq2sXugu38AAyulK7iaPbAG007sOZ7gULQ/oQXlTd2c1OvG/J07JbM
	 ny4yNQts/FV3FJIb+tnSqAMrNsonilShXXUe7TKbYjsNZaWw33nnxO6CX8V16lhHzw1xk
	 0OwyFRraX8mGBKsGnIM565aO0Ycz3wRs4hu4lFWgQgrbt1/8OaLU+iz6Nt0fGmzePgEK+
	 vvMtTma5jHTX2wssBtfVNxp1VEr44dyyINo3lGaJINOxDbrvDSFjvysuuHKE8wMjdLQvs
	 FnTi/SfucujguWUSX5xPUwXLpKdYSms4js4PjTd0ZBzD/MuGRwaAyw4zqy8q4qJeWvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/vQq7/OUg3A7EulCfcTLyC9GSdMx/w1XZowxdVp3bKA=;
	b=Do/xb7SCWdTr8yfglWjmOUSoTqAKFUyhSR6+IlMjz6VMgkxOa4lsNz6G+umzn6FO4O+c
	 OuCOv2w1fwswyPfVK1Iz5XK3HVGXdSXIopRh2Y1mh9seI9rqEe/EK9HIBR1C0K3vUdqB6
	 PMqyIOorNQJmVUDN2XXZhWCxxviGsyOf5Y2KCZH4b+8o6iJ0tpPSbJJGZByo5pm3QCmTO
	 xWaLDnAmdrQoatKv+hI0YW8AyyXPmYw95GdzMU7Bax6FrTqJoYxun/K2MyW2AH8duv+ac
	 NG2e7aASOey3oNHaYtr1f3boZQIfEjkuNXZcCak6znJKKsnr3Y/0aY02wfVdxlqrTgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W2eonC8s;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596F606D83B
	for <linux-wpan@vger.kernel.org>; Fri,  6 Nov 2026 14:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6596F606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W2eonC8s
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1146242eec.0
        for <linux-wpan@vger.kernel.org>; Fri, 06 Nov 2026 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793975134; x=1794579934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/vQq7/OUg3A7EulCfcTLyC9GSdMx/w1XZowxdVp3bKA=;
        b=W2eonC8s5BJoRJbGppqiM59YV2PN0mcjJtgshuRjRbHdVnNofp+7+PEYxNdpvBxpbF
         x5rYNo2JyVZ4V4R5Le102ZQNLVClJMW7MZuEySu52HnWSQZmSDOUkbP5vnxfuwlJpDfI
         OnuLXNgE0zwBeh84ZysOlJ+KbXUM98KIzUn6GaWW5s9kQaxxMgCuUGVLjfP12ZQXyr0d
         1bWAIW50p2F3lyLjDha6jY4ti7mYGfMqc0N+JVGJm6Uld2hLrwJUthgOUl+Jl5cj1L59
         io/hF4A70i+hbFY3leR89gt8TQE8zmV9Wlo86SCZk7x2SbAfkx9DkYhQoH3kfGlDKL+N
         qsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975134; x=1794579934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/vQq7/OUg3A7EulCfcTLyC9GSdMx/w1XZowxdVp3bKA=;
        b=ddj0RJcM5h9FB1TSHswX3xGGbzTWhqsNQCQgUsbhgLS0licdkW0VHtYabeuu+US17w
         7DHXm4Xl5bZF16q2we1jvbNQSz5ERaUvabPS+lNM5dMoumthyFc1L4X86XEX9jxXWp5W
         G3TJmGk4nFjI60oWOUsrKNQ0ab/cPBzPnr1prcbiYUG0gbZivG9asCWKdqUQYUli5kO8
         BVxM6Ypzw1WQ2fonE8c6pIFX8JgYdBtLgXG4iSPBXNN1NGoBbCX85iYomu+utpjBnYAJ
         47cmW2mR2maRMvsHpqIVmdYQ/bT6jbx/nzSMVazFrn8NeYXECES8lAXmNjH+BPM9oi1b
         ZiNA==
X-Gm-Message-State: APuU4Z99mVxJBjrp6NyCsmH5XiXArJ0O8hWdYwR9y7anmc85DJ56XFTN
	eL+1L8JdIeoD5HqrowzIYnqlqOdG2eSPMEUHMFCihAmrYtjt/S/y9a9p
X-Gm-Gg: AYBFou0TY/x9qUl8xiGn7SVlGAaN6N73SjbmEbu6DMb2v+P4fySlrSmXfUDBpoJYsvd
	FEMZVRu3uo6L/efDu/bOa4cV2aS4JnrWRzDkkmuX82Val24GxaWZAyDXRD009c6ASrPLGOh8VPS
	+zuLGhA4WrExNQ5ptAvO8aYJ4qToSfOCS1GcMhHfDjkrCHCkwQ0kRmST3LbomUMUy8q/NZGVPf4
	ePe94FmZvM65v+984wZ7p15hI4o5aq4ttK0knRZEBIUd5sDd7K6BCp+FrBcPfkNXvoOZuQMgFV0
	c8vGOX/8096u0XW3VHmmXmvGs1HEBse7kk+gXu4jNjmGYbzhXqXOvNP/4haSopdpwiyyUH6ymag
	6gMZB9Fy8nle1Ej6ZchvIZhSo5L5m3HYTefy1zD5ZEWJDrrfa+gXUCM1A8gewkI+8FM/d1PKBpx
	6NrhQ2sw8zkpjcGgTCFWmp25iiTDz91VSz8TYrUA2NhECJW8t7m7P79BH8TIzqdINv8DFj7D6pD
	JdtsUZKWnYr3bDvWXeV+gUttTdSmu0HBn5cuXaETUF7JCa3TXvRMqezXET4ThlVAHloQKrc5CR8
	G6dolTLQwssGTmwJegvQJLN66HGXCXzYWXqE254=
X-Received: by 2002:a05:693c:881b:10b0:351:7ec1:a92c with SMTP id 5a478bee46e88-36f76520e62mr3755759eec.28.1793975134156;
        Fri, 06 Nov 2026 06:25:34 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm7101233eec.26.2026.11.06.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:25:33 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via TUNSETLINK
Date: Fri,  6 Nov 2026 19:54:20 +0530
Message-ID: <20261106142421.17793-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101092219.1278751-1-skalpesh942@gmail.com>
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
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
to ARPHRD_IEEE802154 or ARPHRD_IEEE802154_MONITOR via ioctl(fd,
TUNSETLINK, arg) because tun_get_addr_len() explicitly recognized
these types.

However, TUN devices cannot function as IEEE 802.15.4 radios (they
lack wpan_phy, channels, PAN IDs, and MLME operations), and tun
never initializes dev->ieee802154_ptr or dev->ml_priv.

The IEEE 802.15.4 subsystem operates on the invariant that any
net_device with dev->type == ARPHRD_IEEE802154 is a genuine WPAN device
with a valid dev->ieee802154_ptr context. When an unprivileged user
creates a TUN interface in a user+net namespace, changes its link type
to ARPHRD_IEEE802154, and issues a netlink dump request (such as
IEEE802154_LLSEC_LIST_KEY), ieee802154_llsec_dump_table()
unconditionally dereferences dev->ieee802154_ptr /
ieee802154_mlme_ops(dev), triggering a supervisor null-pointer
dereference / general protection fault. Similar dereferences occur
across net/ieee802154/nl-phy.c (ieee802154_del_iface) and
net/ieee802154/socket.c.

Rather than scattering NULL checks across every site in net/ieee802154/,
fix the issue at the source: validate that arg fits within unsigned short
(rejecting arg > USHRT_MAX to prevent upper-bit truncation), disallow
setting ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR via TUNSETLINK
by returning -EINVAL, and remove these unsupported types from
tun_get_addr_len() along with the unused <linux/ieee802154.h> include.

Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK processing")
Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
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

 drivers/net/tun.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec7311e60..f2915e929e3 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -70,7 +70,6 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/mutex.h>
-#include <linux/ieee802154.h>
 #include <uapi/linux/if_ltalk.h>
 #include <uapi/linux/if_fddi.h>
 #include <uapi/linux/if_hippi.h>
@@ -3183,9 +3182,6 @@ static unsigned char tun_get_addr_len(unsigned short type)
 		return 4;
 	case ARPHRD_ETHER:
 		return ETH_ALEN;
-	case ARPHRD_IEEE802154:
-	case ARPHRD_IEEE802154_MONITOR:
-		return IEEE802154_EXTENDED_ADDR_LEN;
 	case ARPHRD_PHONET_PIPE:
 	case ARPHRD_PPP:
 	case ARPHRD_NONE:
@@ -3362,22 +3358,33 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			netif_info(tun, drv, tun->dev,
 				   "Linktype set failed because interface is up\n");
 			ret = -EBUSY;
-		} else {
-			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
-						       tun->dev);
-			ret = notifier_to_errno(ret);
-			if (ret) {
-				netif_info(tun, drv, tun->dev,
-					   "Refused to change device type\n");
-				break;
-			}
-			tun->dev->type = (int) arg;
-			tun->dev->addr_len = tun_get_addr_len(tun->dev->type);
-			netif_info(tun, drv, tun->dev, "linktype set to %d\n",
-				   tun->dev->type);
-			call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
-						 tun->dev);
+			break;
+		}
+
+		if (arg > USHRT_MAX) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (arg == ARPHRD_IEEE802154 || arg == ARPHRD_IEEE802154_MONITOR) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
+					       tun->dev);
+		ret = notifier_to_errno(ret);
+		if (ret) {
+			netif_info(tun, drv, tun->dev,
+				   "Refused to change device type\n");
+			break;
 		}
+		tun->dev->type = (unsigned short)arg;
+		tun->dev->addr_len = tun_get_addr_len(tun->dev->type);
+		netif_info(tun, drv, tun->dev, "linktype set to %d\n",
+			   tun->dev->type);
+		call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
+					 tun->dev);
 		break;
 
 	case TUNSETDEBUG:
-- 
2.53.0

