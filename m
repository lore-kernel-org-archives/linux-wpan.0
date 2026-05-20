Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55B3E8C5B
	for <linux-wpan@vger.kernel.org>; Wed, 20 May 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286618; cv=none; b=rujXoOpZQz57z4yry7RKq5HeHdlGDpGc1iM0z7i9xAhcDS3DlEqeOjKm5fjOQ1SIVdXXlL4K0mOPyxakiFjLLg1mfLwc0Boy3oin3qyvjVB40my/jJUC48uAUUfH/GJEgvlOCwSzASsS7sCXsQi/XrBz9UAfzAJ7FvLmaCjLFyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286618; c=relaxed/simple;
	bh=0brtW1b95iw24iU58TPlwkxsh9ivQXA9CUxrYavu3oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM8bdJ8xlyTRuEMlMxVpCiyuUaZxOoobVjMoAJwczpTOOyq3nJrHNG75aXjKH7rGiRUupVBNGRLZuiXcuOAsQ9ONSZFWiJ9QibpKOB5DHRRAVyHNpc+MizxOKMWB8MxoA0tU/3fIzMRAjtds33AsQ4xDIz5S0KFCCyxGtw8fTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBn9GBjK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBn9GBjK"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9116861f004so1147261785a.3
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2026 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286615; x=1779891415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5DoMls1QAAyY4rhECCtO93CkScQuRF+sIDiF9nKy1o=;
        b=dBn9GBjKI9agw7Zu2/r9sEQ13fv0qvbbsPfCjhlbV00v8pSxc1w/tPTYuOQqj/b1fc
         uWcvDrnMhAoannevMg9FhpL9N03CZ0JQN7gljnWGpEX9BC/R34OP120xYhGYMNeL0kY9
         g11o2TATmtQWvZ2Xmwz+v4Czrx8Dp44ZTSIPJm/J5Q4+mhHLM1zKrJs53/6O0NNTwGSj
         Qvr/WBq7+wU5M1KoYwtFVPLcuKGlTce5GF3cBquUYYBN6g0HJh4taGrD9A9wpYX1Hvtj
         m01jY3ueUZFohKAOGnbPw4TBFS4rKA57uZDHovg2Od1glXISDnYZ/Uw9R6KJwA7GAUa7
         YLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286615; x=1779891415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5DoMls1QAAyY4rhECCtO93CkScQuRF+sIDiF9nKy1o=;
        b=RHAaiVSB0Yw6/edfMB4vL4hmW71fSUbZJ8JguWQLft8cpsEPTkWvo6kYSuaz/63mkA
         DP1cGZKGwDApL0nq/gSKQYak22EyaNPJDUyvCNk/ZFKeCC6eZ4lQK4sJhvYxJcmtglhp
         zqBjEY7LmBgw/X/lns6cQ/zf7XClsB0QvGBBaT8RW/wvjgmc6fNO0dlIh/yo9yCjxaZx
         WUbvuFvrqO3CHfMFXWyn/1j2roCmKS8IXX9kTlSyw53rWx31ugjHoMVc587ja5kS/JBs
         ij1y2Ql7JJyMMPi/2b0w4ElUHg1Av24z5noP87qrFRaAyWhVJI7aYWZRhPDTR7QJLOn7
         DTeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dLzSQ/Ay+O6BxkxhLleGbFiYZeZ2b2+Lvy05YC1sgdu8dZZc2zALglDX9fCl8gbWtB0OE7KKMQf1/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5c60QT45c6+yoMtFkbRivDd/CWAEtd1QEaN6Aa3bZk+aKLIqE
	1oVcmZH4iJY1YmEk7RNc8FtYKZCmM8xwZWK8Ixqw8/+DxG4ojYuV1TL4
X-Gm-Gg: Acq92OFZoEoFA29UdZIy3ieWy0sXHCtTGCvhwkxwgrEbUzDaXm2zNGe7t6A0VxwZspc
	6oyl+e47/o9pFg8Q5Oa3FaPDVNUWyUk7a8sGgZicBDKioiIcI6ApkzkWy92cFefMQu+CEeE0ppP
	ggnpLhzY5amIJutpbGlMOOGMCQhYWASvmB1AHRJQlgYxfxJt0t6qS5WBiCUxfDQslMIoS6pWvoe
	WyWo+TfLbuZyXxlCGkJvao5j0h+je7VRKcePT7y9Haz6wqaMzMk+tFiy7j3eJp1/BP+w5Bu56C1
	qOqLPd9ZUIIkgG8ytvREqTp+znUYgkzc/PFCfNyvbwDKibdlP5qufm5yKMMLDxGeY8X2CswQjzR
	N8VW868q+GBtFwM36Oasc2U/aDrPmVHl8a4XwYreHZfAzW6qxJ3CZftwoAVYaSYpekaYr/dnhLH
	a/Kk47erva+L0QUbzjN9WTEG6i7o78+97v7L4MIXRZln5tOlm47ui2xbKBGyWiMTAVeDPwHfuF9
	7JHlHSDew0sxpq1xYdJ
X-Received: by 2002:a05:620a:298d:b0:909:b197:4692 with SMTP id af79cd13be357-911d1335796mr3440636085a.62.1779286615084;
        Wed, 20 May 2026 07:16:55 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba463814sm2138952485a.5.2026.05.20.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:16:54 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] ieee802154: admin-gate legacy LLSEC dump operations
