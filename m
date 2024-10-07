Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263961D90CB
	for <linux-wpan@vger.kernel.org>; Mon,  7 Oct 2024 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336954; cv=none; b=eJGxz8tuo+TM0Z1t1wYe06hTfRyJgn4n/wfB2l28wKqCloiHYl03jxnirrBtSevrtEPAFxqsL4oslpg1vR4MHBzrHnbQIAZspcGDVT7XaGEEdUv3keLFF7m5g8S5UJFinzOWh4Kmfj4rp0gYMDQXU91bT2SyPiQq0s6pOoJBUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336954; c=relaxed/simple;
	bh=q1wcm6mMQ7h4EZDUMr6oUmN6x8BUBq/PxsPoaXApW48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhaY+TvFUjeFRbv8vfY+BqkJXSLNs8KUiaPGBKDEY+Ys1A1KJDk/1NHopSa6N+7phqh5nEUpxKSlynJ4acCvv8kTMC/Oe3dLKkQnnPvooM4jnTQuaKjwYbjTTMX1vQsoPlsfMzxgB/mci7ACX0Gz9brqFSdfGKbq/bL+wR1XIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KgpWQq30; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KgpWQq30"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so66474915e9.0
        for <linux-wpan@vger.kernel.org>; Mon, 07 Oct 2024 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336951; x=1728941751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lghPtxWNb8lEoXQFFkVieItQmyHsjS0TFzxCTFvvuyY=;
        b=KgpWQq30JOD9fxLC7vqR041Wy3CSUYpN7zQg24n0ZSFjoUHbvxUN+glNIQ+K5Jo4m8
         /Ss9hfWqpVMLYU1kKqdO5OAtK8JKQq/+onktN2NSxjPgd9YlC/zCh0OECLcrYXKJe9RA
         MB5xKQwR1Ckq1q64Z53Rw0lwDFd+k9ZZ+qBylI4/xOvLa+Ue7e6FF/l7tKllzAwlOKf8
         kODRrFpTDQ+cv4hcMNpU358AZ+lz6sPCRdJLLYiXgMSrzawzuy7BA7eg+VA1FYFFOywo
         Q03FNGLvTSvgMVz1JiZES0mevh+2WrBw+vssAtyU6WUUxPa2H739oDE6Onh0l8Po/tSM
         bhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336951; x=1728941751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lghPtxWNb8lEoXQFFkVieItQmyHsjS0TFzxCTFvvuyY=;
        b=cnFNBdymNW0mZP18QpKywjK+rv8qug+t8pl8HuMdMnXc51LpmYW/MOxFjui53FN0zS
         DgSyizO85UsDZYM7RN7x+nvlbf8+KsYJJ/x9nC/3BpdGInOuHxbLk2dcclPJuMMPN1TK
         C9fwhnyjofKj7kHoq5Wtj7omFJJXyCqHQadOvXLHxqwZi1kGlj7Nb/j7ypSeGwH5NXFp
         7zZHZi9fL/omy9wY9SH3HtysVtoHQkMlZaveW8OrHAFTykcuFzD1LISHVpOyu46kdNH/
         KRCgKm13lz2RO5I7hfOcKE8mrbLgsqLTC3kOVCqbS3Qs9BnthkD7zOOZeyufat51/fnH
         rBdA==
X-Forwarded-Encrypted: i=1; AJvYcCWRGMOEVq9ajMCYb0iKRRr5eeEOj8wLtD5oKCVsaAQMcYqW9OXinMgbeLen/Dz7iNk7oM/2nuAsCp7n@vger.kernel.org
X-Gm-Message-State: AOJu0YzaqUGolx4bW9Q2SKqA2uw1klfhwdrSbo0IHi1Rx/c6X525TDnB
	DSOrIEXPxjMIjN+w9RhhnWvti1kjbiZim0FTAM4W/5W7cnrAdo01X6++z1GSg48=
X-Google-Smtp-Source: AGHT+IGIEgvlVQ63MN8px9sXGIB6rH0PaHc0x2aiS2t9bCm+0YE6s5XpgSiahpjGOCaDNGfNsSEswQ==
X-Received: by 2002:a05:600c:5494:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-42f85aef6e2mr143742535e9.29.1728336946921;
        Mon, 07 Oct 2024 14:35:46 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:46 -0700 (PDT)
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
Subject: [PATCH v2 5/8] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Mon,  7 Oct 2024 22:34:59 +0100
Message-Id: <20241007213502.28183-6-ignat@cloudflare.com>
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

On error can_create() frees the allocated sk object, but sock_init_data()
has already attached it to the provided sock object. This will leave a
dangling sk pointer in the sock object and may cause use-after-free later.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/can/af_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 707576eeeb58..01f3fbb3b67d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -171,6 +171,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		/* release sk on errors */
 		sock_orphan(sk);
 		sock_put(sk);
+		sock->sk = NULL;
 	}
 
  errout:
-- 
2.39.5

