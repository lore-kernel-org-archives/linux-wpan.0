Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704ED3955F3
	for <linux-wpan@vger.kernel.org>; Sat, 19 Sep 2026 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853342; cv=none; b=a+hX5T9LkAmfX5pyb+/AYES2VOCCgBsYgQ2mzSnR3ezmluaNinSdvjS8kNkW2GMlxFisR7ozphyp8v3UU5Ho9f0zy45xMBR9TDgbgQCNjTl01EqFSgbDiaVtJRb5Z4Tq7BJZNY8fj3xgBam8seBzHCuSn5VOge1UFq+Gf+w6i6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853342; c=relaxed/simple;
	bh=uzB8kYqSwZvvHWdVSonXqwgcJ53XrnKH2GGFgTD34aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osvpMd6rd3Ykutl5tFsXNhQ58tXEUjKa6aNzzAnh1uMyDA7nXajrR2LhUTyZo4t+gCy6vZsIKWcJnR6wwrI0wDBJVGoMIT2w1tEjhJ5LR5aB826YsZeG1I1MUQJwMyNQjDMyY5mbLX6X8xnq8H0TCz3JDZi5aRNahFJWO2Sdhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPgjUUNG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPgjUUNG"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1351749a91.3
        for <linux-wpan@vger.kernel.org>; Sat, 19 Sep 2026 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853336; x=1790458136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ysTxERdXo3UK3i3xCiazMgzFqeboSXwQYQC9nO77h0=;
        b=HPgjUUNGiawKAiSzn5NHo2pAbh0y4wrQAIo4pyQRcu5yM+e94lVjkXUmgNEMyKQWVY
         Ssyqy+iwtce2U1cw17Q6WxS5la3sM8W3ybY7YQ5R25W5UBE1iuXNLFr6v2bzNrCEwrn9
         RDNsBRm4S875g+dzhKtmLh8DwzizlagHLJm6f47Ad6qptP6LQPmn49WXxf69rDrJCLz+
         eg5G+8icGwvTlIHjS7FJS2MHtKF0a0TgpR/9q+LcfbKmsFsH/kZz1KJmETJQW2ehWGeT
         J1Uqgy37TtyBdbWFbx5ms2+0/BF0PSrsXHYTJMv2DnVg/E1CztbcNY5BsooJAFrByvsb
         E0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853336; x=1790458136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ysTxERdXo3UK3i3xCiazMgzFqeboSXwQYQC9nO77h0=;
        b=XPsNRi9SZWxu32ashnCCNmkoC/05zdKPR4IpWXTKs4s2WH4T6gnCcRZ0nAFE781Pg9
         d1CQJHU+bgpeSG7w/xNMvvK8ITLspUxnvt9qVFPw+ZgJFitpyEaSEZtwCNh06bm9eCa5
         Z13zDld+CQOY3hfqK6uEEcvvBE5GqUwamVNamp0iXZ1uqPll+6JqXfZxA0OwQuW5Hi3b
         deBH91M5eLzvQiWL+8h0GwQpaKxUscRp8Cah4t6QUHmO2/tylpkFnGtXfKVyxEcq5Kwn
         XZNPtBJ+96A4dVmX4kRWPdXwvwiBKZ9oJ/jrq0NdAq9sBtatysF4tH5W7Mh+foTXYBKJ
         Ldwg==
X-Forwarded-Encrypted: i=1; AKwUvBw0iB3FamFbzVTWEZKu0ZOujkTwDfiAsVb0MSli5AvwE9H2TKM9ARsCDWxVz0H1bpr0QNqT7UsjUI93@vger.kernel.org
X-Gm-Message-State: AFuF++n/elARTi0xETsGAKhJJ6ubbYMgoZq9dN2XI/D4wfPJJwpaMQMf
	z4rd9powozIyYIgkpVmJtivxBjLH5puPi9po1sZoy5pokGTs3yLzqikK
X-Gm-Gg: AYBFou3ouiyJ7iVVEHoIMVQiVCgXk1ybHuuDx1YTk+EM2Qrc01sUM3loYj4UneWC4G2
	PSfqcGEZWi2tBHJTBuFZEBPuN7RORXpKsOWqV5DJ+movD4XdgRXuFaknL38ITszZ83Kw5agnoCw
	ODsQqG4RDpQtAq6AM0quX+lZ++LifmibkPRPTHQ2oTcDeg/zrxBWDyauX644wthFWeXwc/UFLwD
	H5PpSb0aIsxKK9HNK31E98xqlWfI7LlBH0C5tyCDwYyhAs2DYEkLEUP7I3gGe2/dAR+p6j+9SwF
	QWt2YvDXDBX50e37MBrga8+Szd/PuQH+1hJ0S942sIxUrvc5SWtI21RCCRIt7+p4PB7Qlgob6sK
	TP1fYDEsbNoSww3yE71d6gm6j6cqoofAw5lnWqWB/YYp2qKBTKa3+MHjDCAEQQrLqUQS5HvEqGn
	fzHFu7fPZGR+SUWcgfzgj8RTMIs+VjsKouhk1o4IAO3J8e1BDkZvrpuxSJB4/0NBBu8H9kufUcf
	BNPRaMu4A+tIn6AAwfosN4+qgoSYTGRTqP7hiWRdotgfciZXFrWjT9/qZ3l8tupuLdGO1iUJzik
	V4VA+m9UNw==
X-Received: by 2002:a17:90a:c105:b0:39e:6a81:f350 with SMTP id 98e67ed59e1d1-39e6a81fcc4mr4626297a91.42.1789853335756;
        Sat, 19 Sep 2026 14:28:55 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm5802399a91.0.2026.09.19.14.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:28:55 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: socket: fix shared skb BUG_ON and double header subtraction in dgram_ioctl()
Date: Sat, 19 Sep 2026 21:28:55 +0000
Message-ID: <20260919212855.3241205-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `dgram_ioctl()` (`SIOCINQ`), the queued skb at the head of
`sk->sk_receive_queue` has already had its MAC header stripped by
`ieee802154_subif_frame()` prior to `dgram_deliver()`, so `skb->len` is
already the exact payload length that `dgram_recvmsg()` will return to
userspace.

However, `dgram_ioctl()` computes `*karg = skb->len -
ieee802154_hdr_length(skb)`. Calling `ieee802154_hdr_length(skb)`
re-parses the payload bytes as an 802.15.4 MAC header and calls
`pskb_may_pull(skb, ...)` while holding `sk->sk_receive_queue.lock`.
When multiple `SOCK_DGRAM` sockets receive a cloned copy of the frame
(`skb_shared(skb)` is true) and the payload is non-linear,
`pskb_may_pull()` calls `pskb_expand_head()`, which triggers
`BUG_ON(skb_shared(skb))`. Even on unshared linear skbs, subtracting
`ieee802154_hdr_length(skb)` a second time underflows `*karg` to a
negative value when the payload is shorter than the bogus parsed header
length.

Set `*karg = skb->len` directly in `dgram_ioctl()`.

Fixes: e1d001fa5b47 ("net: ioctl: Use kernel memory on protocol ioctl callbacks")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/ieee802154/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 5a36e87893f6..8d660fe87d4e 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -552,7 +552,7 @@ static int dgram_ioctl(struct sock *sk, int cmd, int *karg)
 			 * of this packet since that is all
 			 * that will be read.
 			 */
-			*karg = skb->len - ieee802154_hdr_length(skb);
+			*karg = skb->len;
 		}
 		spin_unlock_bh(&sk->sk_receive_queue.lock);
 		return 0;
-- 
2.55.0.1082.g2b9226bbc0-goog