Date: Wed, 20 May 2026 10:16:39 -0400
Message-ID: <20260520141640.1149513-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520141640.1149513-1-michael.bommarito@gmail.com>
References: <20260520141640.1149513-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

In net/ieee802154/netlink.c, the legacy IEEE802154_NL family ops table
builds the LLSEC dump entries (LLSEC_LIST_KEY, LLSEC_LIST_DEV,
LLSEC_LIST_DEVKEY, LLSEC_LIST_SECLEVEL) with IEEE802154_DUMP() which
sets no .flags, so generic netlink runs them ungated. The modern
nl802154 family admin-gates the equivalent reads via
NL802154_CMD_GET_SEC_KEY and friends with .flags = GENL_ADMIN_PERM.

Any local uid that can open AF_NETLINK / NETLINK_GENERIC can resolve
the "802.15.4 MAC" family and dump LLSEC_LIST_KEY on any wpan netdev
that has an LLSEC key installed; the dump handler writes the raw
16-byte AES-128 key bytes (IEEE802154_ATTR_LLSEC_KEY_BYTES, copied
verbatim from struct ieee802154_llsec_key.key) into the reply.
Recovering the AES key compromises 802.15.4 LLSEC link confidentiality
and authenticity, since LLSEC uses CCM* and the same key authenticates
and encrypts frames.

Impact: any local uid with no capabilities can read the raw 16-byte
AES-128 LLSEC key from the kernel keytable on any wpan netdev that has
an administrator-installed LLSEC key, by issuing an LLSEC_LIST_KEY
dump on the legacy IEEE802154_NL generic-netlink family.

Introduce IEEE802154_DUMP_PRIV() mirroring IEEE802154_DUMP() but
setting .flags = GENL_ADMIN_PERM, and use it for the four LLSEC dump
entries. LIST_PHY and LIST_IFACE retain IEEE802154_DUMP() because the
modern nl802154 family exposes their equivalents to unprivileged
readers by design (NL802154_CMD_GET_WPAN_PHY and
NL802154_CMD_GET_INTERFACE carry "can be retrieved by unprivileged
users" annotations).

Fixes: 3e9c156e2c21 ("ieee802154: add netlink interfaces for llsec")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ieee802154/ieee802154.h |  8 ++++++++
 net/ieee802154/netlink.c    | 16 ++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/ieee802154/ieee802154.h b/net/ieee802154/ieee802154.h
index c5d91f78301ad..fd9778f705503 100644
--- a/net/ieee802154/ieee802154.h
+++ b/net/ieee802154/ieee802154.h
@@ -23,6 +23,14 @@ void ieee802154_nl_exit(void);
 		.dumpit	= _dump,			\
 	}
 
+#define IEEE802154_DUMP_PRIV(_cmd, _func, _dump)	\
+	{						\
+		.cmd	= _cmd,				\
+		.doit	= _func,			\
+		.dumpit	= _dump,			\
+		.flags	= GENL_ADMIN_PERM,		\
+	}
+
 struct genl_info;
 
 struct sk_buff *ieee802154_nl_create(int flags, u8 req);
diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 7d2de4ee6992b..9c9fd14d0ca8b 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -98,20 +98,20 @@ static const struct genl_small_ops ieee802154_ops[] = {
 	IEEE802154_OP(IEEE802154_SET_MACPARAMS, ieee802154_set_macparams),
 	IEEE802154_OP(IEEE802154_LLSEC_GETPARAMS, ieee802154_llsec_getparams),
 	IEEE802154_OP(IEEE802154_LLSEC_SETPARAMS, ieee802154_llsec_setparams),
-	IEEE802154_DUMP(IEEE802154_LLSEC_LIST_KEY, NULL,
-			ieee802154_llsec_dump_keys),
+	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_KEY, NULL,
+			     ieee802154_llsec_dump_keys),
 	IEEE802154_OP(IEEE802154_LLSEC_ADD_KEY, ieee802154_llsec_add_key),
 	IEEE802154_OP(IEEE802154_LLSEC_DEL_KEY, ieee802154_llsec_del_key),
-	IEEE802154_DUMP(IEEE802154_LLSEC_LIST_DEV, NULL,
-			ieee802154_llsec_dump_devs),
+	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_DEV, NULL,
+			     ieee802154_llsec_dump_devs),
 	IEEE802154_OP(IEEE802154_LLSEC_ADD_DEV, ieee802154_llsec_add_dev),
 	IEEE802154_OP(IEEE802154_LLSEC_DEL_DEV, ieee802154_llsec_del_dev),
-	IEEE802154_DUMP(IEEE802154_LLSEC_LIST_DEVKEY, NULL,
-			ieee802154_llsec_dump_devkeys),
+	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_DEVKEY, NULL,
+			     ieee802154_llsec_dump_devkeys),
 	IEEE802154_OP(IEEE802154_LLSEC_ADD_DEVKEY, ieee802154_llsec_add_devkey),
 	IEEE802154_OP(IEEE802154_LLSEC_DEL_DEVKEY, ieee802154_llsec_del_devkey),
-	IEEE802154_DUMP(IEEE802154_LLSEC_LIST_SECLEVEL, NULL,
-			ieee802154_llsec_dump_seclevels),
+	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_SECLEVEL, NULL,
+			     ieee802154_llsec_dump_seclevels),
 	IEEE802154_OP(IEEE802154_LLSEC_ADD_SECLEVEL,
 		      ieee802154_llsec_add_seclevel),
 	IEEE802154_OP(IEEE802154_LLSEC_DEL_SECLEVEL,
-- 
2.53.0

