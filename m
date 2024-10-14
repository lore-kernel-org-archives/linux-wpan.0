Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92471C9DFD
	for <linux-wpan@vger.kernel.org>; Mon, 14 Oct 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920319; cv=none; b=d3J45Wj/A2efVYRaQLa3bvvf3FB+nET+iqMB2Uv7qOWidtTjLkhmERqvp+rWkFNGDRNnElY2zxFoQaDbZOaTOSq6in/ZQuavs4Z2oXD/KanxcRzLgEpOWPOoqdZ0b0jLA84AWY29ZHsiZvoRkqjT8piOrnMf71iZodGQdOU7Q+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920319; c=relaxed/simple;
	bh=B2jIOs9L3gzL5PsTv6zAjfQ7uhJ1V7bXBI/aVWUwbYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEyEW7ValQQ4NakAqHkDP6wHicDOgeLvxd+JEMSO05WCAmSM6VP2ZBwcYDSYtbkRP08J5102uxuJSUB7rvac60gJ8w///m+a92ZVA9P6J9Hq4Ert4NfH/aV1JQir7JFDRhJ+6sZYKs51iYTZoIikTqaiuVsDVl9bKmKG63E3SV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SPE1k1J7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SPE1k1J7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so30789255e9.3
        for <linux-wpan@vger.kernel.org>; Mon, 14 Oct 2024 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920316; x=1729525116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc//y1BjgJvxxX3rGB4aDZ3xX09SUgENBX50qA84hL0=;
        b=SPE1k1J7Xyw6fn9/LNdrjheqnufXMsYV46py4ESfUl8mdSQlzej5qYsDZxYEqdy3Up
         lST2arihYhJAwrVaDiWxPAFAr4Kt4TnwUQphBB3t4qBwZYf1XR3RwMypulxICZ3wuFBd
         uuWzv8EwfsWL4c32V/yhFBeLUCCJGJIqzyhx/JssqBwUi4gXm/ldf5EUnFUgUBtqenBj
         EPr/x3GYJnXxTHj31QR3Modr7kjEEwkfF7siPzXobiFKcN3OktPrDOhQCo9rb5onB6+c
         G7h/H0h3VT7biQSEsl7BXXKHnMFuRWKbaC9AG2jhYAwwEd7N3E9fIgoJOP9oEFjoxwWb
         r+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920316; x=1729525116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc//y1BjgJvxxX3rGB4aDZ3xX09SUgENBX50qA84hL0=;
        b=Qnmt2YeWqldWfnUCczeOTTk6jDiGftgYy35PWR1h4p1GgsbpuECz8pPekcHXu+tiMb
         RbyUJbGg1LskQAR3kow2o6J46oTUvybME2yqT/56Tt+FBBvKwNvvkjF9pd0UXmyGpQzX
         drv20x3QGFqaCMVemG/eF3uFb8SxzbAAXfvTtAH9XBzf6FWXV5vw8cajpCR62/lQzDc3
         sAq8Pq4p0dCuYTk4gG41ZEyrQnV+/NtaPWhd1g1d/UhyHOqgke2xsVBNzKFqPgo8b6v1
         o2TDYx2F1ukGfkqbNKBkobxHSWOZjoMoBrEwy/el54tWY6VtIJ6bQtS3/e1A43OWa/4E
         qKcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRMhQvouMfqJ1kZPFiTWSnJY9wuqBWCgyFK3fG3II8CtrUXfJKcpN4B4YNNdE9kAJmwex30x1mfC9t@vger.kernel.org
X-Gm-Message-State: AOJu0Yys95h2Rdq4zCmu5wtQnv6BvedaR7zwQDY77P72YQqhkdJtsDYF
	Fx5iC7clEPd6n30xMEPSwtVLi2XMJstxoETOVCO8ZYyJNZ2khIpRsoajItWjZsc=
X-Google-Smtp-Source: AGHT+IEIDg1NkYP+jkdfN8/Qy2bbNOJCew4tzqQ4wU+J4Bx2YgcvD/tGgxkQdWC68y3Hu3c+jOjjEA==
X-Received: by 2002:a05:600c:1d0b:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-4311ded4265mr95708305e9.8.1728920315951;
        Mon, 14 Oct 2024 08:38:35 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:35 -0700 (PDT)
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
Subject: [PATCH net-next v3 7/9] net: inet6: do not leave a dangling sk pointer in inet6_create()
Date: Mon, 14 Oct 2024 16:38:06 +0100
Message-Id: <20241014153808.51894-8-ignat@cloudflare.com>
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

sock_init_data() attaches the allocated sk pointer to the provided sock
object. If inet6_create() fails later, the sk object is released, but the
sock object retains the dangling sk pointer, which may cause use-after-free
later.

Clear the sock sk pointer on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/ipv6/af_inet6.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index ba69b86f1c7d..f60ec8b0f8ea 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -252,31 +252,29 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		 */
 		inet->inet_sport = htons(inet->inet_num);
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
 
 static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
-- 
2.39.5

