Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E641DE8B6
	for <linux-wpan@vger.kernel.org>; Mon,  7 Oct 2024 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336955; cv=none; b=eaMRCD5XsViV8UdneMBgwXlPRi0DXdm/WQQ9FFuxZYBA97Mf2zdkzso3k3bxEcUkjjwAWaiKGEKrIAIC8AgDwEGPpETioJVvdxfyAhV1ikNgYBSEi+7LBFIBKOdiZBYeMR364oSu+VzlEh8XiZt6FKmRZDuE5qi6fy0F+qwHLD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336955; c=relaxed/simple;
	bh=TykJJMM5IzwfbahmKZJTnRFTzpHvJ80eOgoE0YjZMYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luFtD9UyzV5XWmC1iJ2ah4puKOzlMvQajnqb/7pYlkONlIJiwTnKNXes1vy7D1SD5dFPc0Ade9BgB4SBXNFC01BzEXCbMH2G6nkMYhv75MfjhaWlCn6SFZDfr1QXVZ7oYfaN/0wgSqV38S4iOf4deKgbdjTnY29seU9vHxJEZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IadjJ5WE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IadjJ5WE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so43844205e9.3
        for <linux-wpan@vger.kernel.org>; Mon, 07 Oct 2024 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336952; x=1728941752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49ytr3oVzMOQdVnJdbtLDkZg4U2+YqG6lYXkOtuknMY=;
        b=IadjJ5WEYC2qjD9w97BQkm7IndEvOut78OQ5wJZuFBpbNNc/limp5VYD4IP4DhcOWs
         3Tuw20KC0iaDMS3EcevV8IYAWcFCuLryo71ZofZ4uoMrsj3nk2t5uUfoEUvboGQYNt70
         XSM7M6Z4Brd/od18tMRWCblm5xsG8Y+1MI5vbxjD2Zxl7VwU5wlOa4dZLhIQOJL48Stz
         Mj2pTa4l46fGKnkOpLVt4yoZdys0Nlu3sbstkmTl28dUrsvrt+uVrl/suE6FteSR0rV7
         RMlQz9sOqnvJWxkCCYkztNpM0ve2jdh3TiwJrJkeoJzJf878Wur0G26cWBa3hlKULuoU
         nEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336952; x=1728941752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49ytr3oVzMOQdVnJdbtLDkZg4U2+YqG6lYXkOtuknMY=;
        b=dfZjZLrYYEfg6gro/fWFV/KbMQwAL6mnF5ht3dWh/OXUQuPvUzbuU+rc4Zgx4UUtUX
         3x67+AAkeuTEXZnwUm6IOHKE0Y70eNSigfXT3T8saTQA0l5DvmoYIxxhT6orLTT0q2kc
         XfPcqLB8o9WI+M2V0eMVS4AYAuUrj0+H7LAqinfE9Y7iayEPQCkHS+EzlCVllL0dd59r
         aWgOXBxZ1nl6bppsBWvXuL2j3akwBZYPxM6ZnRGBP/Ebq/vyOXIu4/cB12/vv2ohhjYo
         tA+e5M0GPoupdZbvjPv/Ko7+ZvqAOdjhIYGxjOnPmRpkGomy9eB56t07CAT5aQF4Uikt
         eZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQsouevy2p2Zu4H0RpWryZG4WZtoYzSE6mC8rd44V0sLEHa0WxImlnBo0FI/zVVx8NLpW7e1oO77Li@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ9uutDCeyd6rSfrO2JgOVFQ+D8Wcjoi2kqo8ITBresaERmuBu
	zucHkumiZvDCk67pTqt+1LXUw8z/SFeOJPsrwtPY0oiKr5eEbtcxLd7cvkUR0Cs=
X-Google-Smtp-Source: AGHT+IEANzLF+YRzAcqDXPNSr1m41nJQ4hZi4WyDM2XMIIfrfbIkQHrP+5IaWRoz90/emp42kZFqcQ==
X-Received: by 2002:a05:600c:3c94:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42f85ab8972mr102989265e9.10.1728336951961;
        Mon, 07 Oct 2024 14:35:51 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:51 -0700 (PDT)
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
Subject: [PATCH v2 7/8] net: inet: do not leave a dangling sk pointer in inet_create()
Date: Mon,  7 Oct 2024 22:35:01 +0100
Message-Id: <20241007213502.28183-8-ignat@cloudflare.com>
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
object. If inet_create() fails later, the sk object is freed, but the
sock object retains the dangling pointer, which may create use-after-free
later.

Clear the sk pointer in the sock object on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/ipv4/af_inet.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b24d74616637..8095e82de808 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -376,32 +376,30 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		inet->inet_sport = htons(inet->inet_num);
 		/* Add to protocol hash chains. */
 		err = sk->sk_prot->hash(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 
 	if (sk->sk_prot->init) {
 		err = sk->sk_prot->init(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 
 	if (!kern) {
 		err = BPF_CGROUP_RUN_PROG_INET_SOCK(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 out:
 	return err;
 out_rcu_unlock:
 	rcu_read_unlock();
 	goto out;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 
-- 
2.39.5

