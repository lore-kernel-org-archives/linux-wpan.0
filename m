Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE0018C906
	for <linux-wpan@vger.kernel.org>; Mon,  7 Oct 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336952; cv=none; b=OgRpzGpoGAC42GCAnBC0eH4DxI1VEQDfNRXesxsWfgxsXpYFVrfAG4QduflZ+XBljhr5GUO1H7xqACCNu4vo9NS/gkBZlrERdOETJEH+P5ni5DbbCQl/bVRwdZjS6WYwp2koKA+TaKAEl9A0sU4H6N6R4ouKMQ/Ojz/aDdDDC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336952; c=relaxed/simple;
	bh=CZ5nZ72LPsUscQ/XLvrhFET6jRbMhyKZW1WicnfpLPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aza5iQor/4QrPfvB+dQf6wtU6fvt9M0K7gRbvbxkoGOJz6Bgo2YP1htR9iPPSpEUq0n0tyyR9smeHECgXeuggjCF0t7Io0ZmjEtRndbdQycSDWC72xxtXH7fivm5UrrrD1iyfn+zDP7T9k7QlIUxrF4WE0vyGTVPPgdLbPOKr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XbgRrvyu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XbgRrvyu"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb2191107so43926055e9.1
        for <linux-wpan@vger.kernel.org>; Mon, 07 Oct 2024 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336949; x=1728941749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU52YEIbPPjVkPgQ3Y9wQ3w91aLQy4KsNcSSu3XlZvI=;
        b=XbgRrvyuC2C4UUGZm1Kyg96OotgJi3Y38sEyztjS4C7nn6SzwMxGBHUv+ISEXyhnCe
         NwCcE5oQT+9dmYlJgr4gj7chS4UxdDFK/yvxlG6ToSyZk/7mFcz9HRHnfgtjH4n+RDnQ
         Y9uLI7/25fDkq10IXfmGRUhdKg8ek/QPQiatskwJDBcE5sZp1/cRIfnkfUSvngRmMyFU
         qGG67meoIL8OdvgiUmEF5XBWJtcQGpV53mCCeAAFh5tfYNLlu9S76mcaFC5SzHUQo9hA
         O1B6ZCKm6FzwhcasSZe1SCWk4GdzS+65+UWUWatz8tpZklAEPMPbq6Zp78R9NMz7Z6HJ
         0coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336949; x=1728941749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU52YEIbPPjVkPgQ3Y9wQ3w91aLQy4KsNcSSu3XlZvI=;
        b=qyNoN4TLt4kgHe07tFD1SpFEKlgP9+c3U8lAWFU/AlryTEcFPk4YhW+rAh0GpainYh
         0wQ3gjjazmin/SBlVypQ64xS5UrIWQNTp8S8aFoHsirV7uK7vbaNUBM7vfjB2m1LoSab
         oUfObuLGF2SB//CQBwPh41xy55jEAQ3Hny24fSUt6VTKkv/vNwB4w9/GzvV37DdyLpJV
         fD08iBkMS/OerZ0AjFbNu1nJgtn+WN2Gyq8oU7wGFqWcdqiqLcb8DSK1BRWCqAb852Hw
         a3YMJ4X43u+KUfYtWQqf/gMF+26gLsSKXMAWRqRmbmMPRfJPti1DKp+/5C+/h8A58NPf
         PF6A==
X-Forwarded-Encrypted: i=1; AJvYcCWQPB4SYGRTlBWUj/SUfcEnhkQdmscjSUTo7xIzVuDXDMVcdTxTu2oKr/BlohhOdhRiKplAdg03fEhk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxf6cgjC5N5vB5PuuI5wASpdh1iAz/RWysQ/uvhLidCHXOaqMa
	T/OUKbBigkpLUNogd7DmM8v5i9PNIiim8p3E7nYaCxB48/E3vg/QN3reBxVR+p8=
X-Google-Smtp-Source: AGHT+IF3Mr1m0BA+tyZxEbsXfJoH0mYfnXmhY4oQRsrEz2kQrNeN0a7g/aWeWG/UvI2YgEescmo9xg==
X-Received: by 2002:a5d:5f88:0:b0:37c:d179:2f77 with SMTP id ffacd0b85a97d-37d0e6bc9f8mr9021915f8f.12.1728336949047;
        Mon, 07 Oct 2024 14:35:49 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:48 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v2 6/8] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Mon,  7 Oct 2024 22:35:00 +0100
Message-Id: <20241007213502.28183-7-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sock_init_data() attaches the allocated sk object to the provided sock
object. If ieee802154_create() fails later, the allocated sk object is
freed, but the dangling pointer remains in the provided sock object, which
may allow use-after-free.

Clear the sk pointer in the sock object on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/ieee802154/socket.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 990a83455dcf..18d267921bb5 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1043,19 +1043,21 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 
 	if (sk->sk_prot->hash) {
 		rc = sk->sk_prot->hash(sk);
-		if (rc) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (rc)
+			goto out_sk_release;
 	}
 
 	if (sk->sk_prot->init) {
 		rc = sk->sk_prot->init(sk);
 		if (rc)
-			sk_common_release(sk);
+			goto out_sk_release;
 	}
 out:
 	return rc;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 static const struct net_proto_family ieee802154_family_ops = {
-- 
2.39.5

