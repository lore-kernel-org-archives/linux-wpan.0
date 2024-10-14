Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACC1C304B
	for <linux-wpan@vger.kernel.org>; Mon, 14 Oct 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920315; cv=none; b=sDRUfZ9aivaFqt/CPXZSpLLAJVFZVMxp7vJ2GesePjHxSRzmMgfQByFW8dPEPrgor+/HF1BrneA4nbqSrOnSuPh1tuU8uwrbSkZOSK54ZoMIA0PbbLrdC8JtTc/7WxcG5idQdRU+Piggx5Z+p1KVJnm99ZoaEjoEjz9WWOLI6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920315; c=relaxed/simple;
	bh=XZyeSxYL0Rt6XzD7DrYNwyUkhIbWdcwwkzg4XCE56kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcqefABVITYYrKaXub2otuDehbzGdBwt71HPecT/PvOCponjsDUwrYxE54+3j3AEMibEw0iMytworIZP6mXCg6xSudLGfK7gWUdSSUOQv9QBTxvjmVVO8EsIggN6L3QuI6jRJdgs36zDnWX8ykDqV1XFloMlmqbT7SXGrYyQe18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MdISMh2T; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MdISMh2T"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d3ecad390so3494950f8f.1
        for <linux-wpan@vger.kernel.org>; Mon, 14 Oct 2024 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920312; x=1729525112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbHwWEpfmVr6vDfNAIj04FaBgRdnLx3F1Vt3RjTwrtE=;
        b=MdISMh2TxSBfUoqF8lTK+6J6uQKXbIMCfJrZTk/6CZNGiMzcPt68ImPAUhDH1m1dsz
         YJt23V5EHT/3HQhGRkewF6ynT3sir8fRvYKPU7kHtDC7q3OixowsoNhWb9pr6RCUlAfy
         ugZw/0YAW4yk2J9nc5U91yhNcRty7slQaA1wNFo9x374UmFLU7WFxsQmOYUoMH/654Br
         qdLOyIjIyUFEoQbmjsivrBkTGwSRSEeA2j5+FxjuGVJ/ufP4iIHrZZOyW846EWEnklg5
         s8VTZaN7tu9iW2Rz2rC+fz/1in2k3sDZhLeAlrvIDgtEBfmH+vhn0o/K+iyniUo3b95p
         v3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920312; x=1729525112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbHwWEpfmVr6vDfNAIj04FaBgRdnLx3F1Vt3RjTwrtE=;
        b=Zv5YuTh9XOhNGpCk3SF8OnoADrH7wX8FGRW+KzowB4yRrkgYKCve+b0rB/XeB5ESNV
         FcChpKkrFCvtLgNrfqkGmCLJRszcKEXKFs+RvOjZovhJy1g+OyWV2Rc7F4isGjia9HxZ
         YdbywIWPLVphuBGc3EQWakR461mIuuRtSFae58EPwwv7brWnCFhftorbx25WrCnWywQB
         UqQUuvBkKrT8l6dhAr01mGf+52A96SYiiPDqSBKwwAUoCg0MQnzrU7FiToU33nuy8Toz
         FflfjOa2GYH4mjMpsOpi1Ne1X7Hpw7te9NJWhvC5D7xZp749vnvig1++bcwAId19pOrG
         pFJw==
X-Forwarded-Encrypted: i=1; AJvYcCVkBadYk+BpnuZ7utc6kl2y2qz97CSBo8RH4euNhaS+zf3FEZ8ithsR7tEMZSUFBX5wlEj6vSkmwoc0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jEecXXxVKj6Y7Sp/21PHBBMrljDzju18TLTb+2foU5JRc3ob
	NDQNOQJKC++16Nb5BbH4Q6W0Q6IAe9sGVfaDUphOc2eY58gsf51LMvJ07VHvIk4=
X-Google-Smtp-Source: AGHT+IFpRrcvyLwLdEFLQDdJiBx0O5p4UCoiCY7EDrHsmjdj7yCbqKDU3xbbCNWtcTob1sB2WmybtA==
X-Received: by 2002:a5d:504e:0:b0:37c:ce3c:e15d with SMTP id ffacd0b85a97d-37d551d9cb7mr8770131f8f.14.1728920311872;
        Mon, 14 Oct 2024 08:38:31 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:31 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/9] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Mon, 14 Oct 2024 16:38:04 +0100
Message-Id: <20241014153808.51894-6-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
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
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
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

